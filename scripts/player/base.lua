require("config")
require("actionTypes")
require("patterns")
stateHelper = require("stateHelper")
tableHelper = require("tableHelper")
menuHelper = require("menuHelper")
local BasePlayer = class("BasePlayer")

function BasePlayer:__init(pid, playerName)
    self.dbPid = nil

    self.data =
    {
        login = {
            name = "",
            password = ""
        },
        settings = {
            admin = 0,
            difficulty = "default",
            consoleAllowed = "default",
            bedRestAllowed = "default",
            wildernessRestAllowed = "default",
            waitAllowed = "default"
        },
        character = {
            race = "",
            head = "",
            hair = "",
            gender = 1,
            class = "",
            birthsign = ""
        },
        location = {
            cell = "",
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotZ = 0
        },
        stats = {
            level = 1,
            levelProgress = 0,
            healthBase = 1,
            healthCurrent = 1,
            magickaBase = 1,
            magickaCurrent = 1,
            fatigueBase = 1,
            fatigueCurrent = 1,
            bounty = 0
        },
        customClass = {},
        attributes = {},
        attributeSkillIncreases = {},
        skills = {},
        skillProgress = {},
        equipment = {},
        inventory = {},
        spellbook = {},
        quickKeys = {},
        shapeshift = {},
        journal = {},
        factionRanks = {},
        factionExpulsion = {},
        factionReputation = {},
        topics = {},
        books = {},
        mapExplored = {},
        ipAddresses = {},
        customVariables= {}
    };

    for i = 0, (tes3mp.GetAttributeCount() - 1) do
        local attributeName = tes3mp.GetAttributeName(i)
        self.data.attributes[attributeName] = 1
        self.data.attributeSkillIncreases[attributeName] = 0
    end

    for i = 0, (tes3mp.GetSkillCount() - 1) do
        local skillName = tes3mp.GetSkillName(i)
        self.data.skills[skillName] = 1
        self.data.skillProgress[skillName] = 0
    end

    self.initTimestamp = os.time()

    if playerName == nil then
        self.accountName = tes3mp.GetName(pid)
    else
        self.accountName = playerName
    end

    self.pid = pid
    self.loggedIn = false
    self.tid_login = nil
    self.admin = 0
    self.hasAccount = nil -- TODO Check whether account file exists

    self.cellsLoaded = {}
end

function BasePlayer:Destroy()
    if self.tid_login ~= nil then
        tes3mp.StopTimer(self.tid_login)
        self.tid_login = nil
    end

    self.loggedIn = false
    self.hasAccount = nil
end

function BasePlayer:Kick()
    self:Destroy()
    tes3mp.Kick(self.pid)
end

function BasePlayer:Registered(passw)
    self.loggedIn = true
    self.data.login.password = passw
    self.data.settings.consoleAllowed = "default"
	
	if self.hasAccount == false then -- create account
        tes3mp.SetCharGenStage(self.pid, 1, 4)
    end
end

function BasePlayer:FinishLogin()
    self.loggedIn = true
    if self.hasAccount ~= false then -- load account
        self:SaveIpAddress()
        self:LoadCharacter()
        self:LoadClass()
        self:LoadLevel()
        self:LoadAttributes()
        self:LoadSkills()
        self:LoadStatsDynamic()
        self:LoadBounty()
        self:LoadCell()
        self:LoadInventory()
        self:LoadEquipment()
        self:LoadSpellbook()
        self:LoadQuickKeys()
        self:LoadBooks()
        --self:LoadMap()
        self:LoadShapeshift()
        self:LoadSettings()

        if config.shareJournal == true then
			WorldInstance:LoadJournal(self.pid)
		else
			self:LoadJournal()
		end

        if config.shareFactionRanks == true then
            WorldInstance:LoadFactionRanks(self.pid)
        else
            self:LoadFactionRanks()
        end

        if config.shareFactionExpulsion == true then
            WorldInstance:LoadFactionExpulsion(self.pid)
        else
            self:LoadFactionExpulsion()
        end

        if config.shareFactionReputation == true then
            WorldInstance:LoadFactionReputation(self.pid)
        else
            self:LoadFactionReputation()
        end

        if config.shareTopics == true then
            WorldInstance:LoadTopics(self.pid)
        else
            self:LoadTopics()
        end

        WorldInstance:LoadKills(self.pid)
		self.currentCustomMenu = "initial help"
        menuHelper.displayMenu(self.pid, self.currentCustomMenu)
    end
end

function BasePlayer:EndCharGen()
    self:SaveLogin()
    self:SaveCharacter()
    self:SaveClass()
    self:SaveStatsDynamic()
    self:SaveEquipment()
    self:SaveIpAddress()
    self:CreateAccount()

    if config.shareJournal == true then
		WorldInstance:LoadJournal(self.pid)
	end
	
	if	config.shareFactionRanks == true then
        WorldInstance:LoadFactionRanks(self.pid)
    end

    if config.shareFactionExpulsion == true then
        WorldInstance:LoadFactionExpulsion(self.pid)
    end

    if config.shareFactionReputation == true then
        WorldInstance:LoadFactionReputation(self.pid)
    end

    if config.shareTopics == true then
        WorldInstance:LoadTopics(self.pid)
    end
    
    WorldInstance:LoadKills(self.pid)
---------------------------------------Home Cities----------------------------------------------

	  if self.data.homecity ~= nil and config.homecitySpawns[self.data.homecity] ~= nil then

        local homecitySpawn = config.homecitySpawns[self.data.homecity]

			tes3mp.SetCell(self.pid, homecitySpawn.cell)
			tes3mp.SendCell(self.pid)

			 if config.defaultSpawnPos ~= nil and config.defaultSpawnRot ~= nil then
            tes3mp.SetPos(self.pid, homecitySpawn.pos[1], homecitySpawn.pos[2], homecitySpawn.pos[3])
            tes3mp.SetRot(self.pid, homecitySpawn.rot[1], homecitySpawn.rot[2])
            tes3mp.SendPos(self.pid)
        end   

		elseif config.defaultSpawnCell ~= nil then

			tes3mp.SetCell(self.pid, config.defaultSpawnCell)
			tes3mp.SendCell(self.pid)

			if config.defaultSpawnPos ~= nil and config.defaultSpawnRot ~= nil then
				tes3mp.SetPos(self.pid, config.defaultSpawnPos[1], config.defaultSpawnPos[2], config.defaultSpawnPos[3])
				tes3mp.SetRot(self.pid, config.defaultSpawnRot[1], config.defaultSpawnRot[2])
				tes3mp.SendPos(self.pid)
			end
		end
------------------------------------Starting Items---------------------------------------
    if config.shareJournal == false and WorldInstance.data.customVariables ~= nil then
        if WorldInstance.data.customVariables.deliveredCaiusPackage ~= true then
            local item = { refId = "bk_a1_1_caiuspackage", count = 1, charge = -1 }
            table.insert(self.data.inventory, item)
            local item2 = { refId = "Gold_001", count = 50, charge = -1 }
			table.insert(self.data.inventory, item2)
			local item5 = { refId = "pick_apprentice_01", count = 3, charge = -1 }
			table.insert(self.data.inventory, item5)
			self:LoadInventory()
            self:LoadEquipment()
            tes3mp.MessageBox(self.pid, -1, "Multiplayer skips over the original character generation.\n\nAs a result, you start out with Caius Cosades' package.")
        end
    end
	 
end

function BasePlayer:IsLoggedIn()
    return self.loggedIn
	end

function BasePlayer:IsAdmin()
    return self.data.settings.admin == 2
end

function BasePlayer:IsModerator()
    return self.data.settings.admin >= 1
end

function BasePlayer:PromoteModerator(other)
    if self.IsAdmin() then
        other.data.settings.admin = 1
        return true
    end
    return false
end

function BasePlayer:GetHealthCurrent()
    self.data.stats.healthCurrent = tes3mp.GetHealthCurrent(self.pid)
    return self.data.stats.healthCurrent
end

function BasePlayer:SetHealthCurrent(health)
    self.data.stats.healthCurrent = health
    tes3mp.SetHealthCurrent(self.pid, health)
end

function BasePlayer:GetHealthBase()
    self.data.stats.healthBase = tes3mp.GetHealthBase(self.pid)
    return self.data.stats.healthBase
end

function BasePlayer:SetHealthBase(health)
    self.data.stats.healthBase = health
    tes3mp.SetHealthBase(self.pid, health)
end

function BasePlayer:HasAccount()
    return self.hasAccount
end

function BasePlayer:Message(message)
    tes3mp.SendMessage(self.pid, message, false)
end

function BasePlayer:CreateAccount()
    error("Not implemented")
end

function BasePlayer:Save()
    error("Not implemented")
end

function BasePlayer:Load()
    error("Not implemented")
end

function BasePlayer:SaveLogin()
    self.data.login.name = tes3mp.GetName(self.pid)
end

function BasePlayer:SaveIpAddress()
    if self.data.ipAddresses == nil then
        self.data.ipAddresses = {}
    end

    local ipAddress = tes3mp.GetIP(self.pid)

    if tableHelper.containsValue(self.data.ipAddresses, ipAddress) == false then
        table.insert(self.data.ipAddresses, ipAddress)
    end
end

function BasePlayer:ProcessDeath()

    local deathReason = tes3mp.GetDeathReason(self.pid)

    tes3mp.LogMessage(1, "Original death reason was " .. deathReason)

    if deathReason == "suicide" then
        deathReason = "committed suicide"
    else
        deathReason = "was killed by " .. deathReason
    end

    local message = ("%s (%d) %s"):format(self.data.login.name, self.pid, deathReason)
-------------------------------------Respawn Timer--------------------------------------
    message = message .. ".\n"
    tes3mp.SendMessage(self.pid, message, true)
	local resurrectionTime=self.data.stats.level + 9
    self.tid_resurrect = tes3mp.CreateTimerEx("OnDeathTimeExpiration", time.seconds(resurrectionTime), "i", self.pid)
    tes3mp.CustomMessageBox(self.pid, -1, "You will respawn in " .. resurrectionTime .. " seconds\n", "Ok")
	tes3mp.StartTimer(self.tid_resurrect)
end

function BasePlayer:Resurrect()

    local currentResurrectType

    if config.respawnAtImperialShrine == true then
        if config.respawnAtTribunalTemple == true then
            if math.random() > 0.5 then
                currentResurrectType = actionTypes.resurrect.IMPERIAL_SHRINE
            else
                currentResurrectType = actionTypes.resurrect.TRIBUNAL_TEMPLE
            end
        else
            currentResurrectType = actionTypes.resurrect.IMPERIAL_SHRINE
        end

    elseif config.respawnAtTribunalTemple == true then
        currentResurrectType = actionTypes.resurrect.TRIBUNAL_TEMPLE
	
	elseif self.data.homecity ~= nil and config.homecitySpawns[self.data.homecity] ~= nil then

        currentResurrectType = actionTypes.resurrect.REGULAR
        local homecitySpawn = config.homecitySpawns[self.data.homecity]

        tes3mp.SetCell(self.pid, homecitySpawn.cell)
        tes3mp.SendCell(self.pid)

        if homecitySpawn.pos ~= nil and homecitySpawn.rot ~= nil then
            tes3mp.SetPos(self.pid, homecitySpawn.pos[1], homecitySpawn.pos[2], homecitySpawn.pos[3])
            tes3mp.SetRot(self.pid, homecitySpawn.rot[1], homecitySpawn.rot[2])
            tes3mp.SendPos(self.pid)
        end

    elseif config.defaultRespawnCell ~= nil then
        currentResurrectType = actionTypes.resurrect.REGULAR

        tes3mp.SetCell(self.pid, config.defaultRespawnCell)
        tes3mp.SendCell(self.pid)

        if config.defaultRespawnPos ~= nil and config.defaultRespawnRot ~= nil then
            tes3mp.SetPos(self.pid, config.defaultRespawnPos[1], config.defaultRespawnPos[2], config.defaultRespawnPos[3])
            tes3mp.SetRot(self.pid, config.defaultRespawnRot[1], config.defaultRespawnRot[2])
            tes3mp.SendPos(self.pid)
        end
    end

    local message = "You have been revived"

    if currentResurrectType == actionTypes.resurrect.IMPERIAL_SHRINE then
        message = message .. " at the nearest Imperial shrine"
    elseif currentResurrectType == actionTypes.resurrect.TRIBUNAL_TEMPLE then
        message = message .. " at the nearest Tribunal temple"
    end

    message = message .. ".\n"

    -- Ensure that dying as a werewolf turns you back into your normal form
    if self.data.shapeshift.isWerewolf == true then
        self:SetWerewolfState(false)
    end

    -- Ensure that we unequip deadly items when applicable, to prevent an
    -- infinite death loop
    questFixer.UnequipDeadlyItems(self.pid)

    tes3mp.Resurrect(self.pid, currentResurrectType)

    if config.deathPenaltyJailDays > 0 then
        tes3mp.Jail(self.pid, config.deathPenaltyJailDays, true, true, "Recovering", "You've been revived and brought back here, but your skills have been affected by your time spent incapacitated.")
    end

    tes3mp.SendMessage(self.pid, message, false)
end

function BasePlayer:LoadCharacter()
    tes3mp.SetRace(self.pid, self.data.character.race)
    tes3mp.SetHead(self.pid, self.data.character.head)
    tes3mp.SetHair(self.pid, self.data.character.hair)
    tes3mp.SetIsMale(self.pid, self.data.character.gender)
    tes3mp.SetBirthsign(self.pid, self.data.character.birthsign)

    tes3mp.SendBaseInfo(self.pid)
end

function BasePlayer:SaveCharacter()
    self.data.character.race = tes3mp.GetRace(self.pid)
    self.data.character.head = tes3mp.GetHead(self.pid)
    self.data.character.hair = tes3mp.GetHair(self.pid)
    self.data.character.gender = tes3mp.GetIsMale(self.pid)
    self.data.character.birthsign = tes3mp.GetBirthsign(self.pid)
end

function BasePlayer:LoadClass()
    if self.data.character.class ~= "custom" then
        tes3mp.SetDefaultClass(self.pid, self.data.character.class)
    elseif self.data.customClass ~= nil then
        tes3mp.SetClassName(self.pid, self.data.customClass.name)
        tes3mp.SetClassSpecialization(self.pid, self.data.customClass.specialization)

        if self.data.customClass.description ~= nil then
            tes3mp.SetClassDesc(self.pid, self.data.customClass.description)
        end

        local i = 0
        for value in string.gmatch(self.data.customClass.majorAttributes, patterns.commaSplit) do
            tes3mp.SetClassMajorAttribute(self.pid, i, tes3mp.GetAttributeId(value))
            i = i + 1
        end

        i = 0
        for value in string.gmatch(self.data.customClass.majorSkills, patterns.commaSplit) do
            tes3mp.SetClassMajorSkill(self.pid, i, tes3mp.GetSkillId(value))
            i = i + 1
        end

        i = 0
        for value in string.gmatch(self.data.customClass.minorSkills, patterns.commaSplit) do
            tes3mp.SetClassMinorSkill(self.pid, i, tes3mp.GetSkillId(value))
            i = i + 1
        end
    end

    tes3mp.SendClass(self.pid)
end

function BasePlayer:SaveClass()
    if tes3mp.IsClassDefault(self.pid) == 1 then
        self.data.character.class = tes3mp.GetDefaultClass(self.pid)
    else
        self.data.character.class = "custom"
        self.data.customClass.name = tes3mp.GetClassName(self.pid)
        self.data.customClass.description = tes3mp.GetClassDesc(self.pid):gsub("\n", "\\n")
        self.data.customClass.specialization = tes3mp.GetClassSpecialization(self.pid)
        local majorAttributes = {}
        local majorSkills = {}
        local minorSkills = {}

        for i = 0, 1, 1 do
            majorAttributes[i + 1] = tes3mp.GetAttributeName(tonumber(tes3mp.GetClassMajorAttribute(self.pid, i)))
        end

        for i = 0, 4, 1 do
            majorSkills[i + 1] = tes3mp.GetSkillName(tonumber(tes3mp.GetClassMajorSkill(self.pid, i)))
            minorSkills[i + 1] = tes3mp.GetSkillName(tonumber(tes3mp.GetClassMinorSkill(self.pid, i)))
        end

        self.data.customClass.majorAttributes = table.concat(majorAttributes, ", ")
        self.data.customClass.majorSkills = table.concat(majorSkills, ", ")
        self.data.customClass.minorSkills = table.concat(minorSkills, ", ")
    end
end

function BasePlayer:LoadStatsDynamic()
    tes3mp.SetHealthBase(self.pid, self.data.stats.healthBase)
    tes3mp.SetMagickaBase(self.pid, self.data.stats.magickaBase)
    tes3mp.SetFatigueBase(self.pid, self.data.stats.fatigueBase)
    tes3mp.SetHealthCurrent(self.pid, self.data.stats.healthCurrent)
    tes3mp.SetMagickaCurrent(self.pid, self.data.stats.magickaCurrent)
    tes3mp.SetFatigueCurrent(self.pid, self.data.stats.fatigueCurrent)

    tes3mp.SendStatsDynamic(self.pid)
end

function BasePlayer:SaveStatsDynamic()
    self.data.stats.healthBase = tes3mp.GetHealthBase(self.pid)
    self.data.stats.magickaBase = tes3mp.GetMagickaBase(self.pid)
    self.data.stats.fatigueBase = tes3mp.GetFatigueBase(self.pid)
    self.data.stats.healthCurrent = tes3mp.GetHealthCurrent(self.pid)
    self.data.stats.magickaCurrent = tes3mp.GetMagickaCurrent(self.pid)
    self.data.stats.fatigueCurrent = tes3mp.GetFatigueCurrent(self.pid)
end

function BasePlayer:LoadAttributes()
    for name, value in pairs(self.data.attributes) do
        tes3mp.SetAttributeBase(self.pid, tes3mp.GetAttributeId(name), value)
    end

    tes3mp.SendAttributes(self.pid)
end

function BasePlayer:SaveAttributes()

    local reloadAtEnd = false

    for name in pairs(self.data.attributes) do

        local attributeId = tes3mp.GetAttributeId(name)

        local baseValue = tes3mp.GetAttributeBase(self.pid, attributeId)
        local modifierValue = tes3mp.GetAttributeModifier(self.pid, attributeId)
        local maxAttributeValue = config.maxAttributeValue

        if name == "Speed" then
            maxAttributeValue = config.maxSpeedValue
        end

        if baseValue > maxAttributeValue then
            self:LoadAttributes()

            local message = "Your base " .. name .. " has exceeded the maximum allowed value and been reset to its last recorded one.\n"
            tes3mp.SendMessage(self.pid, message)
        elseif (baseValue + modifierValue) > maxAttributeValue then
            tes3mp.ClearAttributeModifier(self.pid, attributeId)
            tes3mp.SendAttributes(self.pid)

            local message = "Your " .. name .. " fortification has exceeded the maximum allowed value and been removed.\n"
            tes3mp.SendMessage(self.pid, message)
        else
            if name == "Speed" then
                self.data.attributes[name] = 150
                reloadAtEnd = true
            else
                self.data.attributes[name] = baseValue
            end
        end
    end

    if reloadAtEnd then
        self:LoadAttributes()
    end
end

function BasePlayer:LoadSkills()
    for name, value in pairs(self.data.skills) do
        tes3mp.SetSkillBase(self.pid, tes3mp.GetSkillId(name), value)
    end

    for name, value in pairs(self.data.skillProgress) do
        tes3mp.SetSkillProgress(self.pid, tes3mp.GetSkillId(name), value)
    end

    for name, value in pairs(self.data.attributeSkillIncreases) do
        tes3mp.SetSkillIncrease(self.pid, tes3mp.GetAttributeId(name), value)
    end

    tes3mp.SetLevelProgress(self.pid, self.data.stats.levelProgress)
    tes3mp.SendSkills(self.pid)
end

function BasePlayer:SaveSkills()
    for name in pairs(self.data.skills) do

        local skillId = tes3mp.GetSkillId(name)

        local baseValue = tes3mp.GetSkillBase(self.pid, skillId)
        local modifierValue = tes3mp.GetSkillModifier(self.pid, skillId)
        local maxSkillValue = config.maxSkillValue

        if name == "Acrobatics" then
            maxSkillValue = config.maxAcrobaticsValue
        end

        if baseValue > maxSkillValue then
            self:LoadSkills()

            local message = "Your base " .. name .. " has exceeded the maximum allowed value and been reset to its last recorded one.\n"
            tes3mp.SendMessage(self.pid, message)
        elseif (baseValue + modifierValue) > maxSkillValue then
            tes3mp.ClearSkillModifier(self.pid, skillId)
            tes3mp.SendSkills(self.pid)

            local message = "Your " .. name .. " fortification has exceeded the maximum allowed value and been removed.\n"
            tes3mp.SendMessage(self.pid, message)
        else
            self.data.skills[name] = baseValue
            self.data.skillProgress[name] = tes3mp.GetSkillProgress(self.pid, skillId)
        end 
    end

    for name in pairs(self.data.attributeSkillIncreases) do
        local attributeId = tes3mp.GetAttributeId(name)
        self.data.attributeSkillIncreases[name] = tes3mp.GetSkillIncrease(self.pid, attributeId)
    end

    self.data.stats.levelProgress = tes3mp.GetLevelProgress(self.pid)
end

function BasePlayer:LoadLevel()
    tes3mp.SetLevel(self.pid, self.data.stats.level)
    tes3mp.SendLevel(self.pid)
end
------------Player Difficulty setting---------------------
function BasePlayer:SaveLevel()
    self.data.stats.level = tes3mp.GetLevel(self.pid)
	self.data.settings.difficulty = 4 * (self.data.stats.level - 1) + 20
	--	self.data.settings.difficulty = 4 * (self.data.stats.level - 1)
	self:LoadSettings()
end

function BasePlayer:LoadBounty()
    tes3mp.SetBounty(self.pid, self.data.stats.bounty)
    tes3mp.SendBounty(self.pid)
end

function BasePlayer:SaveBounty()
    self.data.stats.bounty = tes3mp.GetBounty(self.pid)
end

function BasePlayer:LoadShapeshift()

    if self.data.shapeshift == nil then
        self.data.shapeshift = {}
    end

    if self.data.shapeshift.isWerewolf == true then
        tes3mp.SetWerewolfState(self.pid, true)
        tes3mp.SendShapeshift(self.pid)
    end
end

function BasePlayer:SaveShapeshift()

    if self.data.shapeshift == nil then
        self.data.shapeshift = {}
    end

    self.data.shapeshift.isWerewolf = tes3mp.IsWerewolf(self.pid)
end

function BasePlayer:LoadCell()
    local newCell = self.data.location.cell

    if newCell ~= nil then

        tes3mp.SetCell(self.pid, newCell)

        local pos = {0, 0, 0}
        local rot = {0, 0}
        pos[0] = self.data.location.posX
        pos[1] = self.data.location.posY
        pos[2] = self.data.location.posZ
        rot[0] = self.data.location.rotX
        rot[1] = self.data.location.rotZ

        tes3mp.SetPos(self.pid, pos[0], pos[1], pos[2])
        tes3mp.SetRot(self.pid, rot[0], rot[1])

        tes3mp.SendCell(self.pid)
        tes3mp.SendPos(self.pid)
    end
end

function BasePlayer:SaveCell()

    -- Keep this around to update old player files
    if self.data.mapExplored == nil then
        self.data.mapExplored = {}
    end

    local cell = tes3mp.GetCell(self.pid)

    self.data.location.cell = cell
    self.data.location.posX = tes3mp.GetPosX(self.pid)
    self.data.location.posY = tes3mp.GetPosY(self.pid)
    self.data.location.posZ = tes3mp.GetPosZ(self.pid)
    self.data.location.rotX = tes3mp.GetRotX(self.pid)
    self.data.location.rotZ = tes3mp.GetRotZ(self.pid)

    if tes3mp.IsInExterior(self.pid) == true then

        if tableHelper.containsValue(self.data.mapExplored, cell) == false then
            table.insert(self.data.mapExplored, cell)
        end
    end
end

function BasePlayer:LoadEquipment()

    for i = 0, tes3mp.GetEquipmentSize() - 1 do

        local currentItem = self.data.equipment[i]

        if currentItem ~= nil then
            if currentItem.enchantmentCharge == nil then
                currentItem.enchantmentCharge = -1
            end

            tes3mp.EquipItem(self.pid, i, currentItem.refId, currentItem.count, currentItem.charge, currentItem.enchantmentCharge)
        else
            tes3mp.UnequipItem(self.pid, i)
        end
    end

    tes3mp.SendEquipment(self.pid)
end
----------------------------------------------------Banned Items------------------------------------------------------
function BasePlayer:SaveEquipment()

    local bannedItemIds = { "boots of blinding speed[unique]", "helseth's ring", "amulet of shadows", "bm_ebonyarrow_s", "bm_nordic01_robe_whitewalk" }
    local reloadAtEnd = false

    self.data.equipment = {}

    for i = 0, tes3mp.GetEquipmentSize() - 1 do
        local itemRefId = tes3mp.GetEquipmentItemRefId(self.pid, i)

        if itemRefId ~= "" then
            if tableHelper.containsValue(bannedItemIds, itemRefId) then
                self:Message("You have tried wearing an item that isn't allowed!\n")
                reloadAtEnd = true
            else
                self.data.equipment[i] = {
                    refId = itemRefId,
                    count = tes3mp.GetEquipmentItemCount(self.pid, i),
                    charge = tes3mp.GetEquipmentItemCharge(self.pid, i),
                    enchantmentCharge = tes3mp.GetEquipmentItemEnchantmentCharge(self.pid, i)
                }
            end
        end
    end

    if reloadAtEnd then
        myMod.RunConsoleCommandOnPlayer(self.pid, "tm")
        self:LoadEquipment()
        myMod.RunConsoleCommandOnPlayer(self.pid, "tm")
    end
end

function BasePlayer:LoadInventory()

    if self.data.inventory == nil then
        self.data.inventory = {}
    end

    -- Send an empty initialized inventory to clear the player's existing items
    tes3mp.InitializeInventoryChanges(self.pid)
    tes3mp.SendInventoryChanges(self.pid)

    for index, currentItem in pairs(self.data.inventory) do

        if currentItem ~= nil then
            if currentItem.enchantmentCharge == nil then
                currentItem.enchantmentCharge = -1
            end

            tes3mp.AddItem(self.pid, currentItem.refId, currentItem.count, currentItem.charge, currentItem.enchantmentCharge)
        end
    end

    tes3mp.SendInventoryChanges(self.pid)
end

function BasePlayer:SaveInventory()

    self.data.inventory = {}

    for i = 0, tes3mp.GetInventoryChangesSize(self.pid) - 1 do
        local itemRefId = tes3mp.GetInventoryItemRefId(self.pid, i)

        if itemRefId ~= "" then
            self.data.inventory[i] = {
                refId = itemRefId,
                count = tes3mp.GetInventoryItemCount(self.pid, i),
                charge = tes3mp.GetInventoryItemCharge(self.pid, i),
                enchantmentCharge = tes3mp.GetInventoryItemEnchantmentCharge(self.pid, i)
            }
        end
    end
end

function BasePlayer:LoadSpellbook()

    if self.data.spellbook == nil then
        self.data.spellbook = {}
    end

    tes3mp.InitializeSpellbookChanges(self.pid)
    tes3mp.SetSpellbookChangesAction(self.pid, actionTypes.spellbook.SET)

    for index, currentSpell in pairs(self.data.spellbook) do

        if currentSpell ~= nil then
            tes3mp.AddSpell(self.pid, currentSpell.spellId)
        end
    end

    tes3mp.SendSpellbookChanges(self.pid)
end

function BasePlayer:AddSpells()

    for i = 0, tes3mp.GetSpellbookChangesSize(self.pid) - 1 do
        local spellId = tes3mp.GetSpellId(self.pid, i)

        -- Only add new spell if we don't already have it
        if tableHelper.containsKeyValue(self.data.spellbook, "spellId", spellId, true) == false then
            tes3mp.LogMessage(1, "Adding spell " .. spellId .. " to " .. tes3mp.GetName(self.pid))
            local newSpell = {}
            newSpell.spellId = spellId
            table.insert(self.data.spellbook, newSpell)
        end
    end
end

function BasePlayer:RemoveSpells()

    for i = 0, tes3mp.GetSpellbookChangesSize(self.pid) - 1 do
        local spellId = tes3mp.GetSpellId(self.pid, i)

        -- Only print spell removal if the spell actually exists
        if tableHelper.containsKeyValue(self.data.spellbook, "spellId", spellId, true) == true then
            tes3mp.LogMessage(1, "Removing spell " .. spellId .. " from " .. tes3mp.GetName(self.pid))
            local foundIndex = tableHelper.getIndexByNestedKeyValue(self.data.spellbook, "spellId", spellId)
            self.data.spellbook[foundIndex] = nil
        end
    end

    tableHelper.cleanNils(self.data.spellbook)
end

function BasePlayer:SetSpells()

    self.data.spellbook = {}
    self:AddSpells()
end

function BasePlayer:LoadQuickKeys()

    if self.data.quickKeys == nil then
        self.data.quickKeys = {}
    end

    tes3mp.InitializeQuickKeyChanges(self.pid)

    for slot, currentQuickKey in pairs(self.data.quickKeys) do

        if currentQuickKey ~= nil then
            tes3mp.AddQuickKey(self.pid, slot, currentQuickKey.keyType, currentQuickKey.itemId)
        end
    end

    tes3mp.SendQuickKeyChanges(self.pid)
end

function BasePlayer:SaveQuickKeys()

    for i = 0, tes3mp.GetQuickKeyChangesSize(self.pid) - 1 do

        local slot = tes3mp.GetQuickKeySlot(self.pid, i)

        self.data.quickKeys[slot] = {
            keyType = tes3mp.GetQuickKeyType(self.pid, i),
            itemId = tes3mp.GetQuickKeyItemId(self.pid, i)
        }
    end
end

function BasePlayer:LoadJournal()
    stateHelper:LoadJournal(self.pid, self)
end

function BasePlayer:SaveJournal()
    stateHelper:SaveJournal(self.pid, self)
end

function BasePlayer:LoadFactionRanks()
    stateHelper:LoadFactionRanks(self.pid, self)
end

function BasePlayer:SaveFactionRanks()
    stateHelper:SaveFactionRanks(self.pid, self)
end

function BasePlayer:LoadFactionExpulsion()
    stateHelper:LoadFactionExpulsion(self.pid, self)
end

function BasePlayer:SaveFactionExpulsion()
    stateHelper:SaveFactionExpulsion(self.pid, self)
end

function BasePlayer:LoadFactionReputation()
    stateHelper:LoadFactionReputation(self.pid, self)
end

function BasePlayer:SaveFactionReputation()
    stateHelper:SaveFactionReputation(self.pid, self)
end

function BasePlayer:LoadTopics()
    stateHelper:LoadTopics(self.pid, self)
end

function BasePlayer:SaveTopics()
    stateHelper:SaveTopics(self.pid, self)
end

function BasePlayer:LoadBooks()

    if self.data.books == nil then
        self.data.books = {}
    end

    tes3mp.InitializeBookChanges(self.pid)

    for index, bookId in pairs(self.data.books) do

        tes3mp.AddBook(self.pid, bookId)
    end

    tes3mp.SendBookChanges(self.pid)
end

function BasePlayer:AddBooks()

    for i = 0, tes3mp.GetBookChangesSize(self.pid) - 1 do
        local bookId = tes3mp.GetBookId(self.pid, i)

        -- Only add new book if we don't already have it
        if tableHelper.containsValue(self.data.books, bookId, false) == false then
            tes3mp.LogMessage(1, "Adding book " .. bookId .. " to " .. tes3mp.GetName(self.pid))
            table.insert(self.data.books, bookId)
        end
    end
end

function BasePlayer:LoadMap()

    if self.data.mapExplored == nil then
        self.data.mapExplored = {}
    end

    tes3mp.InitializeMapChanges(self.pid)

    for index, cellDescription in pairs(self.data.mapExplored) do

        tes3mp.AddCellExplored(self.pid, cellDescription)
    end

    tes3mp.SendMapChanges(self.pid)
end

function BasePlayer:GetDifficulty(state)
    return self.data.settings.difficulty
end

function BasePlayer:GetConsoleAllowed(state)
    return self.data.settings.consoleAllowed
end

function BasePlayer:GetBedRestAllowed(state)
    return self.data.settings.bedRestAllowed
end

function BasePlayer:GetWildernessRestAllowed(state)
    return self.data.settings.wildernessRestAllowed
end

function BasePlayer:GetWaitAllowed(state)
    return self.data.settings.waitAllowed
end

function BasePlayer:SetDifficulty(difficulty)
    if difficulty == nil or difficulty == "default" then
        difficulty = config.difficulty
        self.data.settings.difficulty = "default"
    else
        self.data.settings.difficulty = difficulty
    end

    tes3mp.SetDifficulty(self.pid, difficulty)
    tes3mp.LogMessage(3, "Set difficulty to " .. tostring(difficulty) .. " for " .. self.pid)
end

function BasePlayer:SetConsoleAllowed(state)
    if state == nil or state == "default" then
        state = config.allowConsole
        self.data.settings.consoleAllowed = "default"
    else
        self.data.settings.consoleAllowed = state
    end

    tes3mp.SetConsoleAllowed(self.pid, state)
end

function BasePlayer:SetBedRestAllowed(state)
    if state == nil or state == "default" then
        state = config.allowBedRest
        self.data.settings.bedRestAllowed = "default"
    else
        self.data.settings.bedRestAllowed = state
    end

    tes3mp.SetBedRestAllowed(self.pid, state)
end

function BasePlayer:SetWildernessRestAllowed(state)
    if state == nil or state == "default" then
        state = config.allowWildernessRest
        self.data.settings.wildernessRestAllowed = "default"
    else
        self.data.settings.wildernessRestAllowed = state
    end

    tes3mp.SetWildernessRestAllowed(self.pid, state)
end

function BasePlayer:SetWaitAllowed(state)
    if state == nil or state == "default" then
        state = config.allowWait
        self.data.settings.waitAllowed = "default"
    else
        self.data.settings.waitAllowed = state
    end

    tes3mp.SetWaitAllowed(self.pid, state)
end

function BasePlayer:SetWerewolfState(state)
    self.data.shapeshift.isWerewolf = state

    tes3mp.SetWerewolfState(self.pid, state)
    tes3mp.SendShapeshift(self.pid)
end

function BasePlayer:LoadSettings()

    self:SetDifficulty(self.data.settings.difficulty)
    self:SetConsoleAllowed(self.data.settings.consoleAllowed)
    self:SetBedRestAllowed(self.data.settings.bedRestAllowed)
    self:SetWildernessRestAllowed(self.data.settings.wildernessRestAllowed)
    self:SetWaitAllowed(self.data.settings.waitAllowed)

    tes3mp.SendSettings(self.pid)
end

function BasePlayer:AddCellLoaded(cellDescription)

    -- Only add new loaded cell if we don't already have it
    if tableHelper.containsValue(self.cellsLoaded, cellDescription) == false then
        table.insert(self.cellsLoaded, cellDescription)
    end
end

function BasePlayer:RemoveCellLoaded(cellDescription)

    tableHelper.removeValue(self.cellsLoaded, cellDescription)
end

return BasePlayer

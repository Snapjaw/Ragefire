config = {}

-- The type of database or data format used by the server
-- Valid values: json, sqlite3
-- Note: The latter is only partially implemented as of now
config.databaseType = "json"

-- The location of the database file
-- Note: Not applicable when using json
config.databasePath = os.getenv("MOD_DIR") .. "/database.db" -- Path where database is stored

-- The order in which table keys should be saved to JSON files
config.playerKeyOrder = {"login", "settings", "character", "customClass", "location", "stats", "shapeshift", "attributes", "attributeSkillIncreases", "skills", "skillProgress", "equipment", "inventory", "spellbook", "books", "factionRanks", "factionReputation", "factionExpulsion", "mapExplored", "ipAddresses", "customVariables", "admin", "difficulty", "consoleAllowed", "bedRestAllowed", "wildernessRestAllowed", "waitAllowed", "gender", "race", "head", "hair", "class", "birthsign", "cell", "posX", "posY", "posZ", "rotX", "rotZ", "healthBase", "healthCurrent", "magickaBase", "magickaCurrent", "fatigueBase", "fatigueCurrent"}
config.worldKeyOrder = {"general", "topics", "kills", "journal", "customVariables", "type", "index", "quest", "actorRefId"}

-- Time to login, in seconds
config.loginTime = 60

-- The difficulty level used by default
-- Note: In OpenMW, the difficulty slider goes between -100 and 100, with 0 as the default,
--       though you can use any integer value here
config.difficulty = 0

-- Whether players should be allowed to use the ingame tilde (~) console by default
config.allowConsole = true

-- Whether players should be allowed to rest in bed by default
config.allowBedRest = true

-- Whether players should be allowed to rest in the wilderness by default
config.allowWildernessRest = true

-- Whether players should be allowed to wait by default
config.allowWait = false

-- Whether journal entries should be shared across the players on the server or not
config.shareJournal = false

-- Whether faction ranks should be shared across the players on the server or not
config.shareFactionRanks = false

-- Whether faction expulsion should be shared across the players on the server or not
config.shareFactionExpulsion = false

-- Whether faction reputation should be shared across the players on the server or not
config.shareFactionReputation = false

-- Whether dialogue topics should be shared across the players on the server or not
config.shareTopics = false

-- Time to stay dead before being respawned, in seconds
config.deathTime = 10
-- Spawn locations for different home cities, a custom addition by Snapjaw
config.homecitySpawns = {}
config.homecitySpawns["Caldera"] = {
    cell = "-2, 2",
    pos = { -12789.073242188, 20478.23046875, 1537 },
    rot = { 0, -75.636917 }
}
config.homecitySpawns["Balmora"] = {
    cell = "-3, -2",
    pos = { -23537, -16116, 505 },
    rot = { 0, 0 }
}
config.homecitySpawns["Seyda Neen"] = {
    cell = "-2, -9",
    pos = { -11173.67, -70825.265625, 228 },
    rot = { 0.0627148, -0.624551 }
}
config.homecitySpawns["Suran"] = {
    cell = "6, -7",
    pos = { 53369.47, -50588.0, 167.3029 },
    rot = { 0, -350 }
}


-- The cell that newly created players are teleported to
config.defaultSpawnCell = "-3, -2"

-- The X, Y and Z position that newly created players are teleported to
config.defaultSpawnPos = {-23980.693359375, -15561.556640625, 505}

-- The X and Z rotation that newly created players are assigned
config.defaultSpawnRot = {-0.000152587890625, 1.6182196140289}

-- The cell that players respawn in, unless overridden below by other respawn options
config.defaultRespawnCell = "Balmora, Temple"

-- The X, Y and Z position that players respawn in
config.defaultRespawnPos = {4700.5673828125, 3874.7416992188, 14758.990234375}

-- The X and Z rotation that respawned players are assigned
config.defaultRespawnRot = {0.25314688682556, 1.570611000061}

config.SeydaNeenRespawnCell = "-2, -9"

config.SeydaNeenRespawnPos = {-11173.670898438, -70825.265625, 228.06976318359}

config.SeydaNeenRespawnRot = {0.062714815139771, -0.62455177307129}
  

-- Whether the default respawn location should be ignored in favor of respawning the
-- player at the nearest Imperial shrine
config.respawnAtImperialShrine = false

-- Whether the default respawn location should be ignored in favor of respawning the
-- player at the nearest Tribunal temple
-- Note: When both this and the Imperial shrine option are enabled, there is a 50%
--       chance of the player being respawned at either
config.respawnAtTribunalTemple = false

-- The maximum value that any attribute except Speed is allowed to have
config.maxAttributeValue = 300

-- The maximum value that Speed is allowed to have
-- Note: Speed is given special treatment because of the Boots of Blinding Speed
config.maxSpeedValue = 365

-- The maximum value that any skill except Acrobatics is allowed to have
config.maxSkillValue = 500

-- The maximum value that Acrobatics is allowed to have
-- Note: Acrobatics is given special treatment because of the Scroll of Icarian Flight
config.maxAcrobaticsValue = 1400

-- The number of days spent in jail as a penalty for dying
config.deathPenaltyJailDays = 0

-- Whether players should be allowed to use the /suicide command
config.allowSuicideCommand = true

-- Whether time should be synchronized across clients
-- Valid values: 0, 1
-- Note: 0 for no time sync, 1 for time sync based on the server's time counter
config.timeSyncMode = 1 -- 0 - No time sync, 1 - Time sync based on server time counter

-- The time multiplier used by the server
-- Note: The default value of 1 is roughly 120 seconds per ingame hour
config.timeServerMult = 1

-- The initial ingame time on the server
config.timeServerInitTime = 6

-- Whether the server should enforce that all clients connect with a specific list of plugins
-- defined in data/pluginlist.json
-- Warning: Only set this to false if you trust the people connecting and are sure they know
--          what they're doing. Otherwise, you risk getting corrupt server data from
--          their usage of unshared plugins.
config.enforcePlugins = true

return config

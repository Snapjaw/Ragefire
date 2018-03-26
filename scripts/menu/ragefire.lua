Menus["initial help"] = {
    text = "Welcome to Ragefire\
        Version 1.0\
        ---------------------------------\
        This server is designed to be hard\
        \
        There is no Mudcrab, Creeper or Museum of Artifacts\
         \
        Gold drops from all monsters\
        --------------------------------\
        Discord = *Not yet implemented*\
        Reddit = *Not yet implemented*\
        -------------------------------\
        Leaderboards\
        *Not yet implemented*\
         \
        Type /help for all server info and commands",
    buttons = {
        { caption = "Exit", destinations = nil },
		{ caption = "Help Menu", destinations = { menuHelper.destinations.setDefault("help menu") } }
    }
}
Menus["choose homecity"] = {
    text = "Please select your home city.\
        You can change this later after you reach level 10.",
    buttons = {
        { caption = "Caldera",
            destinations = {
                menuHelper.destinations.setDefault("choose starting armor",
                {
                    menuHelper.effects.setDataVariable("homecity", "Caldera")
                })
            }
        },
        { caption = "Balmora",
            destinations = {
                menuHelper.destinations.setDefault("choose starting armor",
                {
                    menuHelper.effects.setDataVariable("homecity", "Balmora")
                })
            }
        },
        { caption = "Seyda Neen",
            destinations = {
                menuHelper.destinations.setDefault("choose starting armor",
                {
                    menuHelper.effects.setDataVariable("homecity", "Seyda Neen")
                })
            }
        },
        { caption = "Suran",
            destinations = {
                menuHelper.destinations.setDefault("choose starting armor",
                {
                    menuHelper.effects.setDataVariable("homecity", "Suran")
                })
            }
        }
    }
}
Menus["choose starting weapon"] = {
    text = "Please select your starting weapon.",
    buttons = {
        { caption = "Iron Broadsword",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("iron broadsword", 1),
					menuHelper.effects.runFunction("EndCharGen")
                })
            }
        },
        { caption = "Iron Shortsword",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("iron shortsword", 1),
					menuHelper.effects.runFunction("EndCharGen")
                })
            }
        },
        { caption = "Iron War Axe",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("iron war axe", 1),
					menuHelper.effects.runFunction("EndCharGen")
                })
            }
        },
        { caption = "Iron Mace",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("iron mace", 1),
					menuHelper.effects.runFunction("EndCharGen")
                   
                })
            }
        },
        { caption = "Iron Spear",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("iron spear", 1),
					menuHelper.effects.runFunction("EndCharGen")
                })
            }
        },
        { caption = "Short Bow",
            destinations = {
                menuHelper.destinations.setDefault("initial help",
                {
                    menuHelper.effects.giveItem("short bow", 1),
					menuHelper.effects.giveItem("iron arrow", 200), 
					menuHelper.effects.runFunction("EndCharGen")
                })
            }
        }
    }
}
Menus["choose starting armor"] = {
text = "Please select your starting armor.",
    buttons = {
        { caption = "Light",
            destinations = {
                menuHelper.destinations.setDefault("choose starting weapon",
                {
                    menuHelper.effects.giveItem("netch_leather_cuirass", 1),
					menuHelper.effects.giveItem("netch_leather_shield", 1),
                    
                })
            }
        },
        { caption = "Medium",
            destinations = {
                menuHelper.destinations.setDefault("choose starting weapon",
                {
                    menuHelper.effects.giveItem("nordic_ringmail_cuirass", 1),
					menuHelper.effects.giveItem("nordic_leather_shield", 1),
                   
                })
            }
        },
		{ caption = "Heavy",
            destinations = {
                menuHelper.destinations.setDefault("choose starting weapon",
                {
                    menuHelper.effects.giveItem("iron_cuirass", 1),
					menuHelper.effects.giveItem("iron_shield", 1),
                    
                })
            }
        }
	}
}
Menus["help menu"] = {
    text = "Welcome to Rage Fire!\
 \
  Server Commands\
 /home - Teleports you to your home city\
 /quest - Shows available custom quests\
 /crafting - Opens the Crafting Menu\
 ------------------------------------------------------------------------ \
\nCommand list:\
/message <pid> <text> - Send a private message to a player (/msg)\
/me <text> - Send a message written in the third person\
/local <text> - Send a message that only players in your area can read (/l)\
/list - List all players on the server\
/anim <animation> - Play an animation on yourself, with a list of valid inputs being provided if you use an invalid one (/a)\
/speech <type> <index> - Play a certain speech on yourself, with a list of valid inputs being provided if you use invalid ones (/s)\
/help - Get the list of commands available to regular users\
/help moderator/admin - Get the list of commands available to moderators or admins, if you are one",
    buttons = {
        { caption = "Beginner Tips", destinations = { menuHelper.destinations.setDefault("beginner tips") } },
        { caption = "Changelog", destinations = { menuHelper.destinations.setDefault("changelog") } },
        { caption = "Quests", destinations = { menuHelper.destinations.setDefault("quest menu") } },
        { caption = "Crafting", destinations = { menuHelper.destinations.setDefault("crafting menu") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["beginner tips"] = {
    text = "Start by killing creatures right outside of your Home City to earn gold\
	\
	It is recommended that you do a level 1-10 Quest to get a better starter weapon\
	\
	Crab Meats and Scrib Jelly are needed for the early quests so loot them\
	\
	Don't forget to check out crafting",
    buttons = {
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("help menu") } },
		{ caption = "More Tips", destinations = { menuHelper.destinations.setDefault("more tips") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["more tips"] = {
	text = "Each home city has different areas of creatures to fight.\
	Select which City you would like to learn about.",
	buttons = {
		{ caption = "Back", destinations = { menuHelper.destinations.setDefault("beginner tips") } },
        { caption = "Seyda Neen", destinations = { menuHelper.destinations.setDefault("seyda neen tips") } },
        { caption = "Balmora", destinations = { menuHelper.destinations.setDefault("balmora tips") } },
        { caption = "Caldera", destinations = { menuHelper.destinations.setDefault("caldera tips") } },
        { caption = "Suran", destinations = { menuHelper.destinations.setDefault("suran tips") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["seyda neen tips"] = {
	text = "Seyda Neen has a large mix of creatures living just outside of town\
	If you venture up the hill you will find a massive colony of scribs inhabiting the valley",
	buttons = {
		{ caption = "Back", destinations = { menuHelper.destinations.setDefault("more tips") } },
        { caption = "Exit", destinations = nil }
	}
}
Menus["balmora tips"] = {
	text = "Balmora has a large mix of creatures inhabiting the river area to its south\
	If you need to kill mudcrabs it is recommended that you venture to Suran or Seyda Neen",
	buttons = {
		{ caption = "Back", destinations = { menuHelper.destinations.setDefault("more tips") } },
        { caption = "Exit", destinations = nil }
	}
}
Menus["caldera tips"] = {
	text = "Caldera has a mix of many different creatures living outside it's north gate\
	You will also find a good amount of scribs nesting in that area\
	\
	If you need to kill mudcrabs then you should venture to Suran or Seyda Neen.",
	buttons = {
		{ caption = "Back", destinations = { menuHelper.destinations.setDefault("more tips") } },
        { caption = "Exit", destinations = nil }
	}
}
Menus["suran tips"] = {
	text = "Suran has a very lare mudcrab population\
	Follow the water to the South East and you will find their breeding grounds\
	\
	Scribs do not like this areaa and are easier to find near the other three home cities",
	buttons = {
		{ caption = "Back", destinations = { menuHelper.destinations.setDefault("more tips") } },
        { caption = "Exit", destinations = nil }
	}
}
Menus["changelog"] = {
    text = "Ragefire Version 1.0 Febuary 14, 2018\n\
        Banned items: Boots of Blinding Speed, Amulet of Shadows, Helseth's Ring and Ebony Arrow of Slaying\
        Base Speed attribute set to 150 (Since Boots of Blinding Speed are banned)\
        Gold drops from all creatures\
        Creeper, Mudcrab and Torasa Aram(Museum of Artifacts lady) removed from game\
        300+ Creatures added\
        Home cities Balmora, Caldera, Seyda Neen and Suran added\
        /home Teleports to your Home City\
        Difficulty starts at 20 and increases 4 per level\
        Sword of White Woe removed. Soon to be a quest item instead\
        Respawn Timer added: 10 seconds + 1 second per character level",
    buttons = {
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("help menu") } },
        { caption = "Ok", destinations = nil }
    }
}

Menus["quest menu"] = {
    text = "Select which level quests you would like to do.",
    buttons = {
        { caption = "Level 1-10", destinations = { menuHelper.destinations.setDefault("quests level 1-10") } },
        { caption = "Level 11-20", destinations = { menuHelper.destinations.setDefault("quests level 11-20") } },
        { caption = "Level 21-40", destinations = { menuHelper.destinations.setDefault("not implemented") } },
        { caption = "Level 41+", destinations = { menuHelper.destinations.setDefault("not implemented") } },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("help menu") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["crafting menu"] = {
    text = "Choose which type of Armor you would like to craft.",
    buttons = {
        { caption = "Heavy Armor", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Medium Armor", destinations = { menuHelper.destinations.setDefault("craft medium armor") } },
        { caption = "Light Armor", destinations = { menuHelper.destinations.setDefault("craft light armor") } },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("help menu") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["not implemented"] = {
    text = "That menu is not implemented yet.",
    buttons = {
        { caption = "Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
        { caption = "Ok", destinations = nil }
    }
}
Menus["lack of materials"] = {
    text = "You lack the materials required.",
    buttons = {
        { caption = "Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
        { caption = "Ok", destinations = nil }
    }
}
Menus["lack of skill"] = {
    text = "You lack the skill required.",
    buttons = {
        { caption = "Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
        { caption = "Ok", destinations = nil }
    }
}


---------------------------------------------------------------------------
Menus["quests level 1-10"] = {
    text = "Please select which quest you would like to complete.\
	They all require 40 Crab Meats, 20 Scrib Jelly",
    buttons = {
        { caption = "Dwarven Mace - 40 crab meat, 20 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward dwarven mace",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("dwarven mace", 1)
                })
            }
        },
        { caption = "Dwarven War Axe - 40 crab meat, 20 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward dwarven axe",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("dwarven war axe", 1)     
                })
            }
        },
        { caption = "Huntsman Longsword - 35 crab meat, 15 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward huntsman longsword",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("BM huntsman longsword", 1)     
                })
            }
        },
		{ caption = "Dwarven Shortsword - 35 crab meat, 15 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward dwarven shortsword",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("dwarven shortsword", 1)     
                })
            }
        },
		{ caption = "Dwarven Halberd - 40 crab meat, 20 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward dwarven halberd",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("dwarven halberd", 1)     
                })
            }
        },
		{ caption = "Bonemold Long Bow 30 crab meat, 15 scrib jelly",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward bonemold long bow",
                {
                    menuHelper.conditions.requireItem("ingred_crab_meat_01", 30),
                    menuHelper.conditions.requireItem("ingred_scrib_jelly_01", 15)
                },
                {
                    menuHelper.effects.removeItem("ingred_crab_meat_01", 30),
                    menuHelper.effects.removeItem("ingred_scrib_jelly_01", 15),
                    menuHelper.effects.giveItem("bonemold long bow", 1),
					menuHelper.effects.giveItem("silver arrow", 150),
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("quest menu") } },
        { caption = "Exit", destinations = nil }
    }
}
-----------------------------------------------------
Menus["quests level 11-20"] = {
    text = "Please select which quest you would like to complete\n\
        Redas Robe of Deeds - 25 Heather and 5 Ruby\
        Sword of White Woe - 40 Racer Plumes",
    buttons = {
        { caption = "Redas Robe of Deeds",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward redas robe of deeds",
                {
                    menuHelper.conditions.requireItem("ingred_heather_01", 25),
                    menuHelper.conditions.requireItem("ingred_ruby_01", 5)
                },
                {
                    menuHelper.effects.removeItem("ingred_heather_01", 25),
                    menuHelper.effects.removeItem("ingred_ruby_01", 5),
                    menuHelper.effects.giveItem("Extravagant_Robe_01_Red", 1)
                })
            }
        },
        { caption = "Sword of White Woe",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward sword of white woe",
                {
                    menuHelper.conditions.requireItem("ingred_racer_plumes_01", 40)
                },
                {
                    menuHelper.effects.removeItem("ingred_racer_plumes_01", 40),
                    menuHelper.effects.giveItem("sword of white woe", 1)     
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("quest menu") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft heavy armor"] = {
    text = "Which type of heavy armor?\n\
        Dwarven Armor requires 20+ Armorer skill\
        Ebony Armor requires 60+ Armorer skill\
        Daedric Armor requires 90+ Armorer skill",
    buttons = {
        { caption = "Dwarven",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft dwarven armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 20)
                })
            }
        },
        { caption = "Ebony",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft ebony armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 60)
                })
            }
        },
        { caption = "Daedric",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft daedric armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 90)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("crafting menu") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft medium armor"] = {
    text = "Which type of medium armor?\n\
        Bonemold Armor requires 10+ Armorer skill\
        Adamantium Armor requires 30+ Armorer skill\
        Stalhrim Armor requires 50+ Armorer skill",
    buttons = {
        { caption = "Bonemold",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft bonemold armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 10)
                })
            }
        },
        { caption = "Adamantium",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft adamantium armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 30)
                })
            }
        },
        { caption = "Stalhrim",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft stalhrim armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 50)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("crafting menu") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft light armor"] = {
    text = "Which type of light armor?\n\
		Dark Brotherhood requires 10+ Armorer Skill\
        Glass Armor requires 55+ Armorer skill",
    buttons = {
		{ caption = "Dark Brotherhood",
			destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("craft dark brotherhood armor",
                {
                    menuHelper.conditions.requireSkill("Armorer", 10)
                })
            }
        },
        { caption = "Glass",
            destinations = {
                menuHelper.destinations.setDefault("lack of skill"),
                menuHelper.destinations.setConditional("not implemented",
                {
                    menuHelper.conditions.requireSkill("Armorer", 55)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("crafting menu") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft dwarven armor"] = {
    text = "Which parts of Dwarven Armor?\n",
    buttons = {
        { caption = "Cuirass - 8 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 8),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 8),
                    menuHelper.effects.giveItem("dwemer_cuirass", 1)
                })
            }
        },
        { caption = "Helm - 4 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 4),                   
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 4),                 
                    menuHelper.effects.giveItem("dwemer_helm", 1)
                })
            }
        },
        { caption = "Left and Right Pauldrons - 10 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 10),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 10),
                    menuHelper.effects.giveItem("dwemer_pauldron_left", 1),
                    menuHelper.effects.giveItem("dwemer_pauldron_right", 1)
                })
            }
        },
        { caption = "Left and Right Bracers - 10 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 10),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 10),
                    menuHelper.effects.giveItem("dwemer_bracer_left", 1),
                    menuHelper.effects.giveItem("dwemer_bracer_right", 1)
                })
            }
        },
        { caption = "Greaves - 6 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 6),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 6),
                    menuHelper.effects.giveItem("dwemer_greaves", 1)
                })
            }
        },
        { caption = "Boots - 4 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 4),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 4),
                    menuHelper.effects.giveItem("dwemer_boots", 1)
                })
            }
        },
        { caption = "Shield - 6 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 6),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 6),
                    menuHelper.effects.giveItem("dwemer_shield", 1)
                })
            }
        },
        { caption = "Whole Set - 40 Scrap Metal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scrap_metal_01", 40),
                },
                {
                    menuHelper.effects.removeItem("ingred_scrap_metal_01", 40),
                    menuHelper.effects.giveItem("dwemer_cuirass", 1),
                    menuHelper.effects.giveItem("dwemer_helm", 1),
                    menuHelper.effects.giveItem("dwemer_pauldron_left", 1),
                    menuHelper.effects.giveItem("dwemer_pauldron_right", 1),
                    menuHelper.effects.giveItem("dwemer_bracer_left", 1),
                    menuHelper.effects.giveItem("dwemer_bracer_right", 1),
                    menuHelper.effects.giveItem("dwemer_greaves", 1),
                    menuHelper.effects.giveItem("dwemer_boots", 1),
                    menuHelper.effects.giveItem("dwemer_shield", 1)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft ebony armor"] = {
    text = "Which parts of Ebony Armor?\n\
        Cuirass - 10 Raw Ebony and 1,000 Gold\
        Helm - 8 Raw Ebony and 1,000 Gold\
        Left and Right Pauldrons - 14 Raw Ebony and 1,500 Gold\
        Left and Right Bracers - 14 Raw Ebony and 1,500 Gold\
        Greaves - 8 Raw Ebony and 1,000 Gold\
        Boots - 6 Raw Ebony and 1,000 Gold\
        Shield - 6 Raw Ebony and 1,000 Gold\
        Whole Set - 50 Raw Ebony and 7,500 Gold",
    buttons = {
        { caption = "Cuirass",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 10),
                    menuHelper.conditions.requireItem("gold_001", 1000)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 10),
                    menuHelper.effects.removeItem("gold_001", 1000),
                    menuHelper.effects.giveItem("ebony_cuirass", 1)
                })
            }
        },
        { caption = "Helm",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 8),
                    menuHelper.conditions.requireItem("gold_001", 1000)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 8),
                    menuHelper.effects.removeItem("gold_001", 1000),
                    menuHelper.effects.giveItem("ebony_helm", 1)
                })
            }
        },
        { caption = "Left and Right Pauldrons",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 14),
                    menuHelper.conditions.requireItem("gold_001", 1500)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 14),
                    menuHelper.effects.removeItem("gold_001", 1500),
                    menuHelper.effects.giveItem("ebony_pauldron_left", 1),
                    menuHelper.effects.giveItem("ebony_pauldron_right", 1)
                })
            }
        },
        { caption = "Left and Right Bracers",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 14),
                    menuHelper.conditions.requireItem("gold_001", 1500)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 14),
                    menuHelper.effects.removeItem("gold_001", 1500),
                    menuHelper.effects.giveItem("ebony_bracer_left", 1),
                    menuHelper.effects.giveItem("ebony_bracer_right", 1)
                })
            }
        },
        { caption = "Greaves",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 8),
                    menuHelper.conditions.requireItem("gold_001", 1000)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 8),
                    menuHelper.effects.removeItem("gold_001", 1000),
                    menuHelper.effects.giveItem("ebony_greaves", 1)
                })
            }
        },
        { caption = "Boots",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 6),
                    menuHelper.conditions.requireItem("gold_001", 1000)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 6),
                    menuHelper.effects.removeItem("gold_001", 1000),
                    menuHelper.effects.giveItem("ebony_boots", 1)
                })
            }
        },
        { caption = "Shield",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 6),
                    menuHelper.conditions.requireItem("gold_001", 1000)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 6),
                    menuHelper.effects.removeItem("gold_001", 1000),
                    menuHelper.effects.giveItem("ebony_shield", 1)
                })
            }
        },
        { caption = "Whole Set",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 50),
                    menuHelper.conditions.requireItem("gold_001", 7500)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 50),
                    menuHelper.effects.removeItem("gold_001", 7500),
                    menuHelper.effects.giveItem("ebony_cuirass", 1),
                    menuHelper.effects.giveItem("ebony_helm", 1),
                    menuHelper.effects.giveItem("ebony_pauldron_left", 1),
                    menuHelper.effects.giveItem("ebony_pauldron_right", 1),
                    menuHelper.effects.giveItem("ebony_bracer_left", 1),
                    menuHelper.effects.giveItem("ebony_bracer_right", 1),
                    menuHelper.effects.giveItem("ebony_greaves", 1),
                    menuHelper.effects.giveItem("ebony_boots", 1),
                    menuHelper.effects.giveItem("ebony_shield", 1)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Exit", destinations = nil }
    }
}

Menus["craft daedric armor"] = {
    text = "Which parts of Daedric Armor?\n\
        Cuirass - 20 Raw Ebony and 5 Daedra Hearts and 5 Sixth House Statues\
        Helm - 16 Raw Ebony and 4 Daedra Hearts and 4 Sixth House Statues\
        Left and Right Pauldrons - 25 Raw Ebony and 8 Daedra Hearts and 8 Sixth House Statues\
        Left and Right Bracers - 23 Raw Ebony and 6 Daedra Hearts and 6 Sixth House Statues\
        Greaves - 16 Raw Ebony and 4 Daedra Hearts and 4 Sixth House Statues\
        Boots - 14 Raw Ebony and 4 Daedra Hearts and 4 Sixth House Statues\
        Shield - 12 Raw Ebony and 4 Daedra Hearts and 4 Sith House Statues\
        Whole Set - 100 Raw Ebony and 30 Daedra Hearts and 30 Sixth House Statues",
    buttons = {
        { caption = "Cuirass",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 20),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 5),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 5)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 20),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 5),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 5),
                    menuHelper.effects.giveItem("daedric_cuirass", 1)
                })
            }
        },
        { caption = "Helm",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 16),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 4),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 4)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 16),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 4),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 4),
                    menuHelper.effects.giveItem("daedric_helm", 1)
                })
            }
        },
        { caption = "Left and Right Pauldrons",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 25),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 8),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 8)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 25),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 8),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 8),
                    menuHelper.effects.giveItem("daedric_pauldron_left", 1),
                    menuHelper.effects.giveItem("daedric_pauldron_right", 1)
                })
            }
        },
        { caption = "Left and Right Bracers",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 23),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 6),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 6)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 23),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 6),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 6),
                    menuHelper.effects.giveItem("daedric_bracer_left", 1),
                    menuHelper.effects.giveItem("daedric_bracer_right", 1)
                })
            }
        },
        { caption = "Greaves",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 16),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 4),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 4)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 16),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 4),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 4),
                    menuHelper.effects.giveItem("daedric_greaves", 1)
                })
            }
        },
        { caption = "Boots",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 14),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 4),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 4)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 14),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 4),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 4),
                    menuHelper.effects.giveItem("daedric_boots", 1)
                })
            }
        },
        { caption = "Shield",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 12),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 4),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 4)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 12),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 4),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 4),
                    menuHelper.effects.giveItem("daedric_shield", 1)
                })
            }
        },
        { caption = "Whole Set",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_raw_ebony_01", 100),
                    menuHelper.conditions.requireItem("ingred_daedras_heart_01", 30),
                    menuHelper.conditions.requireItem("misc_6th_ash_statue_01", 30)
                },
                {
                    menuHelper.effects.removeItem("ingred_raw_ebony_01", 100),
                    menuHelper.effects.removeItem("ingred_daedras_heart_01", 30),
                    menuHelper.effects.removeItem("misc_6th_ash_statue_01", 30),
                    menuHelper.effects.giveItem("daedric_cuirass", 1),
                    menuHelper.effects.giveItem("daedric_helm", 1),
                    menuHelper.effects.giveItem("daedric_pauldron_left", 1),
                    menuHelper.effects.giveItem("daedric_pauldron_right", 1),
                    menuHelper.effects.giveItem("daedric_bracer_left", 1),
                    menuHelper.effects.giveItem("daedric_bracer_right", 1),
                    menuHelper.effects.giveItem("daedric_greaves", 1),
                    menuHelper.effects.giveItem("daedric_boots", 1),
                    menuHelper.effects.giveItem("daedric_shield", 1)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["craft bonemold armor"] = {
    text = "Which parts of Bonemold Armor?\n",
    buttons = {
        { caption = "Cuirass - 10 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 10),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 10),
                    menuHelper.effects.giveItem("bonemold_cuirass", 1)
                })
            }
        },
        { caption = "Helm - 4 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 4),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 4),
                    menuHelper.effects.giveItem("bonemold_helm", 1)
                })
            }
        },
        { caption = "Left and Right Pauldrons - 12 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 12),                 
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 12),
                    menuHelper.effects.giveItem("bonemold_pauldron_l", 1),
                    menuHelper.effects.giveItem("bonemold_pauldron_r", 1)
                })
            }
        },
        { caption = "Left and Right Bracers - 12 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 12),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 12),
                    menuHelper.effects.giveItem("bonemold_bracer_right", 1),
                    menuHelper.effects.giveItem("bonemold_bracer_left", 1)
                })
            }
        },
        { caption = "Greaves - 8 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 8),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 8),
                    menuHelper.effects.giveItem("bonemold_greaves", 1)
                })
            }
        },
        { caption = "Boots - 4 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 4),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 4),
                    menuHelper.effects.giveItem("bonemold_boots", 1)
                })
            }
        },
        { caption = "Shield - 6 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 6),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 6),
                    menuHelper.effects.giveItem("bonemold_towershield", 1)
                })
            }
        },
        { caption = "Whole Set - 45 Bonemeal",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_bonemeal_01", 45),
                },
                {
                    menuHelper.effects.removeItem("ingred_bonemeal_01", 45),
                    menuHelper.effects.giveItem("bonemold_cuirass", 1),
                    menuHelper.effects.giveItem("bonemold_helm", 1),
                    menuHelper.effects.giveItem("bonemold_pauldron_l", 1),
                    menuHelper.effects.giveItem("bonemold_pauldron_r", 1),
                    menuHelper.effects.giveItem("bonemold_bracer_left", 1),
                    menuHelper.effects.giveItem("bonemold_bracer_right", 1),
                    menuHelper.effects.giveItem("bonemold_greaves", 1),
                    menuHelper.effects.giveItem("bonemold_boots", 1),
                    menuHelper.effects.giveItem("bonemold_towershield", 1)
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Exit", destinations = nil }
    }
}
Menus["craft dark brotherhood armor"] = {
    text = "Which parts of Dark Brotherhood Armor?\n",
    buttons = {
        { caption = "Cuirass - 7 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 7),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 7),
                    menuHelper.effects.giveItem("darkbrotherhood cuirass", 1)
                })
            }
        },
        { caption = "Helm - 4 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 4),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 4),
                    menuHelper.effects.giveItem("darkbrotherhood helm", 1)
                })
            }
        },
        { caption = "Left and Right Pauldrons - 10 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 10),                 
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 10),
                    menuHelper.effects.giveItem("darkbrotherhood pauldron_l", 1),
                    menuHelper.effects.giveItem("darkbrotherhood pauldron_r", 1)
                })
            }
        },
        { caption = "Left and Right Gauntlets - 10 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 10),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 10),
                    menuHelper.effects.giveItem("darkbrotherhood gauntlet_r", 1),
                    menuHelper.effects.giveItem("darkbrotherhood gauntlet_l", 1)
                })
            }
        },
        { caption = "Greaves - 6 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 6),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 6),
                    menuHelper.effects.giveItem("darkbrotherhood greaves", 1)
                })
            }
        },
        { caption = "Boots - 4 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic singular",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 4),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 4),
                    menuHelper.effects.giveItem("darkbrotherhood boots", 1)
                })
            }
        },
        { caption = "Whole Set - 35 Scamp Skins",
            destinations = {
                menuHelper.destinations.setDefault("lack of materials"),
                menuHelper.destinations.setConditional("reward generic plural",
                {
                    menuHelper.conditions.requireItem("ingred_scamp_skin_01", 38),
                },
                {
                    menuHelper.effects.removeItem("ingred_scamp_skin_01", 38),
                    menuHelper.effects.giveItem("darkbrotherhood cuirass", 1),
                    menuHelper.effects.giveItem("darkbrotherhood helm", 1),
                    menuHelper.effects.giveItem("darkbrotherhood pauldron_l", 1),
                    menuHelper.effects.giveItem("darkbrotherhood pauldron_r", 1),
                    menuHelper.effects.giveItem("darkbrotherhood gauntlet_l", 1),
                    menuHelper.effects.giveItem("darkbrotherhood gauntlet_r", 1),
                    menuHelper.effects.giveItem("darkbrotherhood greaves", 1),
                    menuHelper.effects.giveItem("darkbrotherhood boots", 1),
                })
            }
        },
        { caption = "Back", destinations = { menuHelper.destinations.setDefault("craft heavy armor") } },
        { caption = "Exit", destinations = nil }
    }
}
	
Menus["reward dwarven mace"] = {
    text = "Congratulations! Dwarven Mace is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward dwarven axe"] = {
    text = "Congratulations! Dwarven War Axe is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward huntsman longsword"] = {
    text = "Congratulations! Huntsman Longsword is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward dwarven shortsword"] = {
    text = "Congratulations! Dwarven Shortsword is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward dwarven halberd"] = {
    text = "Congratulations! Dwarven Halberd is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward bonemold long bow"] = {
    text = "Congratulations! Bonemold Long Bow is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward redas robe of deeds"] = {
    text = "Congratulations! Redas Robe of Deeds is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward sword of white woe"] = {
    text = "Congratulations! Sword of White Woe is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward generic singular"] = {
    text = "Congratulations! The item is now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}
Menus["reward generic plural"] = {
    text = "Congratulations! The items are now yours",
    buttons = {
        { caption = "Ok", destinations = nil }
    }
}

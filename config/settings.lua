---@type Mq
local mq = require("mq")

local loader = require("yalm.core.loader")

local persistence = require("yalm.lib.persistence")
local utils = require("yalm.lib.utils")

-- default application settings
local default_global_settings = {
	["categories"] = {
		[1] = "Configuration",
		[2] = "Item",
	},
	["commands"] = {
		["Buy"] = {
			["name"] = "Buy",
			["trigger"] = "buy",
			["help"] = "Buys designated items from the targeted merchant",
			["category"] = "Item",
		},
		["Check"] = {
			["name"] = "Check",
			["trigger"] = "check",
			["help"] = "Print loot preference for all items in inventory or item on cursor",
			["category"] = "Item",
		},
		["Command"] = {
			["name"] = "Command",
			["trigger"] = "command",
			["help"] = "Manage commands. Type \ay/yalm command help\ax for more information.",
			["category"] = "Configuration",
		},
		["Condition"] = {
			["name"] = "Condition",
			["trigger"] = "condition",
			["help"] = "Manage conditions. Type \ay/yalm condition help\ax for more information.",
			["category"] = "Configuration",
		},
		["Convert"] = {
			["name"] = "Convert",
			["trigger"] = "convert",
			["help"] = "Convert Lootly loot file to YALM",
			["category"] = "Item",
		},
		["Destroy"] = {
			["name"] = "Destroy",
			["trigger"] = "destroy",
			["help"] = "Destroy any designated items in your bags",
			["category"] = "Item",
		},
		["Guild"] = {
			["name"] = "Guild",
			["trigger"] = "guild",
			["help"] = "Deposits designated items into the guild bank",
			["category"] = "Item",
		},
		["Rule"] = {
			["name"] = "Rule",
			["trigger"] = "rule",
			["help"] = "Manage rules. Type \ay/yalm rule help\ax for more information.",
			["category"] = "Configuration",
		},
		["Sell"] = {
			["name"] = "Sell",
			["trigger"] = "sell",
			["help"] = "Sells designated items to the targeted merchant",
			["category"] = "Item",
		},
		["SetItem"] = {
			["args"] = "<item> <preference> (all|me)",
			["name"] = "SetItem",
			["trigger"] = "setitem",
			["help"] = "Set loot preference for item on cursor or by name",
			["category"] = "Item",
		},
	},
	["conditions"] = {},
	["items"] = {},
	["settings"] = {
		["always_loot"] = true,
		["distribute_delay"] = "1s",
		["frequency"] = 250,
		["save_slots"] = 3,
		["unmatched_item_delay"] = "10s",
		["dannet_delay"] = 250,
		["unmatched_item_rule"] = {
			["setting"] = "Keep",
		},
	},
	["preferences"] = {
		["Buy"] = {
			["name"] = "Buy",
		},
		["Destroy"] = {
			["name"] = "Destroy",
			["leave"] = true,
		},
		["Guild"] = {
			["name"] = "Guild",
		},
		["Ignore"] = {
			["name"] = "Ignore",
			["leave"] = true,
		},
		["Keep"] = {
			["name"] = "Keep",
		},
		["Sell"] = {
			["name"] = "Sell",
		},
	},
	["rules"] = {},
}

local settings = {}

settings.init_char_settings = function(character)
	local char_settings

	local filename = ("%s/YALM/yalm-%s-%s.lua"):format(
		mq.configDir,
		mq.TLO.EverQuest.Server(),
		character or mq.TLO.Me.CleanName():lower()
	)
	if not utils.file_exists(filename) then
		char_settings = {
			items = {},
			settings = {},
			rules = {},
		}
		settings.save_char_settings(char_settings)
	else
		local module, error = loadfile(filename)()
		char_settings = module
	end

	if not char_settings["items"] then
		char_settings["items"] = {}
	end

	if not char_settings["settings"] then
		char_settings["settings"] = {}
	end

	if not char_settings["rules"] then
		char_settings["rules"] = {}
	end

	return char_settings
end

settings.init_global_settings = function()
	local global_settings

	local filename = ("%s/YALM.lua"):format(mq.configDir)

	if not utils.file_exists(filename) then
		global_settings = default_global_settings
		settings.save_global_settings(default_global_settings)
	else
		local module, error = loadfile(filename)()
		global_settings = module
	end

	local default_copy = utils.table_clone(default_global_settings)
	global_settings = utils.merge(default_copy, global_settings)

	return global_settings
end

settings.init_settings = function(character)
	assert(utils.make_dir(mq.configDir, "YALM"))

	local global_settings = settings.init_global_settings()
	local char_settings = settings.init_char_settings(character)

	if char_settings.settings then
		utils.merge(global_settings.settings, char_settings.settings)
	end

	return global_settings, char_settings
end

settings.save_global_settings = function(global_settings)
	persistence.store(("%s/YALM.lua"):format(mq.configDir), global_settings)
end

settings.save_char_settings = function(char_settings)
	persistence.store(
		("%s/YALM/yalm-%s-%s.lua"):format(mq.configDir, mq.TLO.EverQuest.Server(), mq.TLO.Me.CleanName():lower()),
		char_settings
	)
end

settings.remove_global_settings = function(type, key)
	if not loader.types[type] then
		Write.Error("%s is not a valid global key", type)
		return
	end

	local global_settings = settings.init_global_settings()

	global_settings[type][key] = nil
	settings.save_global_settings(global_settings)
end

settings.set_global_settings = function(type, tables)
	if not loader.types[type] then
		Write.Error("%s is not a valid global key", type)
		return
	end

	local global_settings = settings.init_global_settings()
	utils.merge(global_settings[type], tables)

	settings.save_global_settings(global_settings)
end

settings.remove_and_save_global_settings = function(global_settings, type, key)
	if not loader.types[type] then
		Write.Error("%s is not a valid global key", type)
		return
	end

	global_settings[type][key] = nil
	settings.remove_global_settings(type, key)
end

settings.update_and_save_global_settings = function(global_settings, type, tables)
	if not loader.types[type] then
		Write.Error("%s is not a valid global key", type)
		return
	end

	utils.merge(global_settings[type], tables)
	settings.set_global_settings(type, tables)
end

return settings

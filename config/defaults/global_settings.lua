do
	local _ = {
		categories = {
			"Configuration",
			"Item",
		},
		commands = {
			Buy = {
				name = "Buy",
				trigger = "buy",
				help = "Buys designated items from the targeted merchant",
				category = "Item",
			},
			Character = {
				name = "Character",
				trigger = "char",
				help = "Manage character. Type \ay/yalm char help\ax for more information.",
				category = "Configuration",
			},
			Check = {
				name = "Check",
				trigger = "check",
				help = "Print loot preference for all items in inventory or item on cursor",
				category = "Item",
			},
			Command = {
				name = "Command",
				trigger = "command",
				help = "Manage commands. Type \ay/yalm command help\ax for more information.",
				category = "Configuration",
			},
			Condition = {
				name = "Condition",
				trigger = "condition",
				help = "Manage conditions. Type \ay/yalm condition help\ax for more information.",
				category = "Configuration",
			},
			Convert = {
				name = "Convert",
				trigger = "convert",
				help = "Converts other loot systems to YALM. Type \ay/yalm convert help\ax for more information",
				category = "Item",
			},
			Destroy = {
				name = "Destroy",
				trigger = "destroy",
				help = "Destroy any designated items in your bags",
				category = "Item",
			},
			Donate = {
				args = "[guild|me]",
				name = "Donate",
				trigger = "donate",
				help = "Donates designated items",
				category = "Item",
			},
			Guild = {
				name = "Guild",
				trigger = "guild",
				help = "Deposits designated items into the guild bank",
				category = "Item",
			},
			Rule = {
				name = "Rule",
				trigger = "rule",
				help = "Manage rules. Type \ay/yalm rule help\ax for more information.",
				category = "Configuration",
			},
			Sell = {
				name = "Sell",
				trigger = "sell",
				help = "Sells designated items to the targeted merchant",
				category = "Item",
			},
			SetItem = {
				args = "<item> <preference> (all|me)",
				name = "SetItem",
				trigger = "setitem",
				help = "Set loot preference for item on cursor or by name",
				category = "Item",
			},
			Simulate = {
				name = "Simulate",
				trigger = "simulate",
				help = "Simulate looting item on cursor or by name",
				category = "Item",
			},
		},
		conditions = {},
		items = {},
		preferences = {
			Buy = {
				name = "Buy",
			},
			Destroy = {
				name = "Destroy",
				leave = true,
			},
			Guild = {
				name = "Guild",
			},
			Ignore = {
				name = "Ignore",
				leave = true,
			},
			Keep = {
				name = "Keep",
			},
			Sell = {
				name = "Sell",
			},
			Tribute = {
				name = "Tribute",
			},
		},
		rules = {},
		settings = {
			always_loot = true,
			distribute_delay = "1s",
			frequency = 250,
			save_slots = 3,
			unmatched_item_delay = "10s",
			dannet_delay = 250,
			unmatched_item_rule = {
				setting = "Keep",
			},
		},
		subcommands = {
			Create = {
				args = "<name>",
				name = "Create",
				trigger = "create",
				help = "Creates a new %s with the given name",
				category = "Configuration",
			},
			Delete = {
				args = "<name>",
				name = "Delete",
				trigger = "delete",
				help = "Deletes a %s with the given name",
				category = "Configuration",
			},
			Edit = {
				args = "<name>",
				name = "Edit",
				trigger = "edit",
				help = "Opens a %s with the given name in your preferred editor",
				category = "Configuration",
			},
			Help = {
				name = "Help",
				trigger = "help",
				help = "Display this help output",
				category = "Configuration",
			},
			List = {
				name = "List",
				trigger = "list",
				help = "List all available %s",
				category = "Configuration",
			},
			Set = {
				args = "<setting> <value>",
				name = "Set",
				trigger = "set",
				help = "Updates setting to the given value",
				category = "Configuration",
			},
		},
	}
	return _
end

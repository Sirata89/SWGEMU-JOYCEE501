# Hiring Agent System

A custom mercenary hiring system that allows players to hire NPC companions through a conversation-based UI.

## Overview

The hiring agent system enables players to hire mercenaries as permanent companions that function like pets. Mercenaries are hired for a one-time credit cost and can be stored/called using the standard pet control device system.

## How It Works

1. **Locate a Hiring Agent** - Find the hiring agent NPC in-game
2. **Initiate Conversation** - Talk to the agent to open the hiring UI
3. **Select a Mercenary** - Browse available mercenaries and select one to hire
4. **Pay the Cost** - Credits are deducted and a control device is added to your datapad
5. **Control Your Mercenary** - Use standard pet commands (attack, follow, stay, etc.)

### Debug Mode

The hiring agent includes a debug conversation option that allows free hiring for testing purposes. This is available to all players and can be used to test the system without spending credits.

## Files Modified

### Server Scripts

- **`bin/scripts/screenplays/custom/hiring_agent.lua`**
  - Main hiring agent screenplay
  - Contains mercenary configuration table (types, costs, templates)
  - Handles the hiring SUI (Stationary User Interface)
  - Processes player selection and creates control devices
  - Includes debug mode for free hiring

- **`bin/scripts/screenplays/custom/conversations/hiring_agent_convo_handler.lua`**
  - Conversation handler for the hiring agent NPC
  - Handles screen transitions and dynamic options
  - Includes debug hire option

- **`bin/scripts/mobile/conversations/custom/hiring_agent_conv.lua`**
  - Conversation template for the hiring agent
  - Defines available conversation screens

- **`bin/scripts/mobile/serverobjects.lua`**
  - Added includes for hiring agent and all mercenary templates
  - Lines 174-196

### Mercenary Templates

All mercenary templates are located in `bin/scripts/mobile/custom/mercs/`:

**Combat Mercenaries:**
- `street_thug.lua` - Level 15, melee weapons
- `commoner_guard.lua` - Level 18, pirate light weapons
- `scavenger_hunter.lua` - Level 22, pirate light weapons
- `generic_merc.lua` - Level 45, pirate light weapons
- `rodian_mercenary.lua` - Level 48, pirate light weapons
- `rogue_smuggler.lua` - Level 52, pirate light weapons
- `merc_captain.lua` - Level 65, pirate medium weapons
- `bounty_hunter_merc.lua` - Level 75, pirate medium weapons
- `rebel_veteran.lua` - Level 56, rebel medium weapons
- `corporate_security.lua` - Level 60, pirate light weapons
- `merc_pirate_hunter.lua` - Level 55, pirate light weapons (renamed from pirate_cutthroat to avoid conflict)
- `mandalorian_scout.lua` - Level 80, pirate heavy weapons
- `elite_commando.lua` - Level 90, pirate heavy weapons
- `assassin_droid.lua` - Level 78, battle droid weapons
- `imperial_defector.lua` - Level 58, stormtrooper weapons
- `dark_jedi_acolyte.lua` - Level 55, lightsaber weapons (Jedi-only)

**Healer Mercenaries:**
- `medic_apprentice.lua` - Level 20, pirate light weapons
- `field_medic.lua` - Level 35, pirate light weapons
- `medic_corpsman.lua` - Level 38, pirate light weapons
- `medic_surgeon.lua` - Level 48, pirate medium weapons
- `medic_doctor.lua` - Level 55, pirate medium weapons

### Core Server Code

- **`src/server/zone/objects/intangible/PetControlDeviceImplementation.cpp`**
  - Modified pet store delay from 60 seconds to 0 (instant)
  - Added faction check bypass for mercenaries (socialGroup = "mercenary")
  - Added weapon recreation when calling pets to fix missing weapons after storage
  - Lines 606-615, 156-181, 103-106

## Configuration

### Adding New Mercenaries

To add a new mercenary:

1. Create a new Lua file in `bin/scripts/mobile/custom/mercs/`
2. Use the following template structure:

```lua
merc_new_merc = Creature:new {
    objectName = "@mob/creature_names:base_creature",
    customName = "Custom Name",
    socialGroup = "mercenary",
    faction = "neutral",
    level = 50,
    chanceHit = 0.50,
    damageMin = 400,
    damageMax = 600,
    baseXp = 5000,
    baseHAM = 5000,
    baseHAMmax = 6000,
    armor = 1,
    resists = {50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50},
    optionsBitmask = AIENABLED,
    pvpBitmask = NONE,
    creatureBitmask = PACK,
    diet = HERBIVORE,
    controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
    
    templates = {
        "object/mobile/your_template.iff"
    },
    
    lootGroups = {},
    primaryWeapon = "weapon_group_name",
    secondaryWeapon = "unarmed",
    conversationTemplate = "",
    primaryAttacks = merge(skillgroup1,skillgroup2),
    secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(merc_new_merc, "merc_new_merc")
```

3. Add the include to `bin/scripts/mobile/serverobjects.lua`:
```lua
includeFile("custom/mercs/merc_new_merc.lua")
```

4. Add the mercenary to the configuration table in `bin/scripts/screenplays/custom/hiring_agent.lua`:
```lua
{
    id = "new_merc",
    name = "New Mercenary",
    template = "merc_new_merc",
    cost = 5000,
    displayName = "New Mercenary",
    jediOnly = false
},
```

### Adjusting Costs

Edit the `cost` field in the mercenary configuration table in `hiring_agent.lua`.

### Jedi-Only Mercenaries

Set `jediOnly = true` in the mercenary configuration to restrict hiring to players with Jedi skills.

## Weapon Groups

Mercenaries use existing weapon groups from the core game:

- `pirate_weapons_light` - Pistols, carbines (low tier)
- `pirate_weapons_medium` - Rifles, carbines (mid tier)
- `pirate_weapons_heavy` - Lightning cannon, T21, heavy weapons (high tier)
- `rebel_weapons_medium` - Rebel faction weapons
- `stormtrooper_weapons` - Imperial faction weapons
- `lightsaber_weapons` - Jedi weapons
- `battle_droid_weapons` - Droid weapons
- `melee_weapons` - Melee weapons

## Important Notes

- **Template Naming**: Mercenary templates use the `merc_` prefix to avoid conflicts with core game templates
- **Faction Check**: Mercenaries with `socialGroup = "mercenary"` bypass the faction check when called as pets
- **Instant Store**: Pet store delay is set to 0 for instant storage
- **One Merc Limit**: Players can only have one mercenary at a time
- **Healer AI**: Healer mercenaries have the `HEALER` creature bitmask and will attempt to heal allies in combat

## Testing

Use the debug conversation option (available from the hiring agent) to hire mercenaries for free during testing.

## Credits

Custom mercenary hiring system for SWGEmu.

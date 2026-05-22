# Solo Loot Variance System

## Overview

This system adds tiered loot items designed for solo players, distributed across humanoid NPC loot tables with varying drop rates based on NPC type appropriateness. The items feature Star Wars lore-friendly names and scale stats across three tiers.

## Item Types

### Original Items (10 types)
- **Signet Ring** (defense bonuses)
- **Rucksack** (movement speed + storage)
- **Medkit** (healing over time)
- **Krayt Scale** (luck charm - cosmetic)
- **Pendant** (HAM pool bonuses)
- **Utility Belt** (movement + stamina)
- **Armguard** (defense + health regen)
- **Bandolier** (storage - cosmetic)
- **Tunic** (HAM pool bonuses)
- **Leggings** (movement + stamina)

### New Items (5 types)
- **Gloves** (defense bonuses)
- **Boots** (terrain negotiation)
- **Vest** (HAM + defense)
- **Tactical Datapad** (movement + terrain)
- **Comms Device** (cosmetic)

## Tiers

All items have three variants with scaling stat ranges:

### Tier 1 (Scout)
- Low stats (e.g., 1-5 defense, 10-50 HAM)
- Drops from low-level humanoid mobs
- Drop rate: 5-15% depending on NPC type

### Tier 2 (Ranger)
- Medium stats (e.g., 5-15 defense, 50-200 HAM)
- Drops from mid-level humanoid mobs
- Drop rate: 5-15% depending on NPC type

### Tier 3 (Pathfinder)
- High stats (e.g., 10-25 defense, 100-500 HAM)
- Drops from high-level humanoid mobs
- Drop rate: 5-15% depending on NPC type

## Drop Rate Logic

Drop rates vary by NPC type to maintain immersion:

### 15% (Military/Law Enforcement)
- Imperial Tier 1
- Rebel Tier 1
- Corsec Tier 1

### 12% (Professional Criminals/Mercenaries)
- Pirates Tier 1
- Mercenaries Tier 1
- Borvo Tier 1
- Alkhara Tier 1
- Valarian Tier 1
- Nym Tier 1
- Weequay Tier 1
- Rogue Corsec Tier 1
- Trade Federation Tier 1
- Hidden Daggers Tier 1

### 10% (Baseline)
- Bandits Tier 1

### 8% (Street Gangs)
- Thugs Tier 1
- Meatlumps Tier 1
- Skaak Tipper Tier 1

### 5% (Tribal/Scavengers)
- Jawas Tier 1
- Tusken Raiders Tier 1
- Gungans Tier 1
- Janta Tribe (all tiers)
- Nightsister (all tiers)
- Mtn Clan Tier 1
- Followers of Lord Nyax Tier 1

## File Structure

### Item Templates
Location: `scripts/loot/items/custom/`

Each item has three tier files:
- `{item_name}_tier1.lua`
- `{item_name}_tier2.lua`
- `{item_name}_tier3.lua`

Example items:
- `soloist_band_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Signet Ring
- `explorer_backpack_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Rucksack
- `survivalist_kit_tier[1-3].lua` → Field/Combat/Advanced Medkit
- `lucky_charm_tier[1-3].lua` → Lucky/Fortunate/Blessed Krayt Scale
- `soloist_earring_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Pendant
- `explorer_belt_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Utility Belt
- `survivalist_bracer_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Armguard
- `lucky_bandolier_tier[1-3].lua` → Smuggler's/Freelancer's/Mercenary's Bandolier
- `soloist_shirt_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Tunic
- `explorer_pants_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Leggings
- `scout_gloves_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Gloves
- `scout_boots_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Boots
- `scout_vest_tier[1-3].lua` → Scout's/Ranger's/Pathfinder's Vest
- `tactical_datapad_tier[1-3].lua` → Tactical/Advanced/Elite Tactical Datapad
- `comms_device_tier[1-3].lua` → Encrypted/Military/SpecOps Comms Device

### Loot Groups
Location: `scripts/loot/groups/custom/`

- `solo_unique_items_tier1.lua` - Contains 15 Tier 1 items (6.7% each)
- `solo_unique_items_tier2.lua` - Contains 15 Tier 2 items (6.7% each)
- `solo_unique_items_tier3.lua` - Contains 15 Tier 3 items (6.7% each)

### Item Registration
Location: `scripts/loot/items.lua`

All custom items are registered via `includeFile()` statements at the end of the file.

### Group Registration
Location: `scripts/loot/groups.lua`

Loot groups are registered via `includeFile()` statements in the custom section.

### NPC Loot Tables
Location: `scripts/loot/groups/npc/`

The following NPC groups have been updated to include solo loot:

**Corellia:**
- `corellia/corsec_tier_1.lua`
- `corellia/meatlump_tier_1.lua`
- `corellia/followers_of_lord_nyax_tier_1.lua`
- `corellia/hidden_daggers_tier_1.lua`
- `corellia/rogue_corsec_tier_1.lua`

**Dantooine:**
- `dantooine/janta_tribe_tier_1.lua`
- `dantooine/janta_tribe_tier_2.lua`
- `dantooine/janta_tribe_tier_3.lua`

**Dathomir:**
- `dathomir/nightsister_tier_1.lua`
- `dathomir/nightsister_tier_2.lua`
- `dathomir/nightsister_tier_3.lua`
- `dathomir/mtn_clan_tier_1.lua`

**Naboo:**
- `naboo/borvo_tier_1.lua`
- `naboo/gungan_tier_1.lua`
- `naboo/skaak_tipper_gang_tier_1.lua`
- `naboo/trade_federation_tier_1.lua`

**Tatooine:**
- `tatooine/alkhara_tier_1.lua`
- `tatooine/jawa_tier_1.lua`
- `tatooine/tusken_raider_tier_1.lua`
- `tatooine/valarian_tier_1.lua`
- `tatooine/weequay_tier_1.lua`

**Lok:**
- `lok/nym_tier_1.lua`

**Thugs:**
- `thug/bandit_tier_1.lua`
- `thug/mercenary_tier_1.lua`
- `thug/pirate_tier_1.lua`
- `thug/thug_tier_1.lua`

**Faction:**
- `faction/imperial/imperial_tier_1.lua`
- `faction/rebel/rebel_tier_1.lua`

## How to Extend

### Adding a New Item Type

1. Create three item template files in `scripts/loot/items/custom/`:
   ```lua
   -- my_item_tier1.lua
   my_item_tier1 = {
       minimumLevel = 0,
       maximumLevel = -1,
       customObjectName = "My Item (Tier 1)",
       directObjectTemplate = "object/tangible/wearables/...",
       craftingValues = {
           -- Add your stat ranges
       },
       customizationStringNames = {},
       customizationValues = {}
   }
   addLootItemTemplate("my_item_tier1", my_item_tier1)
   ```

2. Register the items in `scripts/loot/items.lua`:
   ```lua
   includeFile("items/custom/my_item_tier1.lua")
   includeFile("items/custom/my_item_tier2.lua")
   includeFile("items/custom/my_item_tier3.lua")
   ```

3. Add to loot groups in `scripts/loot/groups/custom/solo_unique_items_tier[1-3].lua`:
   ```lua
   {itemTemplate = "my_item_tier1", weight = 700000},
   ```

### Adding to a New NPC Group

1. Find the appropriate NPC loot table in `scripts/loot/groups/npc/`
2. Add the appropriate tier group:
   ```lua
   {groupTemplate = "solo_unique_items_tier1", weight = 1000000},
   ```
3. Adjust the weight based on NPC type (see Drop Rate Logic above)

## Lore-Friendly Naming Convention

Items follow a progression naming scheme:
- **Tier 1**: Scout's (exploration theme)
- **Tier 2**: Ranger's (wilderness expertise)
- **Tier 3**: Pathfinder's (master explorer)

Exceptions:
- Medkits: Field → Combat → Advanced
- Charms: Lucky → Fortunate → Blessed
- Bandoliers: Smuggler's → Freelancer's → Mercenary's
- Datapads: Tactical → Advanced Tactical → Elite Tactical
- Comms: Encrypted → Military → SpecOps

## Total Coverage

- **15 item types** × **3 tiers** = **45 total items**
- **26 NPC groups** with tier-appropriate loot drops
- Drop rates range from **5% to 15%** based on NPC type

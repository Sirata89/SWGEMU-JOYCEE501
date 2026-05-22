# Junk Dealer Crafted Items Feature

## Overview

This feature expands junk dealer functionality to accept player-crafted items for sale, similar to the implementation in the [legend-of-hondo](https://github.com/Tatwi/legend-of-hondo/blob/hondo-master/doc/features/mod-junkdealersbuycrafteditems.md) project.

Junk dealers will now buy any player-crafted item, with pricing based on schematic complexity and ingredient slots rather than resource quality. This prevents price inflation on servers with maxed resource stats.

## How It Works

### Crafting Process

When a player crafts an item:

1. During the `initialAssembly` phase in `CraftingSessionImplementation.cpp`, the system calculates a junk value
2. The junk value is determined by:
   - Base value: 50 credits
   - 20 credits per total resource unit (sum of all ingredient slot quantities)
   - 50 credits per schematic complexity level
   - Capped at 30,000 credits maximum
3. Player crafting skill modifier is applied (up to 50% bonus)
4. Random variance (±10%) is added
5. The item is marked with:
   - `junkDealerNeeded = 1` (generic dealer type)
   - `junkValue = calculated price`

### Selling to Junk Dealers

Players can sell crafted items to junk dealers that accept the appropriate type (currently set to generic). The check that previously prevented selling crafted items (`getCraftersName() == ""`) has been removed.

## Price Range

- **Simple items**: ~500-4,000 credits
- **Medium items**: ~4,000-15,000 credits
- **Complex items**: ~15,000-30,000 credits

This range is designed to match typical mission rewards, providing a viable alternative income source for crafters.

## Files Modified

### C++ Source Files

#### `src/server/zone/managers/crafting/CraftingManager.idl`
- Added method declaration: `public native int calculateFinalJunkValue(CreatureObject crafter, ManufactureSchematic manufactureSchematic);`

#### `src/server/zone/managers/crafting/CraftingManagerImplementation.cpp`
- Implemented `calculateFinalJunkValue()` method that:
  - Gets base value from laboratory
  - Applies player skill modifier (skill / 500, capped at 0.5)
  - Adds randomness (10% variance)
  - Returns final junk value

#### `src/server/zone/managers/crafting/labratories/SharedLabratory.h`
- Added virtual method declaration: `virtual int getJunkValue(ManufactureSchematic* manufactureSchematic);`

#### `src/server/zone/managers/crafting/labratories/SharedLabratory.cpp`
- Implemented `getJunkValue()` method that:
  - Calculates base value: 250 credits
  - Adds 1,500 credits per ingredient slot
  - Adds 500 credits per complexity level
  - Caps at 30,000 credits maximum
  - Returns total value

#### `src/server/zone/objects/player/sessions/crafting/CraftingSessionImplementation.cpp`
- Modified `initialAssembly()` to:
  - Calculate junk price using `craftingManager->calculateFinalJunkValue()`
  - Set `junkDealerNeeded = 1` on the prototype
  - Set `junkValue` on the prototype

### Lua Script Files

#### `bin/scripts/screenplays/junk_dealer/junk_dealer.lua`
- Removed the `tano:getCraftersName() == ""` check from line 67
- This allows player-crafted items to be sold to junk dealers

## Important Notes

### Existing Crafted Items

Items crafted **before** this implementation will not have junk values set. Only newly crafted items after the server rebuild will have junk dealer pricing.

### Resource Quality Independence

The pricing formula deliberately ignores actual resource quality stats. This prevents price inflation on servers with maxed resource qualities (e.g., all stats at 1000). Instead, pricing is based on:
- Number of ingredient slots
- Schematic complexity
- Player crafting skill

### Dealer Types

Currently, all crafted items are set to `junkDealerNeeded = 1` (generic dealer type). This means they can be sold to any generic junk dealer. Future expansions could add logic to assign specific dealer types based on item category (arms, finery, etc.).

## Building

After making these changes, rebuild the server:

```bash
cd MMOCoreORB
make clean
make
```

## Testing

1. Craft a new item (simple, medium, or complex)
2. Approach a generic junk dealer
3. Initiate conversation
4. Select the option to sell items
5. Verify the crafted item appears in the sell list with appropriate pricing
6. Sell the item and verify credit payment

## Configuration

To adjust pricing, modify the values in `SharedLabratory.cpp`:

```cpp
int totalValue = 250; // Base value
totalValue += 1500;   // Credits per slot
totalValue += complexity * 500; // Credits per complexity level
if (totalValue > 30000) // Maximum cap
    totalValue = 30000;
```

To adjust skill modifier, modify `CraftingManagerImplementation.cpp`:

```cpp
skillMod = crafter->getSkillMod(assemblySkill) / 500.0f; // Divisor
if (skillMod > 0.5f) // Cap
    skillMod = 0.5f;
```

## Credits

Based on the junk dealer crafted items feature from the [legend-of-hondo](https://github.com/Tatwi/legend-of-hondo) project.

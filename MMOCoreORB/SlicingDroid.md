# Slicing Droid Feature

## Overview

The Slicing Droid (R2-SLIC) is a custom NPC that allows players to slice weapons and armor, and add Damage Over Time (DOT) effects to weapons. This feature provides a convenient alternative to the traditional slicing system through a conversational interface.

## Features

- **Weapon Slicing**: Speed or damage enhancement (20-35% increase)
- **Armor Slicing**: Effectiveness or encumbrance reduction (20-35% improvement)
- **DOT Effects**: Add poison, disease, fire, or bleed DOTs to weapons
- **Item Filtering**: Automatically excludes components and only shows valid weapons/armor
- **Debug Logging**: Detailed logging to `log/slicingbot.log` for troubleshooting

## Pricing

- **Weapon/Armor Slicing**: 20,000 credits
- **DOT Slicing**: 100,000 credits

## Files Modified

### C++ Files

#### `src/server/zone/managers/director/DirectorManager.h`
- Added function declarations for `applySlice` and `applyDot`
- These functions are exposed to Lua as native callable functions

#### `src/server/zone/managers/director/DirectorManager.cpp`
- Implemented `applySlice()` function:
  - Takes item pointer and slice type as arguments
  - Generates random slice percentage (20-35%)
  - Applies slice to weapon (speed/damage) or armor (effectiveness/encumbrance)
  - Returns boolean success status
  - Removes powerup from weapon before damage slice
- Implemented `applyDot()` function:
  - Takes item pointer and DOT type as arguments
  - Generates random DOT values (strength, duration, potency, uses)
  - Applies DOT to weapon
  - Returns boolean success status
- Registered both functions with Lua engine in `initialize()`

### Lua Files

#### `bin/scripts/mobile/conversations/custom/slicing_droid_conv.lua`
- Conversation template defining the droid's dialogue options
- Screens:
  - `greeting`: Main menu with slicing options
  - `weapon_menu`: Speed/damage selection
  - `armor_menu`: Effectiveness/encumbrance selection
  - `special_menu`: DOT type selection (poison, disease, fire, bleed)
  - `trigger_*`: SUI trigger screens for each slice type
  - `pricing_info`: Pricing information screen
  - `goodbye`: Closing message

#### `bin/scripts/screenplays/custom/conversations/slicing_droid_convo_handler.lua`
- Main conversation handler implementing the slicing logic
- Key functions:
  - `showItemSelectionSUI()`: Displays item selection interface
    - Filters items by gameObjectType (weapons: 131072-131103, armor: 256-264)
    - Excludes components (gameObjectType >= 262144)
    - Stores item IDs in player data for callback
  - `suiItemSelectionCallback()`: SUI callback for item selection
    - Retrieves selected item ID from stored data
    - Calls `performSliceOnItem()`
  - `performSliceOnItem()`: Main slicing logic
    - Validates player has sufficient credits
    - Searches inventory for selected item
    - Checks if item is already sliced
    - Calls native C++ functions to apply slice/DOT
    - Handles success/failure messaging
  - `applySlice()`: Wrapper for native C++ `applySlice()`
  - `applyDot()`: Wrapper for native C++ `applyDot()`
  - `logDebug()`: Debug logging function
    - Writes to `log/slicingbot.log` with timestamps
    - Also prints to server console

## How It Works

### 1. Player Interaction Flow

1. Player approaches the slicing droid NPC
2. Player selects slicing option from conversation:
   - "I want to slice a weapon" → speed or damage
   - "I want to slice armor" → effectiveness or encumbrance
   - "Special: Add DOT to weapon" → poison, disease, fire, or bleed
3. SUI (Station User Interface) appears showing eligible items
4. Player selects an item from the list
5. Droid checks player's credits
6. Native C++ function applies the slice/DOT
7. Success or failure message is displayed

### 2. Item Filtering Logic

The SUI item selection uses `gameObjectType` filtering:

- **Weapons**: 131072-131103 (0x20000-0x2001F)
- **Armor**: 256-264 (0x100-0x108)
- **Components excluded**: 262144+ (0x40000+)

This ensures only valid weapons and armor appear in the selection list.

### 3. Slicing Mechanics

#### Weapon Slicing
- **Speed**: Reduces weapon attack delay by 20-35%
- **Damage**: Increases weapon damage by 20-35%
- Removes any attached powerup before damage slice

#### Armor Slicing
- **Effectiveness**: Increases base protection by 20-35%
- **Encumbrance**: reduces encumbrance by 20-35%

#### DOT Effects
- **Poison**: Applies poison damage over time
- **Disease**: Applies disease damage and stat reduction
- **Fire**: Applies fire damage over time
- **Bleed**: Applies bleed damage over time

DOT values are randomly generated:
- Damage per tick: 50-150
- Duration: 30-60 seconds
- Potency (resistance check): 100-200
- Uses: 500-1000

### 4. Data Storage

The system uses SWGEmu's data storage system:
- `writeStringData()` / `readStringData()`: For storing item IDs and slice types
- `writeData()` / `readData()`: For storing numeric cost values
- Data keys are prefixed with player ID to avoid conflicts

## Debugging

Debug output is written to `log/slicingbot.log` with timestamps and also printed to the server console with the prefix "SLICING DEBUG:".

To enable debugging, check the log file at:
```
bin/log/slicingbot.log
```

The log tracks:
- Component skipping (with gameObjectType)
- SUI callback invocations
- Item ID lookups in inventory
- Slice/DOT function calls and results

## Configuration

### Changing Prices

Edit `bin/scripts/screenplays/custom/conversations/slicing_droid_convo_handler.lua`:
```lua
local sliceCost = 20000  -- Weapon/armor slicing
local dotCost = 100000   -- DOT slicing
```

Also update the UI text in `bin/scripts/mobile/conversations/custom/slicing_droid_conv.lua` to reflect the new prices.

### Adjusting Slice Percentages

Edit `src/server/zone/managers/director/DirectorManager.cpp` in the `applySlice()` function:
```cpp
float slicePercent = (float)(System::random(15) + 20) / 100.0f;
```
- Change `15` to adjust the range width
- Change `20` to adjust the minimum value

### Adjusting DOT Values

Edit `src/server/zone/managers/director/DirectorManager.cpp` in the `applyDot()` function:
```cpp
int dotStrength = System::random(100) + 50;   // Damage per tick
int dotDuration = System::random(30) + 30;    // Duration in seconds
int dotPotency = System::random(100) + 100;   // Resistance check
int dotUses = System::random(500) + 500;      // Number of uses
```

## Installation

1. Compile the C++ changes:
   ```bash
   cd MMOCoreORB
   make
   ```

2. Ensure the Lua scripts are in place:
   - `bin/scripts/mobile/conversations/custom/slicing_droid_conv.lua`
   - `bin/scripts/screenplays/custom/conversations/slicing_droid_convo_handler.lua`

3. Spawn the slicing droid NPC in-game or add to a spawn area

4. Restart the server

## Usage

1. Approach the slicing droid NPC
2. Start a conversation
3. Select the type of slicing you want
4. Choose an item from the list
5. Confirm you have sufficient credits
6. The slice/DOT will be applied automatically

## Troubleshooting

### "Item not found in inventory"
- Check `log/slicingbot.log` for debug output
- Verify the item is still in your inventory
- Check if the item was moved or deleted between SUI display and selection

### No items appear in SUI
- Verify the item is a weapon or armor (not a component)
- Check the gameObjectType values in the debug log
- Ensure the item is not already sliced

### Slicing fails
- Check server console for error messages
- Verify the C++ changes were compiled
- Check that the native functions are registered correctly

### Debug output not appearing
- Ensure the `log/` directory exists and is writable
- Check server console for "SLICING DEBUG:" messages
- Verify `logDebug()` function is defined (not local)

## Credits

Custom implementation for SWGEmu server.

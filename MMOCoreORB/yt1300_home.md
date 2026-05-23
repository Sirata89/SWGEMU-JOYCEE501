# YT-1300 Interior - Player Decoratable Zone

A standalone dungeon zone featuring the YT-1300 (Millennium Falcon) interior that players can access via NPC transit and decorate with furniture.

## Features

- **Standalone Zone**: Uses dungeon1 zone (no JTL required)
- **Player Decoration**: Players can place up to 250 items inside
- **Permission System**: Admin, Entry, and Ban lists for access control
- **NPC Transit**: Entry NPC on Tatooine (Mos Eisley) and exit terminal inside
- **Multi-Cell Interior**: 6 cells (hall1, cockpit, lounge, hall4, storage5, storage6)
- **No Space Combat**: Purely a social/decoration space

## Files Created/Modified

### New Custom Files
- `scripts/screenplays/custom/yt1300_interior/yt1300_interior.lua` - Main screenplay
- `scripts/screenplays/custom/yt1300_interior/tatooine_mos_eisley_yt1300_entry.lua` - Entry NPC
- `scripts/screenplays/custom/yt1300_interior/yt1300_interior_entry_conv_handler.lua` - Conversation handler
- `scripts/screenplays/custom/yt1300_interior/yt1300_exit_terminal_menu_component.lua` - Exit terminal menu
- `scripts/mobile/custom/yt1300_transport_guide.lua` - Mobile template for entry NPC

### Modified Core Files
- `scripts/object/building/general/yt1300_interior_building.lua` - Building template
- `scripts/mobile/conversations/yt1300_interior_entry_conv.lua` - Conversation template
- `scripts/screenplays/screenplays.lua` - Added custom screenplay includes
- `scripts/mobile/conversations.lua` - Added conversation template include
- `scripts/mobile/serverobjects.lua` - Added mobile template include
- `scripts/object/building/general/serverobjects.lua` - Added building template include

## Setup Instructions

### 1. Server Configuration

Ensure dungeon1 is enabled in your config file (`bin/conf/config.lua`):

```lua
ZonesEnabled = {
    -- ... other zones ...
    "dungeon1",
    -- ... other zones ...
}
```

Restart your Core3 server to load the new scripts. The building will be spawned automatically in dungeon1 when the server starts.

## Usage

### For Players

1. **Enter the YT-1300 Interior**:
   - Go to Mos Eisley, Tatooine (coordinates: 3520, -4780) - outside the starport
   - Talk to the "YT-1300 Transport Guide" NPC
   - Select "I'd like to enter the YT-1300 Interior"
   - You will be teleported inside

2. **Exit the YT-1300 Interior**:
   - Find the "Exit Terminal" in the main hallway (hall1 cell)
   - Right-click and select "Exit to Mos Eisley"
   - You will be teleported back to Mos Eisley

3. **Decorate**:
   - Use standard furniture placement commands (drop, move, rotate)
   - Up to 250 items can be placed
   - Use `/moveFurniture` and `/rotateFurniture` commands

### For Administrators

#### Set Building Owner

To make a player the owner of the YT-1300 Interior:

```lua
-- In-game admin command or script
local screenplay = require("screenplays.custom.yt1300_interior.yt1300_interior")
screenplay:setBuildingOwner(pPlayer)
```

This grants the player admin permissions and allows them to manage the permission lists.

#### Manage Permissions

Players with admin access can use the ship permissions system:
- `/permissionListModify` to manage ADMIN, ENTRY, and BAN lists
- Grant other players access to decorate or enter

#### Adjust Settings

Edit `scripts/screenplays/custom/yt1300_interior/yt1300_interior.lua` to customize:

- **Building Template**: Change `buildingTemplate` if using a different ship interior
- **Building Spawn**: Modify `buildingSpawn` coordinates in dungeon1
- **Entry/Exit Points**: Modify `entryPoint` and `exitPoint` coordinates
- **Spawn Point**: Adjust `insideSpawnPoint` for where players appear inside

Edit `scripts/object/building/general/yt1300_interior_building.lua` to customize:

- **Item Limit**: Change `maxPlayerItems` (default: 250)
- **Furniture**: Add/remove items from `childObjects`

## Technical Details

### Building Template

The building uses the existing POB ship client template (`object/ship/player/player_yt1300.iff`) but is configured as a static building with:
- `PobShipContainerComponent` for decoration/permission support
- Building game object type (512) instead of ship type
- Ship-specific components removed (pilot chair, turret controls, etc.)

### Zone Architecture

- **Zone**: dungeon1 (shared with Corellian Corvette)
- **Building ID**: 5000000 (configurable)
- **Cells**: 6 interior cells from POB ship template
- **Container**: PobShipContainerComponent provides decoration system

### Permission System

Uses the existing POB ship permission system:
- **ADMIN**: Full control, can modify permissions
- **ENTRY**: Can enter and decorate
- **BAN**: Cannot enter

### Decoration System

Leverages POB ship decoration mechanics:
- Standard furniture drop/pickup
- Move and rotate commands
- Item limit enforcement
- Cell-based placement

## Troubleshooting

### Building not spawning

If the building doesn't spawn in dungeon1:
1. Check that dungeon1 zone is enabled
2. Look for errors in server logs during startup
3. Verify the building template path is correct

### NPC not spawning

If the entry NPC doesn't appear:
1. Verify Tatooine zone is enabled
2. Check the screenplay is registered in scripts/screenplays/screenplays.lua
3. Look for errors in server logs

### Cannot decorate

If players can't place items:
1. Verify the player has admin or entry permissions
2. Check the item limit hasn't been reached
3. Ensure PobShipContainerComponent is working (check logs)

### Teleport fails

If transport doesn't work:
1. Verify dungeon1 zone is enabled
2. Check the building exists in the database
3. Ensure the cell name matches the POB ship template

## Future Enhancements

Possible improvements:
- Multiple YT-1300 instances (different building IDs)
- Custom NPC vendors inside
- Quest integration
- Maintenance system (like player houses)
- Custom cell names
- Additional furniture templates
- Music/ambient sound customization

## Credits

Based on SWGEmu's POB ship system and Corellian Corvette dungeon implementation.

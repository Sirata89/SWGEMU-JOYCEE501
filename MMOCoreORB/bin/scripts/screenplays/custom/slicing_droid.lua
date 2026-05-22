-- Slicing Droid ScreenPlay
-- Spawns an R2 droid at Theed Spaceport that can slice weapons and armor

SlicingDroidScreenPlay = ScreenPlay:new {
	numberOfActs = 1,
	screenplayName = "SlicingDroidScreenPlay",
}

registerScreenPlay("SlicingDroidScreenPlay", true)

function SlicingDroidScreenPlay:start()
	if (isZoneEnabled("naboo")) then
		self:spawnNaboo()
	end
end

function SlicingDroidScreenPlay:spawnNaboo()
	-- Spawn R2-SLIC at Theed Spaceport
	-- Coordinates: -4858.834, 5.9483199, 4164.0679 (from waypoint data)
	-- Adjusted to be "out front" of the spaceport
	spawnMobile("naboo", "slicing_droid", 300, -4860, 6, 4170, 45, 0)
end

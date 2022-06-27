local Deluge = include("Deluge")
local json = include("json")
local Noah = RegisterMod("Noah", 1)

-- # DELUGE USAGE #
function Noah:UseDeluge(collectibleType, RNG, player, useFlags, slot)
  return Deluge.Use(player)
end
Noah:AddCallback(ModCallbacks.MC_USE_ITEM, Noah.UseDeluge, CollectibleType.COLLECTIBLE_DELUGE)

-- # DEBUG COMMANDS #
function Noah:OnCommand(command, args)
end
Noah:AddCallback(ModCallbacks.MC_EXECUTE_CMD, Noah.OnCommand)

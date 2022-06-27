-- Init mod globals
SynthCollectibleType = {}
SynthPlayerType = {}

-- Import all modules
local Deluge = include("Deluge")
local NoahCharacter = include("NoahCharacter")
local json = include("json")
local Noah = RegisterMod("Noah", 1)

-- # POST GAME START #
function Noah:StartRun(isContinued)
  NoahCharacter.Reset(isContinued)
end
Noah:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Noah.StartRun)

-- # POST PLAYER INIT #
function Noah:PlayerInit(player)
  if player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH then
    NoahCharacter.AddCostume(player)
    NoahCharacter.AddPocketItem(player)
  end
end
Noah:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Noah.PlayerInit)

-- # STAT CACHE CALLBACK #
function Noah:ModifyStats(player, cacheFlag)
  NoahCharacter.ModifyStats(player, cacheFlag)
end
Noah:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Noah.ModifyStats)

-- # Update Noah Effects #
function Noah:NoahEffectUpdate(player)
  NoahCharacter.WaterBuff(player)
end
Noah:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Noah.NoahEffectUpdate, SynthPlayerType.PLAYER_NOAH)

-- # DELUGE USAGE #
function Noah:UseDeluge(collectibleType, RNG, player, useFlags, slot)
  return Deluge.Use(player)
end
Noah:AddCallback(ModCallbacks.MC_USE_ITEM, Noah.UseDeluge, SynthCollectibleType.COLLECTIBLE_DELUGE)

-- # DEBUG COMMANDS #
function Noah:OnCommand(command, args)
  if command == "check_water" then
    print(Game():GetRoom():HasWater())
  end
end
Noah:AddCallback(ModCallbacks.MC_EXECUTE_CMD, Noah.OnCommand)

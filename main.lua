-- Init mod globals
SynthCollectibleType = {}
SynthPlayerType = {}

-- Import all modules
local Deluge = include("Deluge")
local NoahCharacter = include("NoahCharacter")
local json = include("json")
local Noah_Synth = RegisterMod("Noah_Synth", 1)

-- # POST GAME START #
function Noah_Synth:StartRun(isContinued)
  NoahCharacter.Reset(isContinued)
end
Noah_Synth:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Noah_Synth.StartRun)

-- # POST PLAYER INIT #
function Noah_Synth:PlayerInit(player)
  if player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH then
    NoahCharacter.AddCostume(player)
    NoahCharacter.AddPocketItem(player)
  end
end
Noah_Synth:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Noah_Synth.PlayerInit)

-- # STAT CACHE CALLBACK #
function Noah_Synth:ModifyStats(player, cacheFlag)
  NoahCharacter.ModifyStats(player, cacheFlag)
end
Noah_Synth:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Noah_Synth.ModifyStats)

-- # Update Noah Effects #
function Noah_Synth:NoahEffectUpdate(player)
  NoahCharacter.WaterBuff(player)
end
Noah_Synth:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Noah_Synth.NoahEffectUpdate, SynthPlayerType.PLAYER_NOAH)

-- # DELUGE USAGE #
function Noah_Synth:UseDeluge(collectibleType, RNG, player, useFlags, slot)
  return Deluge.Use(player)
end
Noah_Synth:AddCallback(ModCallbacks.MC_USE_ITEM, Noah_Synth.UseDeluge, SynthCollectibleType.COLLECTIBLE_DELUGE)

-- # DEBUG COMMANDS #
function Noah_Synth:OnCommand(command, args)
  if command == "check_water" then
    print(Game():GetRoom():HasWater())
  end
end
Noah_Synth:AddCallback(ModCallbacks.MC_EXECUTE_CMD, Noah_Synth.OnCommand)

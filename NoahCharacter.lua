local Helper = include("Helper")
local NoahCharacter = {}

SynthPlayerType.PLAYER_NOAH = Isaac.GetPlayerTypeByName("Noah")
-- local noahCostume = Isaac.GetCostumeIdByPath("gfx/characters/noah.anm2")

local waterActive = false

function NoahCharacter.AddCostume(player)
  -- player:AddNullCostume(noahCostume)
end

function NoahCharacter.AddPocketItem(player)
  player:SetPocketActiveItem(SynthCollectibleType.COLLECTIBLE_DELUGE)
end

function NoahCharacter.Reset()
  waterActive = false
end

function NoahCharacter.WaterBuff(player)
  if not waterActive and Game():GetRoom():HasWater() then
    waterActive = true
    player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    player:EvaluateItems()
  elseif waterActive and not Game():GetRoom():HasWater() then
    waterActive = false
    player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    player:EvaluateItems()
  end
end

function NoahCharacter.ModifyStats(player, cacheFlag)
  if player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH and waterActive and cacheFlag == CacheFlag.CACHE_FIREDELAY then
    player.MaxFireDelay = player.MaxFireDelay * 0.75
  end
end

return NoahCharacter
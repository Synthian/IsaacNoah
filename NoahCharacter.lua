local Helper = include("Helper")
local NoahCharacter = {}

SynthPlayerType.PLAYER_NOAH = Isaac.GetPlayerTypeByName("Noah")
-- local noahCostume = Isaac.GetCostumeIdByPath("gfx/characters/noah.anm2")

BASE_LUCK = 2
FLOODED_FIRE_RATE_MULTIPLIER = 1.25
DAMAGE_MULTIPLIER = 0.75

local waterActive = false

function NoahCharacter.AddCostume(player)
  -- player:AddNullCostume(noahCostume)
end

function NoahCharacter.AddPocketItem(player)
  player:SetPocketActiveItem(SynthCollectibleType.COLLECTIBLE_DELUGE, ActiveSlot.SLOT_POCKET, true)
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
  if player:GetPlayerType() ~= SynthPlayerType.PLAYER_NOAH then return end
  if cacheFlag == CacheFlag.CACHE_FIREDELAY and waterActive then
    local newRate = Helper.TearDelayToFireRate(player.MaxFireDelay) * FLOODED_FIRE_RATE_MULTIPLIER
    player.MaxFireDelay = Helper.FireRateToTearDelay(newRate)
  elseif cacheFlag == CacheFlag.CACHE_DAMAGE then
    player.Damage = player.Damage * DAMAGE_MULTIPLIER
  elseif cacheFlag == CacheFlag.CACHE_LUCK then
    player.Luck = player.Luck + BASE_LUCK
  end
end

return NoahCharacter
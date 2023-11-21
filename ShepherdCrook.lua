local Helper = include("Helper")
local ShepherdCrook = {}

SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK = Isaac.GetItemIdByName("Shepherd's Crook")

local crookTears = {}

function ShepherdCrook.ApplyTearEffect(tear, variant)
  local player = Helper.PlayerFromTear(tear)
  if player and tear.FrameCount == 0 or (tear.FrameCount == 1 and tear.Parent:ToFamiliar()) then
    if player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH or player:HasCollectible(SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK) then
      if (math.random() < 0.1) then
        tear:SetColor(Color(0.5, 0.5, 1), -1, 1, false, false) -- TODO: Replace with tear variant?
        table.insert(crookTears, GetPtrHash(tear))
      end
    end
  end
end

return ShepherdCrook

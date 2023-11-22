local Helper = include("Helper")
local ShepherdCrook = {}

SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK = Isaac.GetItemIdByName("Shepherd's Crook")

local crookTears = {}

function ShepherdCrook.InitializeTears(tear, variant)
  local player = Helper.PlayerFromTear(tear)
  if player and tear.FrameCount == 0 or (tear.FrameCount == 1 and tear.Parent:ToFamiliar()) then
    -- Create new Crook tears
    if player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH or player:HasCollectible(SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK) then
      if (math.random() < 0.5) then
        tear:SetColor(Color(0.5, 0.5, 1), -1, 1, false, false) -- TODO: Replace with tear variant?
        crookTears[GetPtrHash(tear)] = tear
      end
    end

    -- Cleanup tracking of existing Crook tears
    for k, tear in pairs(crookTears) do
      if not tear:Exists() then
        crookTears[k] = nil
      end
    end
  end
end

-- TODO: Make these enemies exempt: Grubs, Carrion Queen, Chub, C.H.A.D (they die instantly)
function ShepherdCrook.RunCleaverEffect(damagedEntity, source)
  if (source and source.Entity and source.Type == EntityType.ENTITY_TEAR and crookTears[GetPtrHash(source.Entity)]) then
    split(damagedEntity)
  end
  -- TODO: Handle lasers
end

function split(damagedEntity)
  local entities = Isaac:GetRoomEntities()
  local unaffectedEnemies = {}

  -- Store list of enemies, and mark as friendly
  for i, entity in ipairs(entities) do
    if entity:IsEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) and GetPtrHash(entity) ~= GetPtrHash(damagedEntity) then
      table.insert(unaffectedEnemies, entity)
      entity:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
    end
  end

  -- Run Meat Cleaver
  Isaac.GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_MEAT_CLEAVER, UseFlag.USE_NOANIM) --??

  -- Remove friendly tag where appropriate
  for i, entity in ipairs(unaffectedEnemies) do
    entity:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
  end
end

return ShepherdCrook

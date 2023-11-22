local Helper = include("Helper")
local Deluge = {}

SynthCollectibleType.COLLECTIBLE_DELUGE = Isaac.GetItemIdByName("Deluge")
local uses = 0

function Deluge.Use(player)
  local entities = Isaac:GetRoomEntities()
  local survivors = {}
  local entitiesByType = {}

  -- Filter out bosses, friendly enemies, and sort entities by type
  for i, entity in ipairs(entities) do
    if entity:IsEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
      if (entity:IsBoss()) then
        table.insert(survivors, entity)
      elseif not entitiesByType[entity.Type] then
        entitiesByType[entity.Type] = {entity}
      else
        table.insert(entitiesByType[entity.Type], entity)
      end
    end
  end

  -- Kill singles and cull groups down to 2
  for type, entList in pairs(entitiesByType) do
    if Helper.TableLength(entList) < 2 then
      entList[1]:Die()
    else
      for i, entity in ipairs(entList) do
        if (i < 3) then
          table.insert(survivors, entity)
        else
          entity:Die()
        end
      end
    end
  end

  -- Mark enemies as friendly, execute Flush!, uncharm enemies
  for i, entity in ipairs(survivors) do
    entity:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
  end
  player:UseActiveItem(CollectibleType.COLLECTIBLE_FLUSH, UseFlag.USE_NOANIM)
  SFXManager():Stop(SoundEffect.SOUND_FLUSH)
  for i, entity in ipairs(survivors) do
    entity:ClearEntityFlags(EntityFlag.FLAG_FRIENDLY)
  end
end

return Deluge

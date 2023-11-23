local Helper = include("Helper")
local ShepherdCrook = {}

SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK = Isaac.GetItemIdByName("Shepherd's Crook")

local EXEMPT_ENTITY_TYPES = {
  [EntityType.ENTITY_CHUB] = true,
  [EntityType.ENTITY_GRUB] = true
}
local BLUE = Color(0.3, 0.3, 1)

local crookTears = {}

function ShepherdCrook.InitializeTears(tear)
  local player = Helper.PlayerFromDamageSource(tear)
  if player and (tear.FrameCount == 0 or (tear.FrameCount == 1 and tear.Parent and tear.Parent:ToFamiliar())) then
    -- Bail if tear is Ludovico
    if tear:HasTearFlags(TearFlags.TEAR_LUDOVICO) then return end
    tagNewTearOrBomb(player, tear)
  end
end

function ShepherdCrook.InitializeBombs(bomb)
  local player = Helper.PlayerFromDamageSource(bomb)
  if player and bomb.FrameCount == 1 then
    tagNewTearOrBomb(player, bomb)
  end
end

-- TODO: Any way to make normal tech lasers have the usual chance vs other lasers reduced chance
function ShepherdCrook.RunCleaverEffect(damagedEntity, flags, source)
  if (source and source.Entity) then
    if source.Type == EntityType.ENTITY_TEAR then

      local player = Helper.PlayerFromDamageSource(source.Entity)
      if source.Entity:ToTear():HasTearFlags(TearFlags.TEAR_LUDOVICO) and doesProc(player, true) then
        source.Entity:SetColor(BLUE, 4, 1, false, false)
        split(damagedEntity)
      else
        if crookTears[GetPtrHash(source.Entity)] then
          split(damagedEntity)
        end
      end

    elseif source.Type == EntityType.ENTITY_BOMB then

      if crookTears[GetPtrHash(source.Entity)] then
        split(damagedEntity)
      end

    elseif source.Type == EntityType.ENTITY_KNIFE then

      local player = Helper.PlayerFromDamageSource(source.Entity)
      if isCrookEligible(player) and doesProc(player, true) then
        split(damagedEntity)
      end

    elseif flags & DamageFlag.DAMAGE_LASER then
      
      local player = Helper.PlayerFromDamageSource(source.Entity)
      if player and isCrookEligible(player) and doesProc(player, true) then
        split(damagedEntity)
      end

    end
  end
end

-- # PRIVATE FUNCS #

function tagNewTearOrBomb(player, entity)
  -- Create new Crook tear/bomb
  if isCrookEligible(player) then
    if doesProc(player, false) then
      entity:SetColor(BLUE, -1, 1, false, false) -- TODO: Replace with tear variant?
      crookTears[GetPtrHash(entity)] = entity
    end
  end

  -- Cleanup tracking of existing Crook tears
  for k, e in pairs(crookTears) do
    if not e:Exists() then
      crookTears[k] = nil
    end
  end
end

function split(damagedEntity)
  -- Bail if this enemy type is blacklisted
  if EXEMPT_ENTITY_TYPES[damagedEntity.Type] then return end

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

function isCrookEligible(player)
  return player:GetPlayerType() == SynthPlayerType.PLAYER_NOAH or player:HasCollectible(SynthCollectibleType.COLLECTIBLE_SHEPHERDS_CROOK)
end

function doesProc(player, laser)
  local cappedLuck = Helper.Ternary(player.Luck < 12, player.Luck, 12)
  local chance = 1 / (10 - 0.5 * cappedLuck)
  if laser then chance = chance * 0.1 end
  return math.random() < chance
end

return ShepherdCrook

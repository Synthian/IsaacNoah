local Helper = {}

function Helper.RandomNearbyPosition(entity)
  local position = Vector(entity.Position.X + math.random(0, 80), entity.Position.Y + math.random(0, 80))
  position = Isaac.GetFreeNearPosition(position, 1)
  return position
end

function Helper.RandomVelocity()
  return Vector(math.random() * 2, math.random() * 2)
end

function Helper.OneIndexedRandom(rng, max)
  return rng:RandomInt(max) + 1
end

function Helper.TableLength(table)
  local length = 0
  for _ in pairs(table) do
    length = length + 1
  end
  return length
end

function Helper.TearDelayToFireRate(delay)
  return 30 / (delay + 1)
end

function Helper.FireRateToTearDelay(rate)
  return math.max((30 / rate) - 1, -0.75)
end


local TEAR_EFFECT_FAMILIARS = {
  [FamiliarVariant.FATES_REWARD] = true,
  [FamiliarVariant.INCUBUS] = true,
  [FamiliarVariant.TWISTED_BABY] = true,
  [FamiliarVariant.CAINS_OTHER_EYE] = true,
  [FamiliarVariant.SPRINKLER] = true,
  [FamiliarVariant.BLOOD_BABY] = true,
  [FamiliarVariant.UMBILICAL_BABY] = true
}
function Helper.PlayerFromDamageSource(source)
  if source:ToPlayer() then return source:ToPlayer() end
  if source.Parent and source.Parent:ToPlayer() then return source.Parent:ToPlayer() end

  local familiar = nil
  if source:ToFamiliar() then
    familiar = source:ToFamiliar()
  elseif source.Parent and source.Parent:ToFamiliar() then
    familiar = source.Parent:ToFamiliar()
  else
    return nil
  end

  -- Isaac.ConsoleOutput("[PlayerFromDamageSource] Variant: " .. familiar.Variant .. "\n")
  if TEAR_EFFECT_FAMILIARS[familiar.Variant] then
    return familiar:ToFamiliar().Player
  else
    return nil
  end
end

function Helper.Ternary (cond, T, F)
  if cond then return T else return F end
end

return Helper
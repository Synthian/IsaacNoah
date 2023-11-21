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

function Helper.PlayerFromTear(tear)
  local parent = tear.Parent
  if not parent then return nil end

  if parent:ToPlayer() then
    return parent:ToPlayer()
  elseif parent:ToFamiliar() and parent.Variant == FamiliarVariant.FATES_REWARD then
    return parent:ToFamiliar().Player
  else
    return nil
  end
end

return Helper
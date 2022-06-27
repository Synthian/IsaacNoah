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

return Helper
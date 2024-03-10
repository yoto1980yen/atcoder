x, y, z = gets.split.map(&:to_i)
if x < 0
    tuuro = (x..0).to_a
else
    tuuro = (0..x).to_a
end
if z < 0
    ham = (z..0).to_a
else
    ham = (0..z).to_a
end
if tuuro.include?(y) == false
    pp x.abs
    return
end
if ham.include?(y) == false
    pp ((x - z).abs + (0 - z).abs)
    return
end
pp -1
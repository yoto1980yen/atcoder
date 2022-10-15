x, k = gets.split.map(&:to_i)
(1..k).each do |i|
    kakeru = -1 * i
    x = x.round(kakeru)
end
puts x
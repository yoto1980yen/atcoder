n = gets.to_i
a = gets.split.map(&:to_i)
pp a
a.each.with_index do |k, i|
    pp k
    pp i + 1
    (0...n)
end
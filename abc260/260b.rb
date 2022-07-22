input = gets.split.map(&:to_i)
n = input[0]
x = input[1]
y = input[2]
z = input[2]
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)
ab = []
goukaku = []
(0...n).each do |i|
    ab.push([a[i], b[i], i])
end
ab.sort {|a, b|
    a[0] <=> b[0]
}
(0...x).each do |i|
    if i == x &&
    goukaku.push(ab[i])
end
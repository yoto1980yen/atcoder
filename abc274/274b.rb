h, w = gets.split.map(&:to_i)
list = []
tate = []
w.times do |i|
    tate[i] = 0
end
h.times do |i|
    list << gets.chomp.split("")
    w.times do |j|
        tate[j] += 1 if list[i][j] == "#"
    end
end
puts tate.join(" ")
list = []
9.times do
    list << gets.chomp.split("")
end
9.times do |i|
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list[i] << "."
    list << [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
end
tyoten = []
ans = 0
(0...81).each do |i|
    h = i / 9
    w = i % 9
    if list[h][w] == "#"
        tyoten << [h, w]
    end
    
end
(0...tyoten.size).each do |i|
    ((i + 1)...tyoten.size).each do |j|
        yoko = (tyoten[i][0] - tyoten[j][0]).abs
        tate = (tyoten[i][1] - tyoten[j][1]).abs
        if list[tyoten[i][0] + tate][tyoten[i][1] + yoko] == "#" && list[tyoten[j][0] + tate][tyoten[j][1] + yoko] == "#"
            ans += 1 
            ans -= 1 if yoko == 0 
        end
    end
end
pp ans
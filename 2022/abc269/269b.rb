map = []
(0...10).each do |i|
    map.push(gets.chomp.split(""))
end
a = 0
b = 0
c = 0
d = 0
count = 0
(0...10).each do |i|
    if count == 0
        (0...10).each do |j|
            now = map[i][j]
            if now == "#"
                if count != 1
                    a = i + 1
                    c = j + 1
                end
                count = 1
            end
            if count == 1
                if now == "."
                    d = j
                    break
                elsif j == 9
                    d = 10
                    break
                end
            end
        end
    end
    if count == 1
        if map[i].include?("#") == false
            b = i
            break
        end
        if i == 9
            b = 10
            break
        end
    end
end
puts "#{a} #{b}"
puts "#{c} #{d}"
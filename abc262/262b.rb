input = gets.split.map(&:to_i)
n = input[0]
m = input[1]
uv = []
count = 0
(0...m).each do 
    uv.push(gets.split.map(&:to_i))
end
uvsort = uv.sort
uvsortg = uvsort.group_by(&:first)
found = []
(0...m).each do |i|
    (i + 1...m).each do |j|
        if uvsort[j][0] == uvsort[i][1]
            uvsortg[uvsort[i][0]].each do |k|
                found.push(k[1])
            end
            count += 1 if found.include?(uvsort[j][1])
        end
    end
    found = []
end
pp count
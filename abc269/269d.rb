def near(l, r)
    list = []
    list.push([l + 1, r + 1])
    list.push([l, r + 1])
    list.push([l + 1, r])
    list.push([l - 1, r - 1])
    list.push([l - 1, r])
    list.push([l, r - 1])
    return list
end
n = gets.to_i
grid = []
n.times do 
    grid.push(gets.split.map(&:to_i))
end
pp grid
ans = []
(0...n).each do |i|
    nowgrid = grid[i]
    nearleft = nowgrid[0]
    nearriht = nowgrid[1]
    nearlist = near(nearleft, nearriht)
    grid.each do |j|
        nearlist.push(j)
    end
    uniq = nearlist.uniq
    ans.push(nearlist.size - uniq.size)
end

# 考えてたら「あっこれは無理だ」となったので終了
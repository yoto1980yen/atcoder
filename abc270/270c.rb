n, x, y= gets.split.map(&:to_i)
tree = []
(0...(n - 1)).each do |i|
    tree.push(gets.split.map(&:to_i))
end
tree = tree.sort
list = []
ans = []
(0...(n - 1)).each do |i|
    if list.empty?
        list.push(tree[i])
        next
    end
    list.each do |j|
        if j.include?(tree[i][0])
            if j.last == tree[i][0]
                j.push(tree[i][1])
            else
                now = j.index(tree[i][0])
                neww = j
                neww[now + 1] = tree[i][1]
                list.push(neww)
            end
        elsif j.include?(tree[i][1])
            if j.first == tree[i][1]
                j.unshift(tree[i][0])
            else
                now = j.index(tree[i][1])
                neww = j
                neww[now - 1] = tree[i][0]
            end
        else
            list.push(tree[i])
        end
    end
    pp list
end
pp list
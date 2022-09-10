n = gets.to_i

a = gets.split.map(&:to_i)
max = a.sort.reverse
min = a.sort
count = 0
loop do
    mod = max.first % max.last
    
    if mod == 0
        max.shift()
    else
        max.shift()
        max.push(mod)
    end
    count += 1
    if max.size == 1
        puts count
        break
    end
end
n = gets.to_i

a = gets.split.map(&:to_i)
sorted = a.sort
sort = a.each_with_index.sort.reverse
size = a.size - 1
i = 0
loop do
    maxindex = sort[i][1]
    next if maxindex == size
    sabun = size - maxindex
    pp maxindex
    pp size
    if sabun % 2 == 1
        right = a[maxindex]
        a[maxindex] = a[maxindex + 1]
        a[maxindex + 1] = right
        puts "A#{maxindex + 1}"
    else
        right = a[maxindex]
        a[maxindex] = a[maxindex + 2]
        a[maxindex + 2] = right
        puts "B#{maxindex + 1}"
    end
    i += 1
    pp a
    pp sorted
    break if a == sorted
    sort = a.each_with_index.sort.reverse
end
n = gets.to_i

ryouri = gets.split.map(&:to_i)
count = 0
(0...n).each do |i|
    now = 0
    (0...n).each do |j|
        menu = ryouri.index(j)
        if menu == (j - 1) % n
            now += 1
        elsif menu == j
            now += 1
        elsif menu == (j + 1) % n
            now += 1
        end
    end
    if count < now
        count = now
    end    
    last = ryouri.pop
    ryouri.unshift(last)
end
pp count
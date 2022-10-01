n = gets.to_i
a = gets.split.map(&:to_i).uniq.sort
juhuku = n - a.size
if n <= 1
    if a[0] != 1
        puts 0
    else
        puts 1
    end
    return
end
(1...n + 2).each do |i|
    if a.first == i 
        a.shift
        next
    end
    if juhuku == 0
        if a.size < 2
            puts i - 1
            return
        else
            a.pop
            a.pop
        end
    elsif juhuku >= 2
        juhuku -= 2
    elsif juhuku == 1
        if a.size < 1
            puts i - 1
            return
        end
        juhuku -= 1
        a.pop
    end
    
end
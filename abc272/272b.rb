n, m = gets.split.map(&:to_i)
list = []
(n + 1).times do
    list << []
end
(0...m).each do |i| 
    now = gets.split.map(&:to_i)
    ninzu = now.shift
    (0...now.size).each do |j|
        now.each do |k|
            list[now[j]] << k
        end
    end
end
list.shift
list.each do |i|
    next if i.uniq.size == n
    puts "No"
    return
end
puts "Yes"
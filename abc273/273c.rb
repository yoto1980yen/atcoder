n = gets.to_i
a = gets.split.map(&:to_i)
auniq = a.uniq.sort
max = auniq.size
syurui = {}
(0...max).each do |i|
    now = auniq[i]
    syurui[now] = max - i - 1
end
asort = a.sort.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h
(0...n).each do |i|
    if i >= max
        puts 0 
        next
    end
    if i == syurui[auniq.last]
        puts asort[auniq.last]
        auniq.pop
    else
        puts 0
    end
end
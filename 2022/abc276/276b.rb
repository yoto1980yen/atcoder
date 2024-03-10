n, m = gets.split.map(&:to_i)
list = []
(n + 1).times do
    list << []
end
m.times do |i|
    now = gets.split.map(&:to_i)
    list[now[0]] << now[1]
    list[now[1]] << now[0]
end

(1..n).each do |i|
    puts "#{list[i].size} #{list[i].sort.join(" ")}"
end
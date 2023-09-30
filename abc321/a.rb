now = gets.split("").map(&:to_i).reverse
(now.size - 1).times do |i|
    pp now[1]
    pp
    next if now[i] <= now[i + 1]
    puts "No"
    return
end
puts "Yes"
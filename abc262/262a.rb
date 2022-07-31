y = gets.to_i

if y % 4 == 2
    pp y 
elsif y % 4 == 3
    pp y + 3
elsif y % 4 == 1
    pp y + 1
elsif y % 4 == 0
    pp y + 2
end

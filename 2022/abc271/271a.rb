input = gets.to_i.to_s(16)
ans = input.upcase
if ans.size == 1
    puts "0#{ans}"
else
    puts ans
end
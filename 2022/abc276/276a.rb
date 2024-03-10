n = gets.chomp
ans = n.rindex("a")
if ans.nil?
    puts -1
else
    puts ans + 1
end
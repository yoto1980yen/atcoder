t = gets.split.map(&:to_i)
(0...100).each do |i|
    p = gets.to_i
    if t[i] == 1
        puts "R\n"
    elsif t[i] == 2
        if p >= (100 - i) / 3
            puts "B\n"
        else
            puts "F\n"
        end
    else
        if p >= (100 - i) / 4
            puts "R\n"
        else
            puts "F\n"
        end
    end
    STDOUT.flush
end
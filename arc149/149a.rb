n , m = gets.split.map(&:to_i)
sosuu = [0, 1 , 11, 37, 101, 271, 407, 4649, 1111, 50653, 2981, 513239, 3737, 265371653, 51139, 10027, 0, 5363222357]
range = (10 ** n).to_s.split("").map(&:to_i).size - 1
sosuu.each_with_index do |i, j|
    next if i == 0
    now = m * i
    seiri = now.to_s.split("").map(&:to_i).uniq.size
    if seiri == 1
        first = now.to_s.split("").map(&:to_i).uniq.first
        if first == 1 || first == 3
            first = 9
        elsif first == 2 || first == 4
            first = 8
        end
        ans = []
        (0...(range / j * j)).each do |x|
            ans << first
        end
        puts ans.join("")
        return
    end
end
puts -1
M, e = gets.split.map(&:to_f)
puts N = 20
(0...M).each do |i|
    g = ""
    (N * (N - 1) / 2).times do |j|
        g += rand(0..1).to_s
    end
    puts g.to_i
end
100.times do |i|
    h = gets.split("").map(&:to_i)
    puts t = [h.count(1), M - 1].min
    STDOUT.flush
end
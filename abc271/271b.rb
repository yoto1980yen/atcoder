n, q = gets.split.map(&:to_i)
list = []
n.times do 
    list << gets.split.map(&:to_i)
end
want = []
q.times do 
    want << gets.split.map(&:to_i)
end
want.each do |i|
    h = i[0] - 1
    w = i[1] 
    puts list[h][w]
end
n = gets.to_i
nlist = n.to_s(2).split("").map(&:to_i).reverse
oklist = []
count = 0
(0...nlist.size).each do |i|
    break if count == 15
    if nlist[i] == 1
        count += 1
        oklist.push(2 ** (i))
    end
end
answers = []
(0...oklist.size).each do |i|
    now = oklist.combination(i + 1).to_a
    now.each do |j|
        answers.push(j.sum)
    end
end
answers.push(0) 
answers.sort.each do |k|
    pp k
end
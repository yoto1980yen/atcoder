# 結局無理だった
require 'set'
n = gets.to_i
a = gets.split.map(&:to_i).to_set
heikin = a.sum(0.0) / a.size
max = a.max
newlist = Set.new
record = n
(2...heikin).each do |i|
    a.each do |j|
        newlist.add(j % i)
    end
    count = newlist.size
    if count < record
        record = count
    end
    newlist = Set.new
end
puts record
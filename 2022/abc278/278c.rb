# じかんぎれだけどAC
require 'set'
def main
    n, q = intary
    sets = {}
    q.times do |i|
        t, a, b = intary
        if t == 1
            if sets[a]
                sets[a].add(b)
            else
                sets[a] = Set.new([b])
            end
        end
        if t == 2
            if sets[a]
                sets[a].delete(b)
            end
        end
        if t == 3
            unless sets[a]
                puts "No"
                next
            end
            unless sets[b]
                puts "No"
                next
            end
            judea = sets[a].include?(b)
            judeb = sets[b].include?(a)
            if judea && judeb 
                puts "Yes"
            else
                puts "No"
            end
        end
    end
end


#----------------------------------------------------------------------------------
def int
    gets.to_i
end
def intary
    gets.split.map(&:to_i)
end
def str
    gets.chomp
end
# 約数列挙
def divisors(n)
    result = []
    doit = ->(pd, acc) {
        return if pd.empty?
        x, *xs = pd
        (0..x[1]).each do |i|
            e = acc * x[0] ** i
            result << e
            doit.(xs, e)
        end
    }
    doit.(n.prime_division, 1)
    result.uniq
end
# 累積和作成
def ruiseki(arr)
    s = Array.new(arr.size + 1)
    s[0] = 0
    (0...arr.size).each do |i|
        s[i+1] = s[i] + arr[i]
    end
    return s
end

main
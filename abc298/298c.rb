def main
    n = int
    q = int
    hako = {}
    (n + 1).times do |i|
        hako[i] = {}
    end
    q.times do 
        query = intary
        if query.first == 1
            unless hako[query[2]].key?(query[1])
                hako[query[2]][query[1]] = 1
            else
                hako[query[2]][query[1]] += 1
            end
        elsif query.first == 2
            ans = []
            hako[query.last].sort.each do |v, i|
                i.times do |j|
                    ans << v
                end
                
            end
            puts ans.join(" ")
        elsif query.first == 3
            ans = []
            hako.sort.each do |i, v|
                ans << i if v.include?(query.last)
            end
            puts ans.join(" ")
        end
    end
end

#----------------------------------------------------------------------------------
require "set"
require "prime"
def int
    gets.to_i
end

def intary
    gets.split(" ").map(&:to_i)
end

def str
    gets.chomp
end

def strary
    gets.chomp.split("")
end

def is_lower?(c)
    c != c.upcase
end

def number?(str)
nil != (str =~ /\A[0-9]+\z/)
end

def nisinsu(int)
    return int.to_s(2).chomp
end

def zeroume(keta, int)
    sprintf("%0#{keta}d", int)
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
    
    result.uniq.sort
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
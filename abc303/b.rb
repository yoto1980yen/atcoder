def main
    n, m = intary
    map = []
    nhito = {} 
    (n + 1).times do |i|
        nhito[i] = []
    end
    m.times do |i|
        map << intary
    end
    m.times do |i|
        (n - 1).times do |j|
            nhito[map[i][j]] << map[i][j + 1]
            nhito[map[i][j + 1]] << map[i][j]
        end
    end
    count = 0
    (n + 1).times do |i|
        next if i == 0
        nhito[i] = nhito[i].uniq.sort
        count += n - nhito[i].size - 1
    end
    pp count / 2
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
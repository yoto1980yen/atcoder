def main
    n = int
    hito = []
    n.times do |i|
        hito << []
        hito[i] << int
        hito[i] << intary
    end
    x = int
    ans = []
    min = 0
    mins = []
    hito.each.with_index do |v, i|
        if v[1].include?(x)
            ans << [i + 1, v[0]]
            mins << v[0]
        end
    end
    anss = []
    if mins.size != 0
        ans.each do |i|
            if i[1] == mins.min
                anss << i[0]
            end
        end
        puts anss.size
        puts anss.join(" ")
    else
        puts min
        puts ""
    end
end

#----------------------------------------------------------------------------------
require "set"
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

def grouping(ary)
    ary.slice_when { |a, b| a != b }.to_a
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
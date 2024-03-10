def main
    n, m, k = intary
    housoumap = []
    n.times do |i|
        housoumap << intary
    end
    cost = []
    m.times do |i|
        cost << intary
    end
    people = []
    k.times do
        people << intary
    end
    jigen = [0,0,0,0]
    people.each do |i|
        if i[0] <= 0 && i[1] <= 0
            jigen[1] += 1
        elsif i[0] <= 0 && i[1] > 0
            jigen[2] += 1
        elsif i[0] > 0 && i[1] <= 0
            jigen[0] += 1
        elsif i[0] > 0 && i[1] > 0
            jigen[3] += 1
        end
    end
    p = []
    b = []
    housoumap.each do |i|
        if i[0] <= 0 && i[1] <= 0
            (jigen[1].to_f / jigen.sum.to_f * 100).to_i >= rand(100) ? p << rand(5000) : p << 0
        elsif i[0] <= 0 && i[1] > 0
            (jigen[2].to_f / jigen.sum.to_f * 100).to_i >= rand(100) ? p << rand(5000) : p << 0
        elsif i[0] > 0 && i[1] <= 0
            (jigen[0].to_f / jigen.sum.to_f * 100).to_i >= rand(100) ? p << rand(5000) : p << 0
        elsif i[0] > 0 && i[1] > 0
            (jigen[3].to_f / jigen.sum.to_f * 100).to_i >= rand(100) ? p << rand(5000) : p << 0
        end
    end
    m.times do |i|
        b << rand(0..1) 
    end
    puts p.join(" ")
    puts b.join(" ")
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
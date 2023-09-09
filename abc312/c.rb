def main
    n, m = intary
    a = intary.sort
    b = intary.sort
    ans = 0
    as = 0
    bs = b.size
    konzai = (a + b).sort
    count = 0
    kaite = 0
    konzai.each do |i|
        b.each do |bv|
            if bv > i
                break
            end
            bnow = b.shift
            bs -= 1
            ans = bnow + 1
        end
        a.each do |av|
            if av > i
                break
            end
            a.shift
            as += 1
            ans = i
        end
        if as >= bs
            puts ans
            return
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
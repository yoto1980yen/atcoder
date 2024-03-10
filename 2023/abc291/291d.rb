def main
    n = int
    ab = []
    defmax = 2 ** n
    max = 2 ** n
    heru = 1/8
    motto = 1/4
    a = 1
    b = 1
    aa = false
    bb = false
    n.times do |i|
        # pp i + 1
        ab << intary
        next if i == 0
        mae = ab.shift
        now = ab.first
        # a aの比較
        if mae[0] != now[1] && mae[0] == now[0] 
            a = 4 if aa == false
            if aa
                a = a * 2
            end
            aa = true
        elsif mae[0] == now[1] && mae[0] != now[0] 
            a = 4 if aa == false
            if aa
                a = a * 2
            end
            aa = true
        else
            a = nil
            aa = false
        end
        # bの比較
        if mae[1] != now[0] && mae[1] == now[1] 
            b = 4 if bb == false
            if bb
                b = b * 2
            end
            bb = true
        elsif mae[1] == now[0] && mae[1] != now[1] 
            b = 4 if bb == false
            if bb
                b = b * 2
            end
            bb = true
        else
            b = nil
            bb = false
        end
        max -= defmax / a if a.nil? == false
        max -= defmax / b if b.nil? == false 
        # pp "#{a} #{b} #{max}"
    end
    puts max % 998244353
end
require 'set'
#----------------------------------------------------------------------------------
def int
    gets.to_i
end

def intary
    gets.split().map(&:to_i)
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
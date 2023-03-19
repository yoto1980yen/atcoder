def main
    n = int
    s = strary
    x = 0
    y = 0
    
    xy = Set.new(["00"])
    now = xy.size
    s.each.with_index do |v, i|
        # pp "#{x} #{y}"
        if v == "R"
            x += 1
        elsif v == "L"
            x -= 1
        elsif v == "U"
            y += 1
        elsif v == "D"
            y -= 1
        end
        xy.add(x.to_s + y.to_s)
        xy
        if now == xy.size
            puts "Yes"
            return
        end
        now = xy.size
    end
    puts "No"
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
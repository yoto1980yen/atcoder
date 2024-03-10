def main
    n ,m, h, k = intary
    s = strary
    item = Set.new()  
    m.times do |i|
        item.add(intary.to_s)
    end
    zahyou = [0, 0]
    s.each do |i|
        if i == "R"
            zahyou[0] += 1
        elsif i == "L"
            zahyou[0] -= 1
        elsif i == "U"
            zahyou[1] += 1
        elsif i == "D"
            zahyou[1] -= 1
        end
        h -= 1
        if h < 0
            puts "No"
            return
        end
        if h < k
            if item.include?(zahyou.to_s)
                h = k
                item.delete(zahyou.to_s)
            end
        end
        
    end
    puts "Yes"

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
def main
    s = strary
    tt = s.tally
    ans = true
    ans = false if tt["K"] != 1
    ans = false if tt["Q"] != 1
    ans = false if tt["R"] != 2
    ans = false if tt["B"] != 2
    ans = false if tt["N"] != 2
    guuki = nil
    
    count = 0
    s.each.with_index do |v, i|
        if v == "B"
            if guuki == nil
                guuki = i.even?
            else
                ans = false if i.even? == guuki
            end
            
        end
        count += 1 if v == "R"
        if v == "K"
            ans = false if count != 1
        end
    end
    if ans
        puts "Yes"
    else
        puts "No"
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
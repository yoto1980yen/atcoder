def main
    s = strary.tally
    t = strary.tally
    atcoder = "atcoder"
    all_key = s.merge(t).keys
    s["@"] = 0 unless s.key?("@")
    t["@"] = 0 unless t.key?("@")
    all_key.delete("@")
    all_key.each do |i|
        s[i] = 0 unless s.key?(i)
        t[i] = 0 unless t.key?(i)
        diff = s[i] - t[i]
        next if diff == 0
        unless atcoder.include?(i)
            puts "No"
            return
        end
        if diff >= 1
            if diff > t["@"]
                puts "No"
                return
            end
            t["@"] - diff
        else
            diff = diff * -1
            if diff > s["@"]
                puts "No"
                return
            end
            s["@"] - diff
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
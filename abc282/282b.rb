def main
    n, m = intary
    s = []
    n.times do |i|
        s << strary
    end
    ans = 0
    n.times do |i|
        (n).times do |j|
            count = 0
            next if j <= i
            m.times do |k|
                if s[i][k] == "o" || s[j][k] == "o"
                    count += 1
                end
            end
            if count == m
                ans += 1 
            end
        end
        
    end
    pp ans
end

#----------------------------------------------------------------------------------
def int
    gets.to_i
end
def intary
    gets.split.map(&:to_i)
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
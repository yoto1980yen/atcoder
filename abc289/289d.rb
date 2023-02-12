def main
    n = int
    a = intary
    mono = []
    a.each do |i|
        mono << [i, true]
    end
    m = int
    b = Set.new(intary)
    x = int 
    judge = false
    dp = []
    dp << []
    dp[0] = Array.new(x+1, false)
    dp[0][0] = true
    (1..x).each do |i|
        dp << []
        dp[i] = dp[i - 1].dup
        (0...x).each do |j|
            if dp[i - 1][j]
                if j > x
                    judge = true
                    break
                end
                (1..n).each do |k|
                    sinamono = mono[k - 1]
                    dp[i][j + sinamono[0]] = true unless b.include?(j + sinamono[0])
                end
                # if dp[i][j + sinamono[0]] <= sinamono[1] + dp[i - 1][j]
                #     dp[i][j + sinamono[0]] = sinamono[1] + dp[i - 1][j]
                # end
            end
        end
        break if judge
    end
    if dp.last[x]
        puts "Yes"
    else
        puts "No"
    end
end
require 'set'
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
def main
    n, x = intary
    mono = []
    nn = 0
    n.times do
        a,b = intary
        nn += b
        b.times do
            mono << [a, true]
        end
    end
    dp = []
    dp << []
    dp[0] = Array.new(x+1, false)
    dp[0][0] = true
    (1..nn).each do |i|
        dp << []
        sinamono = mono[i - 1]
        dp[i] = dp[i - 1].dup
        (0...x).each do |j|
            if dp[i - 1][j]
                next if j + sinamono[0] > x
                dp[i][j + sinamono[0]] = true
                # if dp[i][j + sinamono[0]] <= sinamono[1] + dp[i - 1][j]
                #     dp[i][j + sinamono[0]] = sinamono[1] + dp[i - 1][j]
                # end
            end
        end
    end
    # pp dp.last
    if dp.last.last
        puts "Yes"
    else
        puts "No"
    end
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
def main
    h, m = intary
    hun1 = (m / 1) % 10
    hun2 = (m / 10) % 10
    jikan1 = (h / 1) % 10
    jikan2 = (h / 10) % 10
    while true
        break if jikan2 * 10 + hun2 <= 23 && jikan1 * 10 + hun1 <= 59
        # pp "#{jikan2 * 10 + hun1} #{jikan1 + hun2 * 10}"
        hun1 += 1
        if hun1 == 10
            hun1 = 0
            hun2 += 1 
        end
        if hun2 == 6
            hun2 = 0
            jikan1 += 1 
        end
        if jikan1 == 10
            jikan1 = 0
            jikan2 += 1
        end
        if jikan1 == 4 && jikan2 == 2
            hun1 = 0
            hun2 = 0
            jikan1 = 0
            jikan2 = 0 
        end
    end
    jikan = jikan2 * 10 + jikan1
    jikan = 0 if jikan == 24
    puts "#{jikan} #{hun1 + hun2 * 10}"
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
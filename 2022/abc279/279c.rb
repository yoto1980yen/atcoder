def main
    h, w = intary
    s = []
    t = []
    h.times do
        s << strary
    end
    h.times do
        t << strary
    end
    s = s.transpose.sort
    t = t.transpose.sort
    w.times do
        next if s.shift == t.shift
        puts "No"
        return
    end
    puts "Yes"
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
def main
    a, b = intary
    max = 1000000000000000000
    min = 1
    mae = 0
    minans = a - (a / Math.sqrt(min))
    maxans = a - (a / Math.sqrt(max))
    while true
        center = (max + min) / 2
        break if center == 0
        now = (a / Math.sqrt(center - 1)) - (a / Math.sqrt(center))
        if now > b
            min = center + 1
        else
            max = center - 1
        end
        break if mae == center
        mae = center
        # pp center
    end
    puts b * (center - 1) + a / Math.sqrt(center)
    # g = 3
    # now = 0
    # i = 2
    # pp ans = 1 * 0 + a / Math.sqrt(1)
    # pp nextans = 1 * b + a / Math.sqrt(2)
    # while ans > nextans
    #     now = b * i
    #     pp ans = nextans
    #     pp nextans = 1 * now + a / Math.sqrt(g)
    #     i += 1
    #     g += 1
    # end
    # pp [nextans,ans].min
    # g = 0
    # 10.times do |i|
    #     pp g += 1
    #     pp a / Math.sqrt(g)
    # end
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
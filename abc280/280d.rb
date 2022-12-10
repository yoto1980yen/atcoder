def main
    k = int
    cnt = 1
    s = [cnt]
    ans = []
    while true
        cnt += 1
        s << s.last * cnt
        # if k % s.last == 0
        #     break
        # end
        if s.last == 123456789011
            break
        end
        ans << s.last % k
        if cnt == 20
            break
        end
    end
    pp s
    pp ans
    soinsuu = Prime.prime_division(k)
    pp soinsuu.last.last * soinsuu.last.first

end
require 'prime'
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
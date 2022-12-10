def main
    n, k, d = intary
    a = intary.sort.reverse
    ans = 0
    anss = []
    horyu = []
    aa = []
    a.map do |i|
        aa << [i, i % d]
    end
    aa.each do |i|
        omosa = i[1]
        if omosa == 0
            anss << [i[0], 1]
            next
        end
        if horyu.size != 0
            horyu.each do |j|
                if j[1] == d - omosa
                    anss << [j[0] + i[0], j[2] + 1]
                    horyu.shift
                end
                
            end
        else
            horyu << [i[0], omosa, 1]
        end
        
        
    end
    anss.each do |i|
        break if k == 0
        if k >= i[1]
            ans += i[0]
            k -= i[1]
        end
    end
    if ans == 0
        puts "-1"
    else
        puts ans
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
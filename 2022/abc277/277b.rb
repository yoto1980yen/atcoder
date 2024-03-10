def main
    ans = "No"
    n = int
    list = []
    answ = []
    n.times do |i|
        list << strary
        answ << ["H" , "D" , "C" , "S" ].any? {|j| list[i].first.include?(j)}
        answ << ["A" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "T" , "J" , "Q" , "K"].any? {|j| list[i].last.include?(j)}
    end
    lists = list.uniq.size
    if lists == list.size
        unless answ.include?(false)
            ans = "Yes"
        end
    end
    puts ans
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
# 奇数判定(奇数ならtrue 偶数ならfalse)
def kisu(i)
    if i & 1 == 1
        return true
    end
    return false
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
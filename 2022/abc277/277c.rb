def main
    n = int
    $list = {}
    $check = {}
    n.times do |i|
        now = intary
        # pp now
        if $list[now[0]]
            $list[now[0]] << now[1]
        else
            $list[now[0]] = []
            $list[now[0]] << now[1]
            $check[now[0]] = false
        end
        if $list[now[1]]
            $list[now[1]] << now[0] 
        else
            $list[now[1]] = []
            $list[now[1]] << now[0]
            $check[now[1]] = false
        end
    end
    $check[1] = true
    $ans = 1

    # pp $list
    unless $list[1]
        puts $ans
        return
    end
    hukasa($list[1])
    pp $ans
end
def hukasa(i)
    # pp "waji#{i}"
    i.each do |j|
        next if $check[j] == true
        # pp j
        $check[j] = true
        $ans = [j, $ans].max
        hukasa($list[j])
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
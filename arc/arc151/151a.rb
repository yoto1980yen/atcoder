def main
    n = int
    s = intary
    ss = s.dup.reverse
    ss.shift
    t = intary
    tt = t.dup.reverse
    tt.shift
    sc = 0
    tc = 0
    ans = Array.new(n,0)
    n.times do |i|
        sc += 1 if s.shift == 1
        tc += 1 if t.shift == 1
    end
    if sc >= tc
        sa = sc - tc
        if sa.even? == false
            puts -1
            return
        end
        if sa == 0
            puts ans.reverse.join("")
            return
        end
        n.times do |i|
            if ss.shift == 1 && tt.shift == 0
                ans[i] = 1
                sa -= 2
                break if sa == 0
            end
        end
    else
        sa = tc - sc
        if sa.even? == false
            puts -1
            return
        end
        if sa == 0
            puts ans.reverse.join("")
            return
        end
        n.times do |i|
            if tt.shift == 1 && ss.shift == 0
                ans[i] = 1
                sa -= 2
                break if sa == 0
            end
        end
    end
    if sa >= 1
        puts -1
    else
        puts ans.reverse.join("")
    end
end

#----------------------------------------------------------------------------------
def int
    gets.to_i
end

def intary
    gets.split("").map(&:to_i)
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
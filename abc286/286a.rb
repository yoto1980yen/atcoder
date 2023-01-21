def main
    n, p, q, r, s = intary
    a = intary 
    ans = a.dup
    before = a.slice((p - 1), q - p + 1)
    after = a.slice((r - 1), s - r + 1)
    n.times do |i|
        if i >= p - 1 && i <= q - 1
            ans[i] = after[i - (p - 1)]
        end
        if i >= r - 1 && i <= s - 1
            ans[i] = before[i - (r - 1)]
        end
    end
    puts ans.join(" ")
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
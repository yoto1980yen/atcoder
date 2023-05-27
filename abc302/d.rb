def main
    n, m, d = intary
    a = intary.uniq.sort
    b = intary.uniq.sort
    n = a.size
    m = b.size
    acount = 0
    ans = -1
    bcount = 0
    (n + m).times do
        if (a[acount] - b[bcount]).abs <= d && a[acount] + b[bcount] >= ans
            ans = a[acount] + b[bcount]
        end
        if a[acount] >= b[bcount]
            bcount += 1
            if bcount >= m
                bcount = m - 1
                acount += 1
                acount = n - 1 if acount >= n
            end
        else
            acount += 1
            if acount >= n
                acount = n - 1
                bcount += 1
                bcount = m - 1 if bcount >= m
            end
        end
        if (a[acount] - b[bcount]).abs <= d && a[acount] + b[bcount] >= ans
            ans = a[acount] + b[bcount]
        end
        break if bcount >= m - 1 && acount >= n - 1
    end
    if (a[n - 1] - b[m - 1]).abs <= d && a[n - 1] + b[m - 1] >= ans
        ans = a[n - 1] + b[m - 1]
    end
    puts ans
end

#----------------------------------------------------------------------------------
require "set"
require "prime"
def int
    gets.to_i
end

def intary
    gets.split(" ").map(&:to_i)
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
    
    result.uniq.sort
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
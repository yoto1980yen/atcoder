def main
    n = int
    max = 1
    1000.times do |i|
        next if i == 0
        if i ** 5 >= n
            max = i
            break
        end
    end
    a = 2
    atakasa = 1
    btakasa = 1
    ans = 0
    bsosuu = []
    csosuu = []
    while true
        b = a + 1
        b.times do |i|
            next if  b - i <= 1
            bsosuu <<  b - i if prime?( b - i)
        end
        bcount = bsosuu.count
        c = Math.sqrt(n / (a * a * b)).to_i
        break if c < b
        while true
            c = Math.sqrt(n / (a * a * b)).to_i
            csosuucount = pi(c)
            break if csosuucount <= bcount
            ans += csosuucount - bcount
            while true
                b += 1
                if prime?(b)
                    bcount += 1
                    break
                end
            end
            
        end
        while true
            a += 1
            break if prime?(a)
        end
    end
    pp ans
end

#----------------------------------------------------------------------------------
require "set"
require "prime"
def pi(n)
    m = Math.sqrt(n).to_i
    keys = (1..m).map{|i| n / i}
    keys += (1..keys[-1] - 1).to_a.reverse
    h = {}
    # 1を除いた個数
    keys.each{|i| h[i] = i - 1}
    # 「素数」もしくは「i以下の素数では割り切れない合成数」の個数
    (2..m).each{|i|
        if h[i] > h[i - 1] # このときiは素数
        hp = h[i - 1]
        i2 = i * i
        keys.each{|j|
            break if j < i2
            h[j] -= h[j / i] - hp # iで初めて割り切れる合成数(ちなみにi2以上）を除く
        }
    end
    }
    h[n]
end
def int
    gets.to_i
end

def intary
    gets.split().map(&:to_i)
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
def divisors2(n)
    n.prime_division.inject([1]) do |ary, (p, e)|
      (0..e).map{ |e1| p ** e1 }.product(ary).map{ |a, b| a * b }
    end.sort
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

def prime?(n)
    return false if n < 2
    return true  if n == 2 or n == 3
    return false if (n % 2).zero? or (n % 3).zero?
    i, step = 5, 2
    guard = Math.sqrt(n).to_i
    while i <= guard
        return false if (n % i).zero?
        i += step
        step = 6 - step
    end
    true
end

main
def main
    a, b = intary
    ans = 0
    while a != b
        if a == 1 || b == 1
            # pp "#{a} #{b} #{ans}"
            if a > b
                ans += a - 1
                a = 1
            else
                ans += b - 1
                b = 1
            end
            # pp "#{a} #{b} #{ans}"
            break
        elsif a > b
            ans += a / b
            a = a % b
            if a == 0
                ans -= 1
                break
            end
        else
            ans += b / a
            b = b % a
            if b == 0
                ans -= 1
                break
            end
        end
        # pp "#{a} #{b}"
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

main
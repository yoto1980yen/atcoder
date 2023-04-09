def main
    s = intary
    ans = 0
    ss = s.dup
    counts = ss.uniq.map{|item| [item, ss.count(item)]}.to_h

    (s.count - 1).times do |i|
        unless i == 0
            heru = ss.pop
            counts[heru] -= 1
            check = counts.dup
            now = ss.dup
            (now.count - 1).times do |k|
                judge = true
                check.each do |j|
                    judge = false unless j[1].even?
                end
                if judge
                    ans += 1
                end
                
                check[now.shift] -= 1
            end
        else
            check = counts.dup
            now = ss.dup
            (now.count - 1).times do |k|
                judge = true
                check.each do |j|
                    judge = false unless j[1].even?
                end
                if judge
                    ans += 1
                end
                
                check[now.shift] -= 1
            end
        end
    end
    pp ans
end
#----------------------------------------------------------------------------------
require "set"
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
def main
    n, k = intary
    a = intary.sort
    map = {0 => true}
    newmap = map.dup
    a.each do |i|
        k.times do |j|
            map[(j + 1) * i] = true
        end
    end
    newmap = map.dup
    a.each do |i|
        count = 0
        map.each do |j, v|
            newmap[j + i] = true
            count += 1
            break if count == k
        end
        map = newmap.dup
    end
    map.sort.each.with_index do |v, i|
        next if i != k
        if i == k
            puts v[0]
            break
        end
    end

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
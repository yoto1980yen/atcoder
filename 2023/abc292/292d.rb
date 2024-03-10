def main
    n, m = intary
    $path = {}
    $judge = {}
    m.times do |i|
        u, v = intary
        $path[u]? $path[u] << [v, 0] : $path[u] = [v]
        $path[v]? $path[v] << [u, 0] : $path[v] = [u]
        $judge[u] = false
        $judge[v] = false
    end
    $ss = 0
    $ans = false
    $judge[$path.keys.first] = true
    saiki($path[$path.keys.first])
    count = 0
    if $ans
        puts "No"
        return
    end
    $judge.each do |i|
        if i[1]
            count += 1
        end
    end
    if count == n && $ss == 2
        puts "Yes"
    else
        puts "No"
    end

end
def saiki(i)
    if i == nil
        $ans = true
        return
    end
    if i.count == 1
        $ss += 1
    end
    if i.count >= 3
        $ans = true
        return
    end
    i.each do |j|
        next if $judge[j]
        if $judge[j] == false
            $judge[j] = true
            saiki($path[j])
        end
    end
end
require 'set'
#----------------------------------------------------------------------------------
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
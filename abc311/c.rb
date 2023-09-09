def main
    $n = int
    $ki = []
    $a = intary
    $visited = Array.new($n + 1, false)
    ($n+1).times do |i|
        $ki << 0
        next if i == 0
        $ki[i] = $a[i - 1]
    end
    $miti = []
    $judge = false
    ($n+1).times do |i|
        next if i == 0
        $judge = false
        $miti.clear
        $visited[i] = true
        $miti << i
        saiki(i)
        if $judge
            index = $miti.index($ki[$miti.last])
            puts $miti.size - index
            puts $miti.slice($miti.index($ki[$miti.last])..-1).join(" ")
            return
        end
    end
end
def saiki(i)
    if $visited[$ki[i]]
        if $miti.include?($ki[i])
            $judge = true
        end
        return
    end
    $visited[$ki[i]] = true
    $miti << $ki[i]
    saiki($ki[i])
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

def grouping(ary)
    ary.slice_when { |a, b| a != b }.to_a
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
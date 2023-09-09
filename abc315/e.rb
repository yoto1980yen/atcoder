def main
    $n = int
    $map = Array.new($n + 1, 0)
    $visited = Array.new($n+ 1, false)
    $n.times do |i|
        c = intary
        next if c.first == 0
        c.shift
        $map[i + 1] = c
    end
    $saisyo = []
    $saigo = []
    $aa = Set.new([])
    saiki(1)
    ans = $saisyo.uniq + $saigo.uniq
    puts ans.uniq.join(" ")
    
end

#----------------------------------------------------------------------------------
require "set"

def saiki(i)
    miru = $map[i]
    if miru == 0
        $saisyo.unshift(i)
        return
    end
    miru.each do |j|
        
        if $map[j] == 0
            $saisyo.unshift(j)
            $visited[j] = true
        end
        $saigo.unshift(j) if $aa.include?(j)
        next if $visited[j]
        $visited[j] = true
        $saigo.unshift(j)
        $aa.add(j)
        saiki(j)
    end
end
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
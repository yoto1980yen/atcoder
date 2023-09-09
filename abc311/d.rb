def main
    $n, $m = intary
    $map = []
    $n.times do |i|
        $map << strary
    end
    $visited = Set.new([])
    $kyori = 0
    $ans = 0
    saiki(1, 1, 0)
end

def saiki(h, w, idoukai)
    if $visited.include?()
    end
    if $map[h][w + 1] == "."
        idou = 0
        m.times do |i|
            if $map[h][w + (i + 1)] == "#"
                $visited.add([h, w + (i + 1)])
                saiki(h, w + i, idoukai + 1, "l")
                break
            elsif $map[h][w + (i + 1)] != "."
                $kyori -= 1
            $map[h][w + (i + 1)] = idoukai
            $kyori += 1
        end
    end
    $ans = [$ans, $kyori].max
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
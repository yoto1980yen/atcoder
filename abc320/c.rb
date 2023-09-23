def main
    m = int
    s1 = intary
    s2 = intary
    s3 = intary
    s1.pop
    s2.pop
    s3.pop
    ans = 10000
    10.times do |i|
        $nows1 = []
        
        s1.each.with_index do |v, j|
            if v == i
                $nows1 << j
            end
        end
        next if $nows1.size == 0
        while $nows1.uniq.size <= 9
            tmp = []
            $nows1.each do |j|
                tmp << j + m
            end
            tmp.each {|j| $nows1 << j}
        end
        $nows1 = $nows1.uniq
        $nows2 = []
        s2.each.with_index do |v, j|
            if v == i
                $nows2 << j
            end
        end
        next if $nows2.size == 0
        while $nows2.uniq.size <= 9
            tmp = []
            $nows2.each do |j|
                tmp << j + m
            end
            tmp.each {|j| $nows2 << j}
        end
        $nows2 = $nows2.uniq
        $nows3 = []
        s3.each.with_index do |v, j|
            if v == i
                $nows3 << j
            end
        end
        next if $nows3.size == 0
        while $nows3.uniq.size <= 9
            tmp = []
            $nows3.each do |j|
                tmp << j + m
            end
            tmp.each {|j| $nows3 << j}
        end
        $nows3 = $nows3.uniq
        (0..2).to_a.permutation(3).to_a.each do |j|
            nows11 = $nows1.dup
            nows22 = $nows2.dup
            nows33 = $nows3.dup
            use = Set.new([])
            $nowans = 0
            j.each do |k|
                if k == 0
                    while true
                        if $nowans >= nows11.first
                            unless $nowans == 0
                                nows11.shift
                                next
                            end
                        end
                        if use.include?(nows11.first)
                            nows11.shift
                            next
                        end
                        break
                    end
                    $nowans = nows11.first
                    use.add(nows11.first)
                end
                if k == 1
                    while true
                        if $nowans >= nows22.first
                            unless $nowans == 0
                                nows22.shift
                                next
                            end
                        end
                        if use.include?(nows22.first)
                            nows22.shift
                            next
                        end
                        break
                    end
                    $nowans = nows22.first
                    use.add(nows22.first)
                end
                if k == 2
                    while true
                        if $nowans >= nows33.first
                            unless $nowans == 0
                                nows33.shift
                                next
                            end
                        end
                        if use.include?(nows33.first)
                            nows33.shift
                            next
                        end
                        break
                    end
                    $nowans = nows33.first
                    use.add(nows33.first)
                end
            end
            ans = [$nowans, ans].min
        end
    end
    ans = -1 if ans == 10000
    puts ans
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

def grouping(ary)
    ary.slice_when { |a, b| a != b }.to_a
end

def number?(str)
nil != (str =~ /\A[0-9]+\z/)
end

def make_tree(n, path, way = false)
    if n != 0
        tree = {}
        path.times do |i|
            u,v = intary
            tree[u] ? tree[u] << v : tree[u] = v
            if way
                tree[v] ? tree[v] << u : tree[v] = u
            end
        end
    else
        tree = Array.new(n+1) {Array.new}
        path.times do |i|
            u,v = intary
            tree[u] << v
            if way
                tree[v] << u
            end
        end
    end
    return tree
end

def make_visited(n)
    Array.new(n+1, false)
end

def make_map(n, type)
    map = []
    if type == "s"
        n.times do |i|
            map << strary
        end
    elsif type == "i"
        n.times do |i|
            map << intary
        end
    end
    return map
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
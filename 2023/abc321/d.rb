def main
    n, m, p = intary
    a = grouping(intary.sort)
    b = intary.sort.reverse
    bb = b.dup
    ans = 0
    pcount = 0
    bsize = b.size
    bmax = b.sum
    a.each do |anum|
        b = bb.dup
        b.each do |bnum|
            #pp "#{anum[0] + bnum} #{p}"
            if anum[0] + bnum >= p
                bmax -= bb.shift
                bsize -= 1
                pcount += 1
                next
            end
            break
        end
        #pp "#{bmax} #{bsize} #{pcount}"
        ans += (bmax + anum[0] * bsize) * anum[1] + p * pcount * anum[1]
    end
    puts ans

end

#----------------------------------------------------------------------------------
require "set"
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
    aa = ary.slice_when { |a, b| a != b }.to_a
    a = []
    aa.each do |i|
        a << [i.first, i.size]
    end
    return a
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
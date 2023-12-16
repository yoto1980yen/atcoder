def main
    h, w = intary
    a = make_map(h, "i")
    b = make_map(h, "i")
    aa = []
    bb = []
    ans = 0
    
    # まず横
    a.each do |i|
        check = 0
        b.each.with_index do |j, jin|
            if j.sort == i.sort
                check = jin 
                break
            end
            if jin == w - 1
                puts -1
                return
            end
        end
        i.each.with_index do |ii, iin|
            next if ii == b[check][iin]
            (b[check].index(ii)).downto(iin + 1) do |fi|
                ans += 1
                h.times do |iii|
                    b[iii][fi], b[iii][fi - 1] = b[iii][fi - 1], b[iii][fi]
                end
            end
        end
    end
    # 継立a
    a = a.transpose
    b = b.transpose
    a.each do |i|
        check = 0
        b.each.with_index do |j, jin|
            if j.sort == i.sort
                check = jin 
                break
            end
            if jin == w - 1
                puts -1
                return
            end
        end
        i.each.with_index do |ii, iin|
            next if ii == b[check][iin]
            (b[check].index(ii)).downto(iin + 1) do |fi|
                ans += 1
                w.times do |iii|
                    b[iii][fi], b[iii][fi - 1] = b[iii][fi - 1], b[iii][fi]
                end
            end
        end
    end
    if a == b
        pp ans
    else
        pp -1
    end
end

#----------------------------------------------------------------------------------
require "set"
def int
    gets.chomp.to_i
end

def intary
    gets.chomp.split(" ").map(&:to_i)
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

# 階乗
def factorial(n, bottom=1)
    n == 0 ? 1 : (bottom..n).inject(:*)
end

# nCr
def nCr(n, r)
    factorial(n) / (factorial(r) * factorial(n-r))
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
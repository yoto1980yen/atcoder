def main
    n, m = intary
    s = strary
    t = strary
    i = 0
    if s[0] != t[0]
        puts "No"
        return
    end
    if s.slice(n - m, m) != t
        puts "No"
        return
    end
    count = 0
    totyu = 0
    jogai = false
    while i < n - m
        # pp s[i]
        # pp "#{i} #{jogai}"
        if s[i] == t[0]
            jogai = false
            i -= 1
            m.times do |j|
                i += 1
                # pp s[i]
                next if s[i] == t[j]
                i -= 1
                jogai = true
            end
        elsif t.include?(s[i]) && jogai == false
            if totyu > t.index(s[i])
                puts "No"
                return
            end
            (t.index(s[i])..m).each do |k|
                next if s[i + k - t.index(s[i])] == t[k]
                i += k + 1
            end
            i += m - (t.index(s[i]) + 1) unless jogai
            totyu = m - (t.index(s[i]) + 1) unless jogai
        else 
            puts "No"
            return
        end
        i += 1
    end
    puts "Yes"
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
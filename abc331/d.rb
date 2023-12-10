def main
    n, q = intary
    h, w = n, n
    a = []
    n.times do |i|
        s = str
        1 while s.gsub!("W", "0")
        1 while s.gsub!("B", "1")
        a << s.split("").map(&:to_i)
    end
    s = Array.new(h){ Array.new(w) { 0 } }
    (0...h).each do |i|
        (0...w).each do |j|
            if i == 0
                s[i][j] = a[i][j]   
            else
                s[i][j] = s[i-1][j] + a[i][j]
            end
        end
    end

    (0...h).each do |i|
        (0...w).each do |j|
            if j == 0
                s[i][j] += 0
            else
                s[i][j] += s[i][j-1]
            end
        end
    end
    ans = 0
    q.times do |i|
        a, b, c, d = intary
        awaru = a / n
        bwaru = b / n
        cwaru = c / n
        dwaru = d / n

        pp awaru = 0 if awaru == nil
        pp bwaru = 0 if bwaru == nil
        pp cwaru = 0 if cwaru == nil
        pp dwaru = 0 if dwaru == nil
        pp awaru
        pp bwaru
        pp cwaru
        pp dwaru
        pp amod = a % n 
        pp bmod = b % n 
        pp cmod = c % n 
        pp dmod = d % n 
        # 角
        # ans += s[h2][w2] - s[h1][w2] - s[h2][w1] + s[h1][w1]
        # s[h2][w2] - s[h1][w2] - s[h2][w1] + s[h1][w1]
        break
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
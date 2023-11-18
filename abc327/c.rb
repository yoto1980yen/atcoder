def main
    h = 9
    w = 9
    map = make_map(w, "i")
    judge = true
    # 横判定
    map.each do |i|
        if i.uniq.size != 9
            judge = false
            break
        end
    end
    # 縦判定
    map.transpose.each do |i|
        if i.uniq.size != 9
            judge = false
            break
        end
    end
    # 各ブロック
    zouka = [0, 0]
    check = [[0, 0], [0, 1], [0, 2],[1, 0], [1, 1], [1, 2],[2, 0], [2, 1], [2, 2]]
    3.times do |i|
        3.times do |j|
            zouka[0] = 0 if i == 0
            zouka[0] = 3 if i == 1
            zouka[0] = 6 if i == 2
            zouka[1] = 0 if j == 0
            zouka[1] = 3 if j == 1
            zouka[1] = 6 if j == 2
            count = []
            check.each do |wy|
                count << map[wy[0] + zouka[0]][wy[1] + zouka[1]]
            end
            if count.uniq.size != 9
                judge = false
                break
            end
        end
    end
    if judge
        puts "Yes"
    else
        puts "No"
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
def main
    s = strary
    queue = []
    abc = ["A", "B", "C"]
    want = 0
    s.each do |i|
        queue << i
        if i == abc[want]
            want = (want + 1) % 3
            if want == 0
                3.times {queue.pop}
                if queue.size == 0
                    want = 0
                    next
                end
                want = abc.index(queue.last) + 1
                want = 0 if want == 2 && queue[-2] != "A"
            end
        else
            want = 0
            want = 1 if i == "A" 
        end
    end
    puts queue.join("")
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
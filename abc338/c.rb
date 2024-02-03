def main
    n = int
    q = intary
    a = intary
    b = intary
    # a
    lista = []
    n.times do |i|
        if a[i] == 0
            lista << 1000000 
            next
        end
        lista << q[i] / a[i]
    end
    # a
    listb = []
    n.times do |i|
        if b[i] == 0
            listb << 1000000 
            next
        end
        listb << q[i] / b[i]
    end
    if lista.min > listb.min
        temp = lista.dup
        lista = listb.dup
        listb = temp.dup
        temp = a.dup
        a = b.dup
        b = temp.dup
    end
    ans = listb.min
    newq = []
    q.each.with_index do |v, i|
        newq << v - listb.min * b[i]
    end
    listb.min.times do |i|
        lista = []
        n.times do |j|
            if a[j] == 0
                lista << 1000000 
                newq[j] += b[j]
                next
            end
            lista << newq[j] / a[j]
            newq[j] += b[j]
        end
        anss = listb.min - i + lista.min
        break if ans > anss
        ans = anss
    end
    pp ans
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
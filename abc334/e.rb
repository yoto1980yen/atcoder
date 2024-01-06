def main
    $h, $w = intary
    $map = make_map($h, "s")
    $visited = Array.new((($h+1)*$w), false)
    $way = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    $union = UnionFind.new $visited.size
    count = 0
    $h.times do |i|
        $w.times do |j|
            if $map[i][j] == "#" && $visited[flatten(i, j)] == false
                $visited[flatten(i, j)] = true
                saiki(i, j)
            end
            count += 1 if $map[i][j] == "."
        end
    end
    nowcount = $union.size - count - $h
    list = []
    $h.times do |i|
        $w.times do |j|
            if $map[i][j] == "."
                getparent = []
                $way.each do |y, x|
                    next unless i + y >= 0 && i + y < $h && j + x >= 0 && j + x < $w
                    if $map[i + y][j + x] == "#"
                        getparent << $union.get_parent(flatten(i + y, j + x))
                    end
                end
                list << nowcount - (getparent.uniq.size - 1)
            end
        end
    end
    puts list.sum * modinv(count, 998244353) % 998244353
end

#----------------------------------------------------------------------------------
require "set"
def modinv(a, m)
    b, u, v = m, 1, 0
    until b.zero?
        t = a / b
        a -= t * b
        a, b = b, a
        u -= t * v
        u, v = v, u
    end
    u %= m
    u += m if u < 0
    u
end
def saiki(h, w)
    $way.each do |y, x|
        next unless h + y >= 0 && h + y < $h && w + x >= 0 && w + x < $w
        if $map[h + y][w + x] == "#" && $visited[flatten(h + y, w + x)] == false
            $visited[flatten(h + y, w + x)] = true
            $union.unite(flatten(h, w), flatten(h + y, w + x))
            saiki(h + y, w + x)
        end
    end
    
end
def flatten(h, w)
    return h+($h+1)*w
end
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

class UnionFind
    def initialize(size)
      @rank = Array.new(size, 0)
      @parent = Array.new(size, &:itself)
    end
  
    def unite(id_x, id_y)
      x_parent = get_parent(id_x)
      y_parent = get_parent(id_y)
      return if x_parent == y_parent
  
      if @rank[x_parent] > @rank[y_parent]
        @parent[y_parent] = x_parent
      else
        @parent[x_parent] = y_parent
        @rank[y_parent] += 1 if @rank[x_parent] == @rank[y_parent]
      end
    end
  
    def get_parent(id_x)
      @parent[id_x] == id_x ? id_x : (@parent[id_x] = get_parent(@parent[id_x]))
    end
  
    def same_parent?(id_x, id_y)
      get_parent(id_x) == get_parent(id_y)
    end
    def size
        @parent.map { |id_x| get_parent(id_x) }.uniq.size
        # @parent.map.with_index.count(&:==) 
        # とすることも出来ます!
      end
  end
  

main
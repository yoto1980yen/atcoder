def main
    h, w = intary
    map = []
    s= []
    t = []
    h.times do |i|
        map << strary
    end
    visited = Array.new(h) { Array.new(w, false)}
    h.times do |i|
        w.times do |j|
            if map[i][j] == "S"
                s = [i, j]
                map[i][j] = 0
            elsif map[i][j] == "T"
                t = [i, j]
                map[i][j] = 0
            elsif map[i][j] == "."
                map[i][j] = 0
            elsif map[i][j] == "#"
                map[i][j] = -2
            end
        end
    end
    n = int
    queue = []
    ways = [[-1, 0], [1, 0], [0, 1],[0, -1]]
    kusuri = []
    kusuriway = Set.new()
    ikerulist = {}
    $visited = {}
    n.times do |i|
        kusuri << intary
        kusuri[i][0] = kusuri[i][0] - 1
        kusuri[i][1] = kusuri[i][1] - 1
        kusuriway.add(kusuri[i][0] * 10000 +  kusuri[i][1])
        ikerulist[kusuri[i][0] * 10000 +  kusuri[i][1]] = Set.new
        $visited[kusuri[i][0] * 10000 +  kusuri[i][1]] = false
    end
    judge = false
    kusuri.each do |i|
        judge = true if i[0] == s[0] && i[1] == s[1]
    end
    unless judge
        puts "No"
        return
    end
    kusuriway << t[0] * 10000 + t[1]
    n.times do |i|
        r, c, e = kusuri[i]
        queue = [[r, c, e]]
        visited = Array.new(h) { Array.new(w, false)}
        while queue.size != 0
            y, x, e = queue.shift
            visited[y][x] = true
            ways.each do |way|
                next if y + way[0] >= h || y + way[0] < 0
                next if x + way[1] >= w || x + way[1] < 0
                next if visited[y + way[0]][x + way[1]]
                if kusuriway.include?( (y + way[0]) * 10000 + x + way[1])
                    ikerulist[r * 10000 +c].add((y + way[0]) * 10000 +x + way[1])
                end
                if e - 1 > 0
                    queue.push([y + way[0], x + way[1], e - 1])
                end
            end
        end
    end
    $ikerulist = ikerulist
    $visited[s[0] * 10000 + s[1]] = true
    $ans = "No"
    $t = t
    saiki($ikerulist[s[0] * 10000 + s[1]])
    puts $ans
end

#----------------------------------------------------------------------------------
require "set"
def saiki(way)
    if way.include?($t[0] * 10000 + $t[1])
        $ans = "Yes"
        return
    end
    way.each do |i|
        next if $visited[i]
        $visited[i] = true
        saiki($ikerulist[i])
        $visited[i] = false
    end
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
class PriorityQueue
    def initialize
        # ヒープ構造を表す配列（インデックス0は不使用）
        @heap = [nil]
        @objs = [nil]
    end

    def push(key, obj)
        # 一旦末尾に加える
        @heap << key
        @objs << obj

        # ヒープの順序を正す（葉から根へ）
        k = @heap.size - 1
        while (k >>= 1) > 0 && update(k); end

        # メソッドを連続できるようselfを返す
        return self
    end

    def shift
        return nil if @heap.size == 1
        return @heap.pop, @objs.pop if @heap.size == 2

        # 先頭を抜き取り、末尾を一旦先頭に置く
        key0, obj0 = @heap[1], @objs[1]
        @heap[1], @objs[1] = @heap.pop, @objs.pop

        # ヒープの順序を正す（根から葉へ）
        k = 1
        while (k = update(k)); end

        return key0, obj0
    end

    def first
        return nil if @heap.size == 1
        return @heap[1], @objs[1]
    end

    def size
        return @heap.size - 1
    end

    def empty?
        return @heap.size == 1
    end

    private

    # 位置kとその子ノードの間で順序を正す
    # 入れ替えたら子のインデックスを、入れ替えなかったらnilを返す
    def update(k)
        l, r = k << 1, k << 1 | 1
        up, left, right = @heap.values_at(k, l, r)
        return nil unless left  # 子が無い

        # 左右の子ノードのうち値が小さいほうが交換候補
        if right && left > right
            return nil if up <= right
            @heap[k], @heap[r] = right, up
            @objs[k], @objs[r] = @objs[r], @objs[k]
            return r
        else
            return nil if up <= left
            @heap[k], @heap[l] = left, up
            @objs[k], @objs[l] = @objs[l], @objs[k]
            return l
        end
    end
end

main
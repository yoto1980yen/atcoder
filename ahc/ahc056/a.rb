def main
    n, k, t  = intary
    yokokabe = []
    n.times do |i|
        yokokabe << intary_nospace
    end
    tatekabe = []
    (n - 1).times do |i|
        tatekabe << intary_nospace
    end
    # 方向は上から時計回り (上 右 下 左)
    can_walk = []
    n.times do |i|
        can_walk << Array.new(n) {Array.new(4, true)}
    end
    ways = [[-1, 0, 0], [0, 1, 1], [1, 0, 2], [0, -1, 3]]
    n.times do |y|
        n.times do |x|
            # 上の場合
            if y - 1 == -1
                can_walk[y][x][0] = false 
            elsif tatekabe[y - 1][x] == 1
                can_walk[y][x][0] = false 
            end
            # 右の場合
            if x + 1 == n
                can_walk[y][x][1] = false 
            elsif yokokabe[y][x] == 1
                can_walk[y][x][1] = false
            end
            # 下の場合
            if y + 1 == n
                can_walk[y][x][2] = false 
            elsif tatekabe[y][x] == 1
                can_walk[y][x][2] = false 
            end
            # 左の場合
            if x - 1 == -1
                can_walk[y][x][3] = false 
            elsif yokokabe[y][x - 1] == 1
                can_walk[y][x][3] = false
            end
        end
    end
    # 目的地
    distinations = []
    k.times do |i|
        distinations << intary
    end
    turn_map = []
    k.times do |i|
        turn_map << []
        n.times do |y|
            turn_map[i] << Array.new(n) {Array.new(4, false)}
        end
    end
    # 現在地と目的地の間を幅優先で探す
    distinations.each_cons(2).with_index do |i, joutai|
        # pp "#{joutai}ターン目"
        visited = Array.new(n) {Array.new(n, false)}
        start = i[0]
        distination = i[1]
        # 幅優先で目的地までの最短経路を検索
        queue = [start]
        visited[start[0]][start[1]] = [[start[0], start[1]]]
        while queue.size != 0 do
            now = queue.shift
            ways.each do |way|
                next if can_walk[now[0]][now[1]][way[2]] == false
                next if visited[now[0] + way[0]][now[1] + way[1]] != false
                queue << [now[0] + way[0], now[1] + way[1]]
                visited[now[0] + way[0]][now[1] + way[1]] = []
                visited[now[0]][now[1]].each do |nn|
                    visited[now[0] + way[0]][now[1] + way[1]] << nn.dup
                end
                visited[now[0] + way[0]][now[1] + way[1]] << [now[0] + way[0], now[1] + way[1]]
            end
        end
        # 各ターンごとの色を決める
        visited[distination[0]][distination[1]].each_cons(2).with_index do |v, index|
            turn_map[joutai][v[0][0]][v[0][1]][0] = joutai # 色を追加(基本的には一ゴール一色)
            turn_map[joutai][v[0][0]][v[0][1]][1] = index # 移動数(内部状態)をいれる
            # 方向を入れる
            if v[0][0] > v[1][0] # 上に移動する場合
                turn_map[joutai][v[0][0]][v[0][1]][2] = "U" # 方向を入れる
            elsif v[0][1] < v[1][1] # 左に移動する場合
                turn_map[joutai][v[0][0]][v[0][1]][2] = "R" # 方向を入れる
            elsif v[0][0] < v[1][0] # 下に移動する場合
                turn_map[joutai][v[0][0]][v[0][1]][2] = "D" # 方向を入れる
            elsif v[0][1] > v[1][1] # 左に移動する場合
                turn_map[joutai][v[0][0]][v[0][1]][2] = "L" # 方向を入れる
            end
        end
    end
    ss = []
    n.times do |i|
        ss << Array.new(n, 0)
    end
    status = []
    n.times do |y|
        n.times do |x|
            j = []
            # pp "#{y} #{x}"
            k.times do |i|
                next if turn_map[i][y][x] == [false, false, false, false]
                # pp turn_map[i][y][x] if y == 10 && x == 12
                j << turn_map[i][y][x]
            end
            next if j == []
            ss[y][x] = j.first[0]
            # pp j
            j.each_cons(2).with_index do |i, ii|
                status << [i[0][0], i[0][1], i[1][0], i[0][1] + 1, i[0][2]]
                # pp status.last if y == 10 && x == 12
            end
            # pp j if y == 10 && x == 12
            # pp j.size if y == 10 && x == 12
            status << [j.last[0], j.last[1], 0, j.last[1] + 1, j.last[2]]
            #     status.last if y == 10 && x == 12
            # end
            # pp status.last
            # pp status.last if y == 10 && x == 12
            # pp status[-2] if y == 10 && x == 12
            
        end
    end
    
    q = Set.new()
    c = Set.new()
    status.each do |i|
        c << i[0]
        c << i[2]
        q << i[1]
        q << i[3]
    end
    # 出力
    puts "#{c.size} #{q.size} #{status.size}"
    ss.each do |i|
        puts i.join(" ")
    end
    status.sort!
    (status.size - 1).times do |i|
        status[i][3] = 0 if status[i][1] >= status[i + 1][1]
    end
    status.each do |i|
        puts i.join(" ")
    end
end

#----------------------------------------------------------------------------------
require "set"
def int
    gets.chomp.to_i
end

def intary_nospace
    gets.chomp.split("").map(&:to_i)
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

class PriorityQueue
    # By default, the priority queue returns the maximum element first.
    # If a block is given, the priority between the elements is determined with it.
    # For example, the following block is given, the priority queue returns the minimum element first.
    # `PriorityQueue.new { |x, y| x < y }`
    #
    # A heap is an array for which a[k] <= a[2*k+1] and a[k] <= a[2*k+2] for all k, counting elements from 0.
    def initialize(array = [], &comp)
        @heap = array
        @comp = comp || proc { |x, y| x > y }
        heapify
    end

    attr_reader :heap

    # Push new element to the heap.
    def push(item)
    shift_down(0, @heap.push(item).size - 1)
    end

    alias << push
    alias append push

    # Pop the element with the highest priority.
    def pop
        latest = @heap.pop
        return latest if empty?

        ret_item = heap[0]
        heap[0] = latest
        shift_up(0)
        ret_item
    end

    # Get the element with the highest priority.
    def get
        @heap[0]
    end

    alias top get

    # Returns true if the heap is empty.
    def empty?
        @heap.empty?
    end

    private

    def heapify
        (@heap.size / 2 - 1).downto(0) { |i| shift_up(i) }
    end

    def shift_up(pos)
        end_pos = @heap.size
        start_pos = pos
        new_item = @heap[pos]
        left_child_pos = 2 * pos + 1
    
        while left_child_pos < end_pos
            right_child_pos = left_child_pos + 1
            if right_child_pos < end_pos && @comp.call(@heap[right_child_pos], @heap[left_child_pos])
                left_child_pos = right_child_pos
            end
            # Move the higher priority child up.
            @heap[pos] = @heap[left_child_pos]
            pos = left_child_pos
            left_child_pos = 2 * pos + 1
        end
        @heap[pos] = new_item
        shift_down(start_pos, pos)
    end

    def shift_down(star_pos, pos)
        new_item = @heap[pos]
        while pos > star_pos
            parent_pos = (pos - 1) >> 1
            parent = @heap[parent_pos]
            break if @comp.call(parent, new_item)

            @heap[pos] = parent
            pos = parent_pos
        end
        @heap[pos] = new_item
    end
end
# エラトステネスの篩で素数列挙して高速に素因数分解したい！
# ref: https://atcoder.jp/contests/abc177/editorial/82
class PrimeDivWithSieve
    def initialize(n)
        @sieve = [] # nまでの素数を入れる
        @min_div = {} # keyの値の最小の素因数を入れる
        # 他を篩落とし得る素数はsqrtを上限にできる
        (2..Math.sqrt(n).floor).each do |i|
            next if @min_div[i] # ここに値が入ってる = ふるい落とされている
            @sieve << i # ふるい落とされずに来たらそいつは素数
    
            sieve_target = i * i
            while sieve_target <= n do
            @min_div[sieve_target] ||= i
            sieve_target += i
            end
        end
        (Math.sqrt(n).floor.next..n).each do |i|
            next if @min_div[i]
            @sieve << i
        end
    end
    # Integer#prime_division と同じ値を返すようにする
    # https://docs.ruby-lang.org/ja/latest/method/Integer/i/prime_division.html
    def prime_division(num)
        return num if !@min_div[num] # 素数のときすぐ返す
        return_num = 1 # [[a, x], [b, y]] <=> num = a^x * b^y
        while num > 1 do
            prime = @min_div[num] # 最小の素因数, nil => numが素数
            break return_num *= num if !prime
            div_total = 0
            while num % prime == 0 do
            num /= prime
            div_total += 1
            end
            return_num *= prime  if div_total % 2 != 0
        end
        return_num
    end
    def prime_list
        @sieve
    end
end
HeapQueue = PriorityQueue
main
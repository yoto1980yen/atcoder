def main
    n, m = intary
    
    posi = intary
    wantlist = []
    (m-1).times do |i|
        wantlist << intary
    end
    ans = []
    #自分の決めた場所にブロックを置く
    if posi[0] != 0
        ans << ["S", "U"]
    end
    if posi[1] != 0
        ans << ["S", "L"]
    end
    10.times do |i|
        ans << ["M", "R"]
    end
    ans << ["M", "D"]
    ans << ["A", "L"]
    11.times do |i|
        ans << ["M", "D"]
    end
    ans << ["A", "U"]
    ans << ["S", "D"]
    ans << ["M", "U"]
    ans << ["A", "L"]
    ans << ["S", "U"]
    ans << ["S", "R"]
    ans << ["M", "L"]
    ans << ["M", "U"]
    ans << ["A", "U"]
    ans << ["S", "L"]
    ans << ["S", "L"]
    ans << ["M", "U"]
    ans << ["M", "L"]
    ans << ["A", "U"]
    ans << ["M", "L"]
    ans << ["M", "L"]
    ans << ["A", "U"]
    ans << ["A", "D"]
    ans << ["S", "L"]
    ans << ["A", "R"]
    ans << ["S", "U"]
    ans.each do |i|
        puts i.join(" ")
    end
    map = Array.new(20) {Array.new(20, 0)}
    posi = [0, 0]
    [[1, 9], [10, 1], [10, 18], [18, 9], [9,8], [9, 10], [11, 8], [11, 10]].each do |i|
        map[i[0]][i[1]] = 1
    end
    [[0,0], [19, 0], [0, 19], [19, 19]].each do |i|
        map[i[0]][i[1]] = 2
    end
    blocks = [[0,0], [19, 0], [0, 19], [19, 19], [1, 9], [10, 1], [10, 18], [18, 9], [9,8], [9, 10], [11, 8], [11, 10]]
    ways = [[-1, 0, "U"], [1, 0, "D"], [0, -1, "L"], [0, 1, "R"]]
    wantlist.each do |i|
        #幅優先で近いブロックまたは角を見つける
        visited = Set.new()
        queue = [i]
        want = false
        while true
            if map[i[0]][i[1]] != 0
                want = i
                break
            end
            now = queue.shift
            ways.each do |way|
                next if now[0] + way[0] >= 20 || now[0] + way[0] < 0 || now[1] + way[1] >= 20 || now[1] + way[1] < 0 || visited.include?((now[0] + way[0]) * 10000 + (now[1] + way[1]))
                if map[now[0] + way[0]][now[1] + way[1]] != 0
                    want = [now[0] + way[0], now[1] + way[1]]
                    break
                end
                queue << [now[0] + way[0], now[1] + way[1]]
                visited << (now[0] + way[0]) * 10000 + (now[1] + way[1])
            end
            break if want != false
        end
        if want == [19, 0]
            ans << ["S", "D"]
            posi = [19,0]
        elsif want == [0, 19]
            ans << ["S", "R"]
            posi = [0,19]
        elsif want == [19, 19]
            ans << ["S", "D"]
            ans << ["S", "R"]
            posi = [19,19]
        elsif want == [1, 9]
            ans << ["M", "D"]
            ans << ["S", "R"]
            posi = [1,8]
        elsif want == [10, 1]
            ans << ["M", "R"]
            ans << ["S", "D"]
            posi = [9,1]
        elsif want == [10, 18]
            ans << ["S", "R"]
            ans << ["M", "L"]
            ans << ["S", "D"]
            posi = [9,18]
        elsif want == [18, 9]
            ans << ["S", "D"]
            ans << ["M", "U"]
            ans << ["S", "R"]
            posi = [18,8]
        elsif want == [9,8]
            ans << ["M", "R"]
            ans << ["S", "D"]
            ans << ["S", "R"]
            posi = [9, 7]
        elsif want == [9, 10]
            ans << ["S", "R"]
            ans << ["M", "L"]
            ans << ["S", "D"]
            ans << ["S", "L"]
            posi = [9,11]
        elsif want == [11, 8]
            ans << ["S", "D"]
            ans << ["M", "U"]
            ans << ["S", "R"]
            ans << ["S", "U"]
            posi = [12,8]
        elsif want == [11, 10]
            ans << ["S", "R"]
            ans << ["S", "D"]
            ans << ["M", "U"]
            ans << ["S", "L"]
            ans << ["S", "U"]
            posi = [12,10]
        end
        # 最寄りのブロックから幅優先で移動
         pp visited
        visited = map.dup
        queue = [[posi]]
        route = []
        next if posi == i
        visited[posi[0]][posi[1]] = []
        while true
            q = queue.shift
            now = q[0]
            r = q[1]
            ways.each do |way|
                next if now[0] + way[0] >= 20 || now[0] + way[0] < 0 || now[1] + way[1] >= 20 || now[1] + way[1] < 0
                if [now[0] + way[0], now[1] + way[1]] == i
                    visited[now[0] + way[0]][now[1] + way[1]] = visited[now[0]][now[1]] + [way[2]]
                    route = visited[now[0] + way[0]][now[1] + way[1]]
                    break
                end
                if visited[now[0] + way[0]][now[1] + way[1]] != 2
                    queue << [now[0] + way[0], now[1] + way[1]]
                    visited[now[0] + way[0]][now[1] + way[1]] = visited[now[0]][now[1]] + [way[2]]
                end
            end
            break if route != []
        end
        route.each do |i|
            ans << ["M", i]
        end
        gyaku = {"R" => "L", "L" => "R", "D" => "U", "U" => "D"}
        if [[1, 9], [10, 1], [10, 18], [18, 9], [9,8], [9, 10], [11, 8], [11, 10]].include?(i)
            ans.insert(-2, ["A", route.last])
            ans << ["M", gyaku[route.last]]
            ans << ["A", route.last]
        end
        ans << ["S", "L"]
        ans << ["S", "U"]
        ans << ["S", "L"]
        ans << ["S", "U"]
        posi = [0,0]
    end
    ans.each do |i|
        i.join(" ")
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
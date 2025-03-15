def main
    n, m, $k, t = intary
    $town = []
    n.times do |i|
        $town << Array.new(n, ".")
    end
    human_map = []
    n.times do |i|
        human_map << Array.new(n, 0)
    end
    ans = []
    human = []
    $home = {}
    $syokuba = {}
    m.times do |i|
        human << intary
        human_map[human.last[0]][human.last[1]] += 1
        human_map[human.last[2]][human.last[3]] += 1
        $home[human.last[0] * 100 + human.last[1]] ? $home[human.last[0] * 100 + human.last[1]] << [human.last[2],human.last[3]] : $home[human.last[0] * 100 + human.last[1]] = [[human.last[2],human.last[3]]]
        $syokuba[human.last[2] * 100 + human.last[3]] ? $syokuba[human.last[2] * 100 + human.last[3]] << [human.last[0],human.last[1]] : $syokuba[human.last[2] * 100 + human.last[3]] = [[human.last[0],human.last[1]]]

    end
    # 1回目に駅を置く場所を決める
    max = [0, 0, 0]
    $k -= 5000
    n.times do |y|
        n.times do |x|
            now = 0
            # このxy座標を中心に職場と家がある数を多い順に探す
            (-2..2).each do |yy|
                (-2..2).each do |xx|
                    next if xx + x >= n || xx + x < 0 || yy + y >= n || yy + y < 0 || (yy.abs + xx.abs).abs >= 3
                    now += human_map[yy + y][xx + x]
                 end
            end
            if max.last <= now
                atesaki = want_go(y, x)
                if atesaki.size >= 1
                    max = [y, x, now]
                end
            end
        end
    end
    ans << [0,max[0],max[1]]
    $stations = [[max[0],max[1]]]
    $town[max[0]][max[1]] = "%"
    # この駅の場所からいける場所を探す
    atesaki = want_go(max[0], max[1])
    # もっとも価値のある場所に駅を立てる
    want = want_station(max[0], max[1], atesaki)
    ans << [0,want[0],want[1]]
    
    $k -= 5000
    # 既存の駅とつなげたい駅を結ぶ
    u = unite(want[0], want[1])
    $k -= u.size * 100
    $stations << [want[0], want[1]]
    # 駅周辺はもう用済み
    $stations.each do |y, x|
        (-2..2).each do |yy|
            (-2..2).each do |xx|
                next if xx + x >= n || xx + x < 0 || yy + y >= n || yy + y < 0 || (yy.abs + xx.abs).abs >= 3
                human_map[yy + y][xx + x] = 0 if human_map[yy + y][xx + x] != nil
            end
        end
    end
    u.each do |i|
        ans << i
    end
    # この時点で800ターンまで放置した場合を算出
    nowans = [$k + want[2] * (800 - ans.size)]
    ans.each do |i|
        nowans << i
    end
    (800 - ans.size).times do |i|
        nowans << [-1]
    end
    $town[want[0]][want[1]] = "%"
    # 10000溜まったらもう一個駅立てる
    nowans.shift
    nowans.each do |i|
        puts i.join(" ")
    end

end 

#----------------------------------------------------------------------------------
require "set"
def want_station(wanty, wantx, atesaki)
    want = [0, 0, 0]
    50.times do |y|
        50.times do |x|
            now = 0
            # この駅から価値のある場所に駅を立てる
            (-2..2).each do |yy|
                (-2..2).each do |xx|
                    next if xx + x >= 50 || xx + x < 0 || yy + y >= 50 || yy + y < 0 || (yy.abs + xx.abs).abs >= 3
                    now += atesaki.count([yy + y,xx + x]) * ((xx + x - wantx).abs + (yy + y - wanty).abs)
                 end
            end
            want = [y, x, now] if want.last < now 
        end
    end
    return want
end
def unite(goaly, goalx)
    # 幅優先で既存の駅から最短距離を結ぶ
    nowtown = []
    $town.each do |i|
        nowtown << i.dup
    end
    rails = []
    ways = [[-1,0, "D"], [1,0, "U"],[0,-1, "R"],[0,1, "L"]]
    queue = []
    $stations.each do |i|
        queue << [i[0],i[1],[]]
    end
    while queue.size != 0
        y, x, list = queue.shift
        ways.each do |way|
            next if y + way[0] >= 50 || y + way[0] < 0 || x + way[1] >= 50 || x + way[1] < 0 || nowtown[y + way[0]][x + way[1]] != "."
            queue << [y + way[0], x + way[1], list.dup.unshift(way[2])]
            nowtown[y + way[0]][x + way[1]] = list.dup.unshift(way[2])
        end
    end
    nowtown[goaly][goalx].each_cons(2) do |a,b|
        goaly -= 1 if a == "U"
        goaly += 1 if a == "D"
        goalx += 1 if a == "R"
        goalx -= 1 if a == "L"
        rails << [2, goaly, goalx] if (a == "U" && b == "U") || (a == "D" && b == "D")
        rails << [1, goaly, goalx] if (a == "R" && b == "R") || (a == "L" && b == "L")
        rails << [4, goaly, goalx] if (a == "D" && b == "L") || (a == "R" && b == "U")
        rails << [5, goaly, goalx] if (a == "D" && b == "R") || (a == "L" && b == "U")
        rails << [3, goaly, goalx] if (a == "U" && b == "L") || (a == "R" && b == "D")
        rails << [6, goaly, goalx] if (a == "U" && b == "R") || (a == "L" && b == "D")
        $town[goaly][goalx] = "#"
    end
    return rails
end
def want_go(y, x)
    atesaki = []
    (-2..2).each do |yy|
        (-2..2).each do |xx|
            next if xx + x >= 50 || xx + x < 0 || yy + y >= 50 || yy + y < 0 || (yy.abs + xx.abs).abs >= 3
            if $home[(yy + y) * 100 + xx + x] != nil
                $home[(yy + y) * 100 + xx + x].each do |h|
                    if ((xx + x).abs - h[1].abs).abs + ((yy + y).abs - h[0].abs).abs <= ($k - 5000) / 100 - 4
                        atesaki << h
                    end
                end
            end
            if $syokuba[(yy + y) * 100 + xx + x] != nil
                $syokuba[(yy + y) * 100 + xx + x].each do |s|
                    if ((xx + x).abs - s[1].abs).abs + ((yy + y).abs - s[0].abs).abs <= ($k - 5000) / 100 - 4
                        atesaki << s
                    end
                end
            end
        end
    end
    return atesaki
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
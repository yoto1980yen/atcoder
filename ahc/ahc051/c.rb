def main
    n, m, k = intary
    # 処理装置
    processor_positions = []
    n.times { processor_positions << intary }
    # 分別器
    sorter_positions = []
    m.times { sorter_positions << intary }
    # 分別器のから運び出す確率
    prob = []
    k.times { prob << intary_f }
    # 搬入口から始めて近い順に処理装置の場所を0からnにする
    inlet = [0, 5000]
    ans = []
    ans << Array.new(0, n)
    used = Set.new
    n.times do |index|
        dist_sq = processor_positions.map.with_index do |(x, y), i|
            [(x - inlet[0])**2 + (y - inlet[1])**2, i, x, y]
        end.sort
        dist_sq.each do |i|
            next if used.include?(i[1])
            ans[0][index] = i[1]
            used << i[1]
            inlet = [i[2], i[3]]
            break
        end
    end
    processor_list = []
    ans[0].each_with_index.sort.each do |_, processor|
        processor_list << processor
    end
    # 効率のよさそうな分別器をn個選ぶ
    kps = []
    (0...n).each.with_index do |processor, index|
        klist = []
        count = n
        prob.each_with_index.sort_by {|p, ii| -p[processor]}.each do |ks|
            klist << [ks[0].dup, ks[1], 0]
            count -= 1
            break if count <= 0
        end
        count = n
        count.times do |o|
            klist[o][0].delete_at(processor)
            klist[o][2] = klist[o][0].sum
        end
        kp = []
        klist.sort_by {|p| p[2]}.each do |iii|
            kp << iii[1]
        end
        kps << kp
    end
    # 分裂期の一本道を作る
    belt = []
    start = [0, 5000]
    used = Set.new
    route = [[[0,5000], -1, -1, -1]] # 座標 sonar番号 , 接続先1, 接続先2
    ans[0].each.with_index do |i, inde|
        # 3つ分の分裂期を処理装置間に置く
        inx = (processor_positions[i][0] - start[0]) / 2
        iny = (processor_positions[i][1] - start[1]) / 2
        count = 0
        2.times do |xy|
            dist_sq = sorter_positions.map.with_index do |(x, y), i|
                [(x - (start[0] + inx * (xy + 1)))**2 + (y - (start[1] + iny * (xy + 1)))**2, i, x, y]
            end.sort
            dist_sq.each do |j|
                next if used.include?(j[1])
                # ベルトをつなげる
                next if belt_cross?(belt, route.last[0], sorter_positions[j[1]]) == true
                belt << [route.last[0], sorter_positions[j[1]]]
                route[-1][3] = j[1]
                route[-1][2] = j[1]
                route << [sorter_positions[j[1]], j[1], j[1], j[1], i]
                used << j[1]
                count += 1
                break
            end
        end
        start = processor_positions[i]
        break if inde == 1
    end
    route.shift
    # 各分別器からそれぞれの処理機にルーティングできるかやる
    hazureroute = []
    route.each_slice(2).with_index do |i, inde|
        dist_sq = sorter_positions.map.with_index do |(x, y), i|
            [(x - i[1][0][0])**2 + (y - i[1][0][1])**2, i, x, y]
        end.sort
        dist_sq.each do |j|
            next if used.include?(j[1])
            # ベルトをつなげる
            next if belt_cross?(belt, i[0][0], sorter_positions[j[1]]) == true
            next if belt_cross?(belt, i[1][0], sorter_positions[j[1]]) == true
            next if belt_cross?(belt, processor_positions[ans[0][inde]], sorter_positions[j[1]]) == true
            belt << [i[0][0], sorter_positions[j[1]]]
            belt << [i[1][0], sorter_positions[j[1]]]
            belt << [processor_positions[ans[0][inde]], sorter_positions[j[1]]]
            hazureroute << [sorter_positions[j[1]], j[1], ans[0][inde], i[0][3], ans[0][inde]]
            route[inde * 2 + 0][2] = j[1]
            used << i[0]
            break
        end
        if hazureroute.size != inde + 1
            i.each.with_index do |p, pi|
                # ベルトをつなげる
                next if belt_cross?(belt, p[0], processor_positions[ans[0][inde]]) == true
                belt << [processor_positions[ans[0][inde]], i[0][0]]
                route[inde * 2 + pi][2] = ans[0][inde] - n
                break
            end
        end
        break
    end
    # pp belt
    
    # pp hazureroute
    ans << [route.first[1] + n]
    m.times do |i|
        ans << [-1]
    end
    count = 2
    list = ans[0].dup
    list.shift
    route.each.with_index do |i, ii|
        ans[2 + i[1]] = [kps[i[4]][0], ii == route.size - 1 ? i[4] : i[2] + n, ii == route.size - 1 ? i[4] : i[3] + n]
        count -= 1
        if count == 0
            list.each do |p|
                next if belt_cross?(belt, i[0], processor_positions[p]) == true
                ans[2 + i[1]] = [kps[p][0], p, p]
                break
            end
            break
        end
    end
    hazureroute.each.with_index do |i, ii|
        ans[2 + i[1]] = [kps[i[4]][0], i[2], ii == hazureroute.size - 1 ? i[2] : i[3] + n]
        break
    end
    ans.each do |i|
        puts i.join(" ")
    end
    
end

#----------------------------------------------------------------------------------
require "set"
def belt_cross?(belt, p1, p2)
    belt.each do |check|
        next if check[0] == p1 || check[1] == p1
        if segments_intersect?(check[0], check[1], p1, p2)
            return true
        end
    end
    return false
end

def sign(x)
    return 1 if x > 0
    return -1 if x < 0
    return 0
end

def orientation(a, b, c)
    cross = (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])
    sign(cross)
end

def segments_intersect?(p1, p2, q1, q2)
    return false if [p1[0], p2[0]].max < [q1[0], q2[0]].min ||
                    [q1[0], q2[0]].max < [p1[0], p2[0]].min ||
                    [p1[1], p2[1]].max < [q1[1], q2[1]].min ||
                    [q1[1], q2[1]].max < [p1[1], p2[1]].min

    o1 = orientation(p1, p2, q1)
    o2 = orientation(p1, p2, q2)
    o3 = orientation(q1, q2, p1)
    o4 = orientation(q1, q2, p2)

    (o1 * o2 <= 0) && (o3 * o4 <= 0)
end
def int
    gets.chomp.to_i
end

def intary
    gets.chomp.split(" ").map(&:to_i)
end

def intary_f
    gets.chomp.split(" ").map(&:to_f)
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
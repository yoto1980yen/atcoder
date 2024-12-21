def main
    n, t, q = intary
    # 各箱はboxesに格納
    boxes = []
    n.times do |i|
        boxes << intary
    end
    # 横幅の最大値を求める
    wmax = 0
    boxes.each do |i|
        wmax += i.max
    end
    # 横幅の最小値を求める
    wmin = 0
    boxes.each do |i|
        wmin = [i.max, wmin].max
    end
    tt = []
    (5..(t/3)).each do |i|
        tt << wmax / t * (i + 1)
        tt << wmax / t * (i + 1)
        tt << wmax / t * (i + 1)
    end
    # tt = [(wmax + wmin) / 3]
    # しっぱいするけーす 41
    #　T回試行錯誤する
    tt.each.with_index do |center, ttime|
        width = 0
        width_list = []
        ans = []
        high = 0
        trash = 0
        put = []
        boxes.each.with_index do |box, index|
            # pp width_list[14] if index == 38
            # pp box if index == 38
            # widthが埋まっていないなら上に敷き詰める
            if center - width >= box.max
                width_list << [box.max - q, box.min, index]
                high = [high,box.min].max
                ans << [index, box.max == box[0] ? 0 : 1, "L", -1]
                width += box.max
            else
                # 評価点の初期化 [点数, 箱番号, 90度回転するか否か]
                hyouka = [10000000000000000, -1, 0]
                width_list.each.with_index do |widthh, ii|
                    w, h, num = widthh
                    # 評価が低いやつに入れる
                    # 評価基準は 高さのはみ出る部分 * 2 + 横の余ったスペース分
                    # そのままの場合
                    if w >= box[0] + q + q
                        if ttime % 2 == 0 
                            high <= h + box[1] ? now = (w - box[0]) + ((h + box[1]) - high) * 2 : now = (w - box[0]) - (high - (h + box[1])) * 2
                        elsif ttime % 2 == 1
                            high <= h + box[1] ? now = (w - box[0]) + ((h + box[1]) - high) * 3 : now = (w - box[0]) - (high - (h + box[1])) * 2
                        else
                            high <= h + box[1] ? now = (w - box[0]) + ((h + box[1]) - high) * 4 : now = (w - box[0]) - (high - (h + box[1])) * 2
                        end
                        # より評価点の低いやつを採用
                        if hyouka.first >= now
                            hyouka = [now, index, 0]
                            put = [w, h, num, 0, ii]
                        end
                    end
                    # 90度回転する場合
                    if w >= box[1] + q + q
                        if ttime % 2 == 0 
                            high <= h + box[0] ? now = (w - box[1]) + ((h + box[0]) - high) * 2 : now = (w - box[1]) - (high - (h + box[0])) * 2
                        elsif ttime % 2 == 1
                            high <= h + box[0] ? now = (w - box[1]) + ((h + box[0]) - high) * 3 : now = (w - box[1]) - (high - (h + box[0])) * 2
                        else
                            high <= h + box[0] ? now = (w - box[1]) + ((h + box[0]) - high) * 4 : now = (w - box[1]) - (high - (h + box[0])) * 2
                        end
                        # より評価点の低いやつを採用
                        if hyouka.first >= now
                            hyouka = [now, index, 1]
                            put = [w, h, num, 1, ii]
                        end
                    end
                end
                 #　どこにも積み上げられない場合は除外する
                if hyouka[1] == -1
                    trash += box.sum
                # 決まったら配置
                else
                    ans << [index, put[3], "U", width_list[put[4] - 1][2]]
                    high = [high, put[3] == 0 ? put[1] + box[1] : put[1] + box[0]].max
                    width_list[put[4]][1] += put[3] == 0 ? put[1] + box[1] : put[1] + box[0]
                end
            end
        end
        puts ans.size
        ans.each do |a|
            puts a.join(" ")
        end
        puts "\n"
        STDOUT.flush
    end
    (t - tt.size).times do |i|
        puts 0
        puts "\n"
        STDOUT.flush
    end
end

#----------------------------------------------------------------------------------
require "set"
require "rbtree"
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
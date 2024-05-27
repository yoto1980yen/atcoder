def main
    # 計測開始
    start_time = Time.now

    n = int
    # 元のコンテナのマップ
    motomap = []
    n.times do |i|
        motomap << intary.reverse
    end

    # 雑にansに最も悪い動作を入れる
    # ans用クレーンの動作
    anskuren = Array.new(5) {Array.new}
    5.times do |i|
        anskuren[i] << "." * 20000
    end

    # 2秒間回し続ける
    count = 0
    while Time.now - start_time <= 2.7
        map = motomap.map(&:dup)
        count += 1
        # クレーンの動作
        kuren = Array.new(5) {Array.new}

        # 初期化
        3.times do |i|
            5.times do |j|
                kuren[j] << "P" + "R" * (3 - i) + "Q" + "L" * (3 - i)
            end
        end
        # 搬出口でほしいやつ [コンテナ番号, index]
        findlist = [[0, 0],[5, 1],[10, 2],[15, 3],[20, 4]]
        nextfindlist =  [[1,2,3,4],[6,7,8,9],[11,12,13,14],[16,17,18,19],[21,22,23,24]]
        # 各搬出口に入れたい個数
        zan = Array.new()
        5.times do |i|
            zan << 5
        end

        wantindex = 0
        nowsize = 0 # 10000回で終わる用
        owaricount = 0
        zancount = 0
        runsuu = rand(0..4)
        # 10000回動作したら終了
        while nowsize <= 10000
            runsuu = rand(0..4) # 0~4までランダムに取得
            break if owaricount == 25 # 25個すべて出したら終了
            # 5個排出しきっていたので別のやつ探す
            if findlist[runsuu][0] == findlist[runsuu][1] * 5 + 5
                while true
                    runsuu += 1
                    runsuu %= 5
                    break if findlist[runsuu][0] != findlist[runsuu][1] * 5 + 5
                end
            end
            want = findlist[runsuu][0] # 探すコンテナ番号
            wantindex = findlist[runsuu][1] # 探すコンテナindex
            # mapから探します
            5.times do |i|
                (1..4).each do |j|
                    if map[i][j] == want
                        # 右端が運ぶ奴なら子クレーンに運ばせる
                        if map[i].slice(j..).uniq == [want, 30] || map[i].slice(j..).uniq == [30] || map[i].slice(j..).uniq == [30, want]
                            # pp "右端が運ぶ奴なら子クレーンに運ばせる"
                            idou = yokooku(i, j - 1, wantindex)
                            (0..4).each do |k|
                                if i == k
                                    kuren[k] << idou
                                else
                                    kuren[k] << "." * idou.size
                                end
                            end
                            if zan[i] == 5
                                tumeru = migizurasi(j - 1, zan[i])
                                (0..4).each do |k|
                                    if i == k
                                        kuren[k] << tumeru
                                    else
                                        kuren[k] << "." * tumeru.size
                                    end
                                end
                                map[i].delete_at(j)
                                map[i].unshift(30)
                            else
                                map[i][j] = 30
                            end
                            zan[i] -= 1
                            # 現在移動した数を加算
                            nowsize += idou.size
                            # 搬出した数を+1
                            owaricount += 1
                            # 次に探すコンテナを+1
                            findlist[runsuu][0] += 1
                        # 5個あるときは右にずらす
                        elsif zan[i] == 5
                            # pp "5個あるときは右にずらす"
                            idou = daiidou(i, j - 1, wantindex)
                            kuren[0] << idou
                            if j == 1
                                (1..4).each do |k|
                                    if k == i
                                        kuren[k] << "R" + "R" + "U" + "." * 4 + "D" + "L"
                                    else
                                        kuren[k] <<"R" + "." * 8
                                    end
                                end
                            else
                                (1..4).each do |k|
                                    kuren[k] << "." * 9
                                end
                            end
                            zan[i] -= 1
                            map[i].delete_at(j)
                            map[i].unshift(30)
                            tumeru = migizurasi(j - 1, zan[i])
                            if i == 0
                                kuren[0] << tumeru
                                (1..4).each do |k|
                                    kuren[k] << "." * ((idou.size - 9) + tumeru.size)
                                end
                            else
                                if tumeru.size >= idou.size - 9
                                    (0..4).each do |k|
                                        if i == k
                                            kuren[k] << tumeru
                                        elsif k == 0
                                            kuren[k] << "." * ((tumeru.size + 9) - idou.size)
                                        else
                                            kuren[k] << "." * tumeru.size
                                        end
                                    end
                                else
                                    (1..4).each do |k|
                                        if i == k
                                            kuren[k] << tumeru
                                            kuren[k] << "." * (idou.size - 9 - tumeru.size)
                                        else
                                            kuren[k] << "." * (idou.size - 9)
                                        end
                                    end
                                end
                            end
                            if j == 1
                                kuren[0] << "."
                                (1..4).each do |k|
                                    kuren[k] << "L"
                                end
                            end
                            # 現在移動した数を加算
                            nowsize += tumeru.size + idou.size
                            # 搬出した数を+1
                            owaricount += 1
                            # 次に探すコンテナを+1
                            findlist[runsuu][0] += 1
                        else
                            # pp "それいがい"
                            idou = daiidou(i, j - 1, wantindex)
                            kuren[0] << idou
                            if j == 1
                                (1..4).each do |k|
                                    if k == i
                                        kuren[k] << "R" + "R" + "U" + "." * 4 + "D" + "." * (idou.size - 10) + "L" + "L"
                                    else
                                        kuren[k] << "R" + "." *  (idou.size - 2) + "L"
                                    end
                                end
                            else
                                (1..4).each do |k|
                                    kuren[k] << "." * idou.size
                                end
                            end
                            zan[i] -= 1
                            map[i][j] = 30
                            # 現在移動した数を加算
                            nowsize += idou.size
                            # 搬出した数を+1
                            owaricount += 1
                            # 次に探すコンテナを+1
                            findlist[runsuu][0] += 1
                        end
                        # kuren.each do |i|
                        #     puts i.join("").size
                        # end
                    end
                end
            end
        end
        anskuren = kuren.map(&:dup) if kuren.first.join("").slice(0..10000).size <= anskuren.first.join("").slice(0..10000).size
        # break
    end
    anskuren.map do |i|
        i.join("").slice(0..10000)
    end
    anskuren.each do |i|
        puts i.join("").slice(0..-5)
    end
end

#----------------------------------------------------------------------------------
require "set"
def daiidou(y, x, index)
    if y >= index
        return "R" * x + "D" * y + "P" + "R" * (4 - x) + "U" * (y - index) + "Q" + "U" * index + "L" * 4
    else
        return "R" * x + "D" * y + "P" + "R" * (4 - x) + "D" * (index - y) + "Q" + "U" * index + "L" * 4
    end
end
def yokooku(y, x, index)
    if y >= index
        return "R" * x + "P" + "R" * (4 - x) + "U" * (y - index) + "Q" + "D" * (y - index) + "L" * 4
    else
        return "R" * x + "P" + "R" * (4 - x) + "D" * (index - y) + "Q" + "U" * (index - y) + "L" * 4
    end
end
def migizurasi(yoko, zanki)
    return "" if yoko == 0
    motu = 3 - yoko
    return "" if zanki <= motu
    kaesu = "R" * yoko
    ([zanki - motu, yoko].min).times do |i|
        kaesu += "L" + "P" + "R" + "Q" + "L"
    end
    kaesu += "L" * (yoko - [zanki - motu, yoko].min)
    return kaesu
end

def yokeru(index,wait)
    if index == 0
        return "D" + (wait * 2 - 1) * "." + "U"
    else
        return "U" + (wait * 2 - 1) * "." + "D"
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
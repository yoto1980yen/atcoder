def main
    # 計測開始
    $start_time = Time.now
    n, m, t, $la, $lb = intary
    # 都市のMapを作成
    $map = Array.new(n) {Array.new}
    m.times do
        u, i = intary
        $map[i] << u
        $map[u] << i
    end
    #lbごとにsetを作る
    setmaps = []
    $visited = make_visited(n)
    600.times do |i|
        next if $visited[i]
        $judge = false
        setmaps << Set.new
        setmaps.last << setssaiki(i, [])
        queue = []
        setmaps.last.to_a.first.each do |i|
            queue << $map[i].select { |node| not $visited[node] == true }
        end
        setmaps.pop if setmaps.last.first.size != $lb
        queue.flatten!
        while queue.length > 0
            ii = queue.shift
            next if $visited[ii]
            $judge = false
            setmaps << Set.new
            setmaps.last << setssaiki(ii, [])
            queue = []
            setmaps.last.to_a.first.each do |i|
                queue << $map[i].select { |node| not $visited[node] == true }
            end
            setmaps.pop if setmaps.last.first.size != $lb
            queue.flatten!
        end
    end
    test = []
    $a = []
    $newmap = Array.new(n, 1000)
    $newsetmap = {}
    setmaps.each.with_index do |v, i|
        $a << v.to_a
        $newsetmap[i * $lb] = v.first
        v.first.to_a.each do |j|
            $newmap[j] = i * $lb
        end
    end
    $a.flatten!
    $la.times do |i|
        $a << 0 if i >= 600
        $a << i if $newmap[i] == 1000
    end
    puts $a.join(" ")
    start = 0
    $judge = false
    t = intary
    # 初手自分がいる場所は開通しておく
    puts "s #{$lb} 0 0"
    t.each do |nextgoal|
        # startとgoalのlbsetを把握する
        startlb = $newmap[start]
        goallb = Set.new()
        if $newmap[nextgoal] == 1000
            goallb = moyoriroute(nextgoal)
        else
            goallb << $newmap[nextgoal]
        end
        $goalroute = Array.new(n)
        $route = []
        $visited = Set.new
        $start_time = Time.now
        $judge = false
        findlbsaiki(startlb, goallb, [])
        # 各LBまでのルートを見つけたので道を移動していく
        text, now = ido(start, $goalroute)
        text.shift
        text.each do |txt|
            puts txt
        end

        # LBから目的地へ移動する
        text, start = go_goal($goalroute.last, now, nextgoal)
        text.each do |txt|
            puts txt
        end
    end
    
end

#----------------------------------------------------------------------------------
require "set"
def findrouesaiki(goal, goallb, visited)
    return if visited.include?(goal)
    return if $list.size >= 15
    return if $count >= 3
    $list << goal
    visited << goal
    if $newsetmap[goallb].include?(goal)
        $count += 1
        $golist = $list.dup if $golist.size > $list.size
    end
    $map[goal].each do |i|
        findrouesaiki(i, goallb, visited)
    end
    $list.pop
    visited.delete(goal)
end
def go_goal(goallb, nowposition, goal)

    return [], goal if nowposition == goal
    putstxt = []
    # 深さ優先で最寄りを探す
    $list = []
    $golist = Array.new(1000, 0)
    $count = 0
    findrouesaiki(goal, goallb, Set.new)


    pp nowposition if goal == 388
    pp $newsetmap[goallb]
    pp $newsetmap[goallb].index(nowposition) if goal == 388
    pp $newsetmap[goallb].index($golist.last) if goal == 388
    pp $golist if goal == 388
    
    if $newsetmap[goallb].index($golist.last) == $newsetmap[goallb].index(nowposition)
    elsif $newsetmap[goallb].index($golist.last) > $newsetmap[goallb].index(nowposition)
        $newsetmap[goallb][($newsetmap[goallb].index(nowposition) + 1)..$newsetmap[goallb].index($golist.last)].each do |m|
            putstxt << "m #{m}"
        end
    else
        $newsetmap[goallb][$newsetmap[goallb].index($golist.last)..($newsetmap[goallb].index(nowposition) - 1)].reverse.each do |m|
            putstxt << "m #{m}"
        end
    end
    if $golist.size >= 2
        $golist.reverse[1..].each do |i|
            putstxt << "s 1 #{$a.index(i)} 0"
            putstxt << "m #{i}"
        end
        $golist[1..-2].each do |i|
            putstxt << "s 1 #{$a.index(i)} 0"
            putstxt << "m #{i}"
        end
        putstxt << "s #{$lb} #{goallb} 0"
        putstxt << "m #{$golist.last}"
    end
    # pp putstxt
    # return if goal == 388
    return putstxt, $golist.last
end

def ido(start, goalroute)
    putstxt = []
    want = false
    nextstart = false
    pp "goroute #{goalroute}"
    if goalroute.size >= 2
        (goalroute.size-1).times do |i|
            want = false
            nextstart = false
            pp goalroute[i]
            $newsetmap[goalroute[i]].each do |j|
                $map[j].each do |k|
                    if $newmap[k] == goalroute[i + 1]
                        want = j 
                        nextstart = k
                        break
                    end
                end
            end
            # pp $newsetmap[goalroute[i]] if i == 8
            # pp $newsetmap[goalroute[i + 1]] if i == 8
            # pp want if i == 8
            # pp nextstart if i == 8
            # pp start if i == 8
            # if start == want
            #     start = nextstart
            #     next 
            # end
            if $newsetmap[goalroute[i]].index(want) > $newsetmap[goalroute[i]].index(start)
                $newsetmap[goalroute[i]][$newsetmap[goalroute[i]].index(start)..$newsetmap[goalroute[i]].index(want)].each do |m|
                    putstxt << "m #{m}"
                end
            else
                $newsetmap[goalroute[i]][$newsetmap[goalroute[i]].index(want)..$newsetmap[goalroute[i]].index(start)].reverse.each do |m|
                    putstxt << "m #{m}"
                end
            end
            putstxt << "s #{$lb} #{goalroute[i + 1]} 0"
            start = nextstart
        end
        putstxt << "m #{nextstart}"
        return putstxt, nextstart
    else
        nextstart = start
        return putstxt, nextstart
    end

end

def findlbsaiki(startlb, goallb, queue)
    return if $judge
    # 最寄りを探す step = 1
    $visited << startlb
    $route << startlb
    if goallb.include?(startlb)
        $goalroute = $route.dup if $goalroute.size >= $route.size
        $judge = true
    end
    $newsetmap[startlb].each do |i|
        $map[i].each do |j|
            queue << $newmap[j] if $newmap[j] != 1000 && $newmap[j] != startlb
        end
    end
    queue.uniq!
    queue.each do |i|
        next if $visited.include?(i)
        findlbsaiki(i, goallb, queue)
    end
    $route.pop
    $visited.delete(startlb)
end

def moyoriroute(start)
    searched = Set.new
    lbs = Set.new
    # スタート位置の設定
    searched << start
    queue = []
    $map[start].each do |i|
        queue << [i, 1]
    end
    # 幅優先探索
    while queue.length > 0
        now, step = queue.shift
        searched << now
        break if step >= 5 && lbs.size >= 2 || lbs.size >= 4
        next_nodes = $map[now].select { |node| not searched.include?(node) }
        # puts "追加候補 -> #{next_nodes}"
        next_nodes.each { |node| queue << [node, step + 1] }
        next_nodes.each do |j|
            lbs << $newmap[j] if $newmap[j] != 1000
        end
    end
    return lbs
end

def setssaiki(i, list)
    return list if $judge
    $visited[i] = true
    list << i
    if list.size == $lb
        $judge = true 
        return list
    end
    $map[i].each do |j|
        next if $visited[j]
        setssaiki(j, list)
        return list if $judge
    end
    list.pop
    return list
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
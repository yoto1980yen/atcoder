def main
    # 計測開始
    $start_time = Time.now
    n, m, t, la, $lb = intary
    # 都市のMapを作成
    $map = Array.new(n) {Array.new}
    m.times do
        u, i = intary
        $map[i] << u
        $map[u] << i
    end
    #出来るだけ長い道のりを探したい こいつを大通りとする
    aslice = []
    50.times do |index|
        $visited = make_visited(n)
        $a = []
        $aa = []
        $keisoku_time = Time.now
        saiki(index)
        aslice = $aa.dup if aslice.size < $aa.size
    end
    $seta = Set.new(aslice)
    $a = aslice.dup
    la.times do |i|
        if i >= 600
            $a << 0 
        elsif aslice.include?(i) == false
            $a << i
        end
    end
    puts $a.join(" ")


    # 都市をめぐる
    start = 0
    # スタートを大通りに置く 幅優先で最寄りの大通りを探し深さ優先で経路を決める
    unless $seta.include?(start)
        $keisoku_time = Time.now
        $modori = []
        $mo = []
        $visited = Set.new
        route = moyoriroute(start)
        route.shift
        route.each do |i|
            puts "s 1 #{$a.index(i)} 0"
            puts "m #{i}"
        end
        start = route.last
    end


    t = intary
    t.each do |i|
        # start = 20
        # i = 430
        next if i == start
        #大通りにゴールがあるか　ないなら大通りまでのルートを用意
        unless $seta.include?(i)
            goalroute = moyoriroute(i)
            idoumoto = $a.index(start)
            idousaki = $a.index(goalroute.last)
            putslist = oodooriidou(idoumoto, idousaki)
            putslist.each do |txt|
                puts txt
            end
            # pp $a.slice(idoumoto..idousaki)
            # pp $a.slice(idoumoto..idousaki).size
            # pp (idousaki - idoumoto)
            # pp idoumoto
            #pp idousaki
            # pp $a.index(380)
            # return
            # 大通りから目的地へ行く
            goalroute.reverse[1..].each do |yorimiti|
                puts "s 1 #{$a.index(yorimiti)} 0"
                puts "m #{yorimiti}"
            end
            # そして大通りに戻る
            goalroute[1..].each do |yorimiti|
                puts "s 1 #{$a.index(yorimiti)} 0"
                puts "m #{yorimiti}"
            end
            # pp $mo
            # pp $a.slice(315..319)
            # pp $a.index(10)
            # return
            # pp idoumoto
            # pp idousaki
            # pp goalroute
            # pp goalroute.reverse.slice(1..-1)
            # pp goalroute.slice(1..-1)
            # pp $a.index(380)
            start = goalroute.last
        else
            idoumoto = $a.index(start)
            idousaki = $a.index(i)
            putslist = oodooriidou(idoumoto, idousaki)
            putslist.each do |txt|
                puts txt
            end
            start = i
        end
        # return
    end
end

#----------------------------------------------------------------------------------
require "set"
def saiki(i)
    return if Time.now - $keisoku_time >= 0.02
    $visited[i] = true
    $a << i
    $map[i].each do |j|
        next if $visited[j]
        saiki(j)
    end
    $aa = $a.dup if $a.size >= $aa.size
    $visited[i] = false
    $a.pop
end
def moyoriroute(start)
    searched = Set.new
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
        next_nodes = $map[now].select { |node| not searched.include?(node) }
        # puts "追加候補 -> #{next_nodes}"
        next_nodes.each { |node| queue << [node, step + 1] }
        break if searched.select { |node| $seta.include?(node) }.size >= 13
    end
    moyorioodoori = Set.new(searched.select { |node| $seta.include?(node) })
    # 深さ優先探索で最寄りの道を探す 戻り値は経路の道list
    $keisoku_time = Time.now
    $modori = []
    $mo = $a.dup
    $visited = Set.new
    moyorisaiki(start, moyorioodoori)
    return $mo
end
def moyorisaiki(start, moyorioodoori)
    return if Time.now - $keisoku_time >= 0.01
    if moyorioodoori.size == 0
        moyorioodoori = $seta
        $visited << start
        $modori << start
        $mo = $modori.dup if moyorioodoori.include?(start) && $mo.size >= $modori.size 
        $map[start].each do |i|
            next if $visited.include?(i)
            moyorisaiki(i, moyorioodoori)
        end
        $modori.pop
    else
        $visited << start
        $modori << start
        $mo = $modori.dup if moyorioodoori.include?(start) && $mo.size >= $modori.size
        if $modori.size >= 50
            $modori.pop
            return
        end
        $map[start].each do |i|
            next if $visited.include?(i)
            moyorisaiki(i, moyorioodoori)
        end
        $modori.pop
    end
end
def oodooriidou(idoumoto, idousaki)
    txts = []
    if idousaki == idoumoto
    elsif idousaki > idoumoto
        if (idoumoto - idousaki).abs == 1
            txts << "s 1 #{idoumoto + 1} 0"
            txts << "m #{$a[idousaki]}"
        else
            sabun = idousaki - idoumoto
            idoumoto += 1
            (sabun / $lb).times do |index|
                txts << "s #{$lb} #{idoumoto + $lb * index} 0"
                $lb.times do |ii|
                    txts << "m #{$a[idoumoto + $lb * index + ii]}"
                end
            end
            if sabun % $lb >= 1
                txts << "s #{sabun % $lb} #{idousaki - sabun % $lb + 1} 0"
                (sabun % $lb).times do |ii|
                    txts << "m #{$a[idousaki - sabun % $lb + ii + 1]}"
                end
            end
        end
    else
        if (idoumoto - idousaki).abs == 1
            txts << "s 1 #{idoumoto - 1} 0"
            txts << "m #{$a[idousaki]}"
        else
            sabun = idoumoto - idousaki
            idoumoto -= 1
            (sabun / $lb).times do |index|
                txts << "s #{$lb} #{idoumoto - $lb * (index + 1) + 1} 0"
                $lb.times do |ii|
                    txts << "m #{$a[idoumoto - $lb * (index + 1) + ($lb - ii)]}"
                end
            end
            if sabun % $lb >= 1
                txts << "s #{sabun % $lb} #{idousaki} 0"
                (sabun % $lb).times do |ii|
                    txts << "m #{$a[idousaki + sabun % $lb - ii - 1]}"
                end
            end
        end
    end
    return txts
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
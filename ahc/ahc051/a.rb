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
            ans[0][i[1]] = index
            used << i[1]
            inlet = [i[2], i[3]]
            break
        end
    end
    # 各処理施設にできるだけ送れるやつを5つくらい用意する
    used = Set.new
    processor_sorter_positions = Array.new(n) {[]}
    processor_positions.each.with_index do |j, index|
        dist_sq = sorter_positions.map.with_index do |(x, y), i|
            [(x - j[0])**2 + (y - j[1])**2, i]
        end.sort
        count = 0
        dist_sq.each do |i|
            next if used.include?(i[1])
            count += 1
            processor_sorter_positions[index] << i[1]
            used << i[1]
            break if count >= 2
        end
    end

    #各処理装置にごみを送る
    inlet = [0, 5000] #スタート地点
    belt = []
    ans << [processor_sorter_positions[ans[0].index(0)].first + n]
    (m).times do |i|
        ans << [-1]
    end
    pp ans
    processor_list = []
    ans[0].each_with_index.sort.each do |_, processor|
        processor_list << processor
    end
    processor_list.each.with_index do |processor, index|
        # 効率のよさそうな分別器を十個選ぶ
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
        # pp kp
        # 分別器を置く
        # processor_sorter_positions[processor].each do |position1|
        #     processor_sorter_positions[processor].each do |position2|
        #         next if position1 == position2
        #         judge = false
        #         belt.each do |check|
        #             next if segments_intersect?(check[0], check[1], sorter_positions[position1], sorter_positions[position2])
        #             judge = true
        #         end
        #         if judge == true
        #             ans[2 + n + position1] = [kp[rand(0...kp.size)]]
        #         end
        #     end
        #     pp position1
        # end
        # prosessorをうまくくっつけて処理装置に結ぶ
        sorter = Array.new(n+m) {Array.new}
        permutations = []
        processor_sorter_positions[processor].size.times do |i|
            pp i
            processor_sorter_positions[processor].permutation(processor_sorter_positions[processor].size - i) { |n| permutations << n }
        end
        permutations.each do |p|
            judge = false
            belt_now = belt.dup
            if index == 0
                belt_now << [[0, 5000], sorter_positions[p.first]]
            end
            count = 0
            sorter = []
            p.each.with_index do |per, pi|
                # 出口1と処理装置ががベルトに交差しないか？
                if belt_cross?(belt_now, sorter_positions[per], p.size == pi + 1 ? processor_positions[processor] : sorter_positions[p[pi + 1]]) == true
                    judge = true
                    break
                end
                belt_now << [sorter_positions[per], p.size == pi + 1 ? processor_positions[processor] : sorter_positions[p[pi + 1]]]
                count += 1
                judge2 = false
                # 出口2と次の処理装置の利用する分別器がベルトに交差しないか？
                unless index == processor_list.size - 1
                    processor_sorter_positions[processor_list[index + 1]].each do |pro2|
                        # pp belt_now
                        # pp sorter_positions[per]
                        # pp sorter_positions[pro2]
                        # belt_now.each do |check|
                        #     next if check[0] == sorter_positions[per]
                        #     pp segments_intersect?(check[0], check[1], sorter_positions[per], sorter_positions[pro2])
                        # end
                        next if belt_cross?(belt_now, sorter_positions[per], sorter_positions[pro2])
                        belt_now << [sorter_positions[per], sorter_positions[pro2]]
                        judge2 = pro2
                        break
                    end
                end
                if judge2 == false
                    sorter << [per + n, p.size == pi + 1 ? processor : p[pi + 1] + n, p.size == pi + 1 ? processor : p[pi + 1] + n]
                else
                    sorter << [per + n, p.size == pi + 1 ? processor : p[pi + 1] + n, judge2 + n]
                end
                # pp belt_now
            end
            next if judge == true
            # pp p
            # pp sorter
            belt = belt_now.dup
            sorter.each do |i|
                ans[i[0] - n + 2] = [kp[rand(0...kp.size)], i[1], i[2]]
            end
            if index == 0
                ans[1] = [sorter.first[0]]
            end
            break
        end
        # return
        # processor_sorter_positions[processor_list[index + 1]]
        # # 1個直接置くわ
        # processor_sorter_positions[processor].each do |position1|
        #     # 出口1と処理装置ががベルトに交差しないか？
        #     next if belt_cross?(belt, sorter_positions[position1], processor_positions[processor])
        #     # 出口2と次の処理装置の利用する分別器がベルトに交差しないか？
        #     processor_sorter_positions[processor_list[index + 1]]
        #     if judge == false
        #         pp processor_sorter_positions[processor_list[index + 1]]
        #         belt.each do |check|
        #             if segments_intersect?(check[0], check[1], sorter_positions[position1], processor_positions[processor])
        #                 judge = true
        #             end
        #         end
        #         ans[2 + n + position1] = [kp[rand(0...kp.size)], processor + 2, processor_sorter_positions[processor_list[index + 1]].first + n + 2]
        #         break
        #     end
        # end
        # pp ans[0].each_with_index.sort
    end
    ans.each do |i|
        puts i.join(" ")
    end
    pp ans[42]
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
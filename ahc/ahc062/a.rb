def main
    n = int
    map = make_map(n, "i")

    score_path = ->(path) {
        score = 0
        path.each_with_index do |(i, j), day|
            score += day * map[i][j]
        end
        score
    }

    snake_path = -> {
        path = []
        (0...n).each do |i|
            if i.even?
                (0...n).each { |j| path << [i, j] }
            else
                (0...n).to_a.reverse_each { |j| path << [i, j] }
            end
        end
        rev = path.reverse
        score_path.call(rev) > score_path.call(path) ? rev : path
    }

    b = (n % 4 == 0) ? 4 : 1
    if b == 1
        ans = snake_path.call
        ans.each { |i, j| puts "#{i} #{j}" }
        return
    end

    bh = n / b
    bw = n / b

    block_sum = Array.new(bh) { Array.new(bw, 0) }
    (0...bh).each do |br|
        (0...bw).each do |bc|
            total = 0
            (0...b).each do |lr|
                (0...b).each do |lc|
                    total += map[br * b + lr][bc * b + lc]
                end
            end
            block_sum[br][bc] = total
        end
    end

    block_order_score = ->(order) {
        sc = 0
        order.each_with_index do |(br, bc), t|
            sc += t * block_sum[br][bc]
        end
        sc
    }

    block_adj4 = ->(a, b2) {
        (a[0] - b2[0]).abs + (a[1] - b2[1]).abs == 1
    }

    make_row_snake = ->(reverse_rows) {
        order = []
        rows = reverse_rows ? (0...bh).to_a.reverse : (0...bh).to_a
        rows.each_with_index do |br, idx|
            if idx.even?
                (0...bw).each { |bc| order << [br, bc] }
            else
                (0...bw).to_a.reverse_each { |bc| order << [br, bc] }
            end
        end
        order
    }

    make_col_snake = ->(reverse_cols) {
        order = []
        cols = reverse_cols ? (0...bw).to_a.reverse : (0...bw).to_a
        cols.each_with_index do |bc, idx|
            if idx.even?
                (0...bh).each { |br| order << [br, bc] }
            else
                (0...bh).to_a.reverse_each { |br| order << [br, bc] }
            end
        end
        order
    }

    optimize_block_order = ->(seed_order, iter) {
        ord = seed_order.dup
        cur = block_order_score.call(ord)
        m = ord.size

        iter.times do |it|
            temp = 2500.0 * (1.0 - it.to_f / iter) + 1.0

            if rand < 0.55
                i = rand(1...(m - 2))
                a = ord[i - 1]
                b1 = ord[i]
                c = ord[i + 1]
                d = ord[i + 2]
                next unless block_adj4.call(a, c)
                next unless block_adj4.call(b1, d)

                wb = block_sum[b1[0]][b1[1]]
                wc = block_sum[c[0]][c[1]]
                delta = i * wc + (i + 1) * wb - (i * wb + (i + 1) * wc)

                if delta >= 0 || rand < Math.exp(delta / temp)
                    ord[i], ord[i + 1] = ord[i + 1], ord[i]
                    cur += delta
                end
            else
                l = rand(1...(m - 3))
                r = rand((l + 2)..(m - 2))

                a = ord[l - 1]
                b1 = ord[l]
                c = ord[r]
                d = ord[r + 1]

                next unless block_adj4.call(a, c)
                next unless block_adj4.call(b1, d)

                old_seg = 0
                new_seg = 0
                idx = l
                while idx <= r
                    br, bc = ord[idx]
                    w = block_sum[br][bc]
                    old_seg += idx * w
                    new_idx = l + r - idx
                    new_seg += new_idx * w
                    idx += 1
                end
                delta = new_seg - old_seg

                if delta >= 0 || rand < Math.exp(delta / temp)
                    ord[l..r] = ord[l..r].reverse
                    cur += delta
                end
            end
        end

        ord
    }

    block_candidates = []
    base_orders = [
        make_row_snake.call(false),
        make_row_snake.call(true),
        make_col_snake.call(false),
        make_col_snake.call(true)
    ]
    base_orders.each do |ord|
        block_candidates << ord
        block_candidates << ord.reverse
        opt = optimize_block_order.call(ord, 35_000)
        block_candidates << opt
        block_candidates << opt.reverse
    end

    block_order = block_candidates.max_by { |ord| block_order_score.call(ord) }

    move_to_side = {
        [-1, 0] => :up,
        [1, 0] => :down,
        [0, -1] => :left,
        [0, 1] => :right
    }
    opposite = {
        up: :down,
        down: :up,
        left: :right,
        right: :left
    }

    gate_coords = if b >= 4
        {
            up: [[0, 1], [0, 2]],
            down: [[b - 1, 1], [b - 1, 2]],
            left: [[1, 0], [2, 0]],
            right: [[1, b - 1], [2, b - 1]]
        }
    else
        mid = [b / 2 - 1, 0].max
        {
            up: [[0, mid]],
            down: [[b - 1, mid]],
            left: [[mid, 0]],
            right: [[mid, b - 1]]
        }
    end

    cells = b * b
    to_id = ->(r, c) { r * b + c }
    id_r = ->(id) { id / b }
    id_c = ->(id) { id % b }

    neigh = Array.new(cells) { [] }
    (0...b).each do |r|
        (0...b).each do |c|
            id = to_id.call(r, c)
            (-1..1).each do |dr|
                (-1..1).each do |dc|
                    next if dr == 0 && dc == 0
                    nr = r + dr
                    nc = c + dc
                    next if nr < 0 || nr >= b || nc < 0 || nc >= b
                    neigh[id] << to_id.call(nr, nc)
                end
            end
        end
    end

    side_gate_ids = {}
    gate_coords.each do |side, coords|
        side_gate_ids[side] = coords.map { |r, c| to_id.call(r, c) }
    end
    all_gate_ids = side_gate_ids.values.flatten.uniq

    full_mask = (1 << cells) - 1
    find_local_path = ->(s_id, e_id, reverse_order) {
        return nil if s_id == e_id
        used = Array.new(cells, false)
        used[s_id] = true
        path = [s_id]
        dead = {}
        found = false

        dfs = nil
        dfs = ->(cur, mask, depth) {
            if mask == full_mask
                return cur == e_id
            end

            key = (mask << 5) | cur
            return false if dead[key]

            cand = neigh[cur].select { |nid| !used[nid] }
            if depth == cells - 1
                return false unless !used[e_id] && cand.include?(e_id)
                cand = [e_id]
            else
                cand.sort_by! { |nid| neigh[nid].count { |nn| !used[nn] } }
                cand.reverse! if reverse_order
            end

            cand.each do |nid|
                used[nid] = true
                path << nid
                if dfs.call(nid, mask | (1 << nid), depth + 1)
                    found = true
                    return true
                end
                path.pop
                used[nid] = false
            end
            dead[key] = true
            false
        }

        dfs.call(s_id, 1 << s_id, 1)
        found ? path.dup : nil
    }

    local_path_cache = {}
    cache_limit = 2
    all_gate_ids.each do |s_id|
        all_gate_ids.each do |e_id|
            next if s_id == e_id
            candidates = []
            p1 = find_local_path.call(s_id, e_id, false)
            candidates << p1 if !p1.nil?
            if candidates.size < cache_limit
                p2 = find_local_path.call(s_id, e_id, true)
                candidates << p2 if !p2.nil? && (p1.nil? || p2 != p1)
            end
            local_path_cache[[s_id, e_id]] = candidates
        end
    end

    block_values = ->(br, bc) {
        vals = Array.new(cells, 0)
        (0...b).each do |lr|
            (0...b).each do |lc|
                vals[to_id.call(lr, lc)] = map[br * b + lr][bc * b + lc]
            end
        end
        vals
    }

    local_score = ->(id_path, vals) {
        sc = 0
        id_path.each_with_index do |id, t|
            w = (t + 1) * (t + 1)
            sc += w * vals[id]
        end
        sc
    }

    choose_local_path = ->(br, bc, s_ids, e_ids) {
        vals = block_values.call(br, bc)
        best_path = nil
        best_score = -1

        s_ids.each do |sid|
            e_ids.each do |tid|
                next if sid == tid
                cands = local_path_cache[[sid, tid]]
                next if cands.nil? || cands.empty?
                cands.each do |cand|
                    sc = local_score.call(cand, vals)
                    if best_path.nil? || sc > best_score
                        best_score = sc
                        best_path = cand
                    end
                end
            end
        end
        best_path
    }

    build_path_for_order = ->(order) {
        block_in_side = Array.new(order.size)
        block_out_side = Array.new(order.size)
        (0...order.size).each do |idx|
            if idx > 0
                pbr, pbc = order[idx - 1]
                cbr, cbc = order[idx]
                mv = [cbr - pbr, cbc - pbc]
                side = move_to_side[mv]
                return nil if side.nil?
                block_in_side[idx] = opposite[side]
            end
            if idx + 1 < order.size
                cbr, cbc = order[idx]
                nbr, nbc = order[idx + 1]
                mv = [nbr - cbr, nbc - cbc]
                side = move_to_side[mv]
                return nil if side.nil?
                block_out_side[idx] = side
            end
        end

        all_path = []
        order.each_with_index do |(br, bc), idx|
            in_side = block_in_side[idx]
            out_side = block_out_side[idx]

            s_ids = in_side.nil? ? all_gate_ids : side_gate_ids[in_side]
            e_ids = out_side.nil? ? all_gate_ids : side_gate_ids[out_side]

            local_ids = choose_local_path.call(br, bc, s_ids, e_ids)
            return nil if local_ids.nil?

            local_ids.each do |id|
                lr = id_r.call(id)
                lc = id_c.call(id)
                all_path << [br * b + lr, bc * b + lc]
            end
        end

        used = Array.new(n) { Array.new(n, false) }
        all_path.each_with_index do |(i, j), idx|
            return nil if i < 0 || i >= n || j < 0 || j >= n || used[i][j]
            used[i][j] = true
            next if idx == 0
            pi, pj = all_path[idx - 1]
            return nil if [(pi - i).abs, (pj - j).abs].max != 1
        end
        return nil unless all_path.size == n * n
        all_path
    }

    eval_orders = []
    block_candidates.each { |ord| eval_orders << ord }
    eval_orders << block_order
    eval_orders << block_order.reverse

    uniq_orders = {}
    eval_orders.each { |ord| uniq_orders[ord.join("|")] = ord }

    best_path = nil
    best_score = -1
    uniq_orders.each_value do |ord|
        path = build_path_for_order.call(ord)
        next if path.nil?
        sc = score_path.call(path)
        if best_path.nil? || sc > best_score
            best_score = sc
            best_path = path
        end
    end

    ans = best_path.nil? ? snake_path.call : best_path
    ans.each { |i, j| puts "#{i} #{j}" }
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
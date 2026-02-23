def main
    n, m, t, u = intary
    field = []
    scores = 0
    n.times do |i|
        field << Array.new(n) { Array.new(3, -1)}
        intary.each.with_index do |score, index|
            field[i][index][0] = score
            scores += score
        end
    end
    scores_ave = scores / 100
    ways = [[0, 1], [1, 0], [-1, 0], [0, -1]]
    players = []
    next_position = []
    m.times do |i|
        players << [0, intary]
    end


    # 初ターンはいまの場所に居る しかしU == 1なら価値の高い場所に移動
    if u != 1
        puts players[0][1].join(" ")
    else
        next_visit = [[0,0], 0]
        ways.each do |way|
            next if players[0][1][0] + way[0] >= n || players[0][1][0] + way[0] < 0 || players[0][1][1] + way[1] >= n || players[0][1][1] + way[1] < 0 # 画面外
            if next_visit[1] <= field[players[0][1][0] + way[0]][players[0][1][1] + way[1]][0]
                next_visit = [[players[0][1][0] + way[0], players[0][1][1] + way[1]], field[players[0][1][0] + way[0]][players[0][1][1] + way[1]][0]]
            end
        end
        puts next_visit[0].join(" ")
    end


    # リフレッシュしますよん
    STDOUT.flush


    (t-1).times do |i|
        puts "# ターン #{i+2}"
        next_position = []
        before_field = []
        # 前のフィールドの情報を反映
        field.each do |y|
            before_field << []
            y.each do |x|
                before_field[-1] << x.dup
            end
        end
        # playerの位置やフィールドの情報を取得
        m.times do |player| # playerがいくと決めた場所 (一旦使わない)
            tmp = intary
        end
        m.times do |player| # playerがの今いる場所
            players[player][1] = intary
        end
        n.times do |x| # 各領地の所有者
            intary.each.with_index do |player, index|
                field[x][index][1] = player
            end
        end
        n.times do |x| # 各領地のレベル
            intary.each.with_index do |level, index|
                field[x][index][2] = level
            end
        end


        # 各プレイヤーの得点を計算
        m.times do |player|
            players[player][0] = 0
        end 
        n.times do |y|
            n.times do |x|
                players[field[y][x][1]][0] += field[y][x][0] * field[y][x][2]
            end
        end

        
        # まず自分の行ける場所をリスト化
        can_visit = [[players[0][1], field[players[0][1][0]][players[0][1][1]]]]
        queue = [players[0][1]]
        while queue.size != 0
            y, x = queue.shift
            ways.each do |way|
                next if y + way[0] >= n || y + way[0] < 0 || x + way[1] >= n || x + way[1] < 0 # 画面外
                next if can_visit.include?([[y + way[0], x + way[1]],field[y + way[0]][x + way[1]]]) == true
                can_visit << [[y + way[0], x + way[1]], field[y + way[0]][x + way[1]]] if players.transpose[1].slice(1..-1).include?([y + way[0], x + way[1]]) == false
                queue << [y + way[0], x + way[1]] if field[y + way[0]][x + way[1]][1] == 0
            end
        end
        can_visit = can_visit.uniq.sort_by{|v| [-v[1][1], -v[1][0]]} # 人の領地優先 # 次に価値
        puts "# #{can_visit}"

        if m <= 4 # プレイヤー数が少ないときは、価値の高い場所を優先して攻める
            can_visit.each do |visit|
                # 自分の領地の場合は価値が score_ave + 100 で且つuが1より大きいとき且つvisit[1][2] < uなら補強する
                if visit[1][1] == 0 && visit[1][0] >= scores_ave + 100 && u > 1 && visit[1][2] < u
                    next_position = visit[0]
                    puts "#補強する #{next_position}"
                    break
                end
            end
            # 基本的には侵略をメインにする
            if next_position == []
                can_visit.each do |visit|
                    next if visit[1][1] == 0 # 自分の領地はスルー
                    next if visit[1][2] >= 2 # 強度が2以上の領地はスルー
                    puts "# 価値の高い場所を優先して攻める #{visit[0]}"
                    next_position = visit[0]
                end
            end
            # それもないならとりあえず価値の高い場所に行く
            if next_position == []
                next_position = can_visit[0][0]
            end
        elsif
            # 50ターンまでは領土を広げることを優先
            if i < 50
                # can_visitに別のプレイヤーの領地と自分の領地が隣接しているなら補強する
                can_visit.each do |visit|
                    if visit[1][1] == 0 # 自分の領地の場合は上下左右を比較して別プレイヤー(field[y][x][1] > 0)の領地があれば補強する
                        ways.each do |way|
                            next if visit[0][0] + way[0] >= n || visit[0][0] + way[0] < 0 || visit[0][1] + way[1] >= n || visit[0][1] + way[1] < 0 # 画面外
                            next if field[visit[0][0] + way[0]][visit[0][1] + way[1]][1] == 0 # 自分の領地はスルー
                            # 自分の領地の内、別プレイヤーの領地と隣接しているなら補強する
                            if field[visit[0][0] + way[0]][visit[0][1] + way[1]][1] > 0 && u > 1 && field[visit[0][0]][visit[0][1]][2] < 3
                                next_position = visit[0]
                                break
                            end
                        end
                    end
                    puts "# 隣接しているから補強した #{next_position}"
                    break if next_position != [] #next_positionが決まっているならループを抜ける
                end

                # before_fieldとfieldを比較して、前のターンから自分の領土の強度が下がっている場所があれば再度補強する
                can_visit.each do |visit|
                    y, x = visit[0]
                    if field[y][x][1] == 0 && field[y][x][2] < before_field[y][x][2] && before_field[y][x][1] != -1
                        next_position = [y, x]
                        puts "# 侵略されたから補強した #{next_position}"
                        break
                    end
                end
                # 基本方針として価値高い順に自分以外の領地を埋める(#next_positionが決まっているならスルーする)
                if next_position == []
                    can_visit.each do |visit|
                        next if visit[1][1] == 0 || visit[1][2] >= 2 # 自分の領地はスルーだしほかのプレイヤーの陣地且つ補強土が2以上なら行かない
                        next_position = visit[0]
                        puts "# とりあえず価値の高い場所に行く #{next_position}"
                        break
                    end
                end
                if next_position == []
                    can_visit.each do |visit|
                        next if visit[1][1] <= 0 # 自分の領地はスルー
                        next_position = visit[0]
                        puts "# とりあえず√ #{next_position}"
                        break
                    end
                end
            else # 50ターン以降は領土を広げることも考えるが、基本的には補強することを優先(他プレイヤーの影響のない自分の陣地も価値が高い順に補強する)
                # before_fieldとfieldを比較して、前のターンから自分の領土の強度が下がっている場所があれば再度補強する
                can_visit.each do |visit|
                    y, x = visit[0]
                    if field[y][x][1] == 0 && field[y][x][2] < before_field[y][x][2] && before_field[y][x][1] != -1
                        next_position = [y, x]
                        puts "# 侵略されたから補強した #{next_position}"
                        break
                    end
                end
                if next_position == []
                    can_visit.each do |visit|
                        if visit[1][1] > 0 && visit[1][2] == 1 # 別のプレイヤーの陣地だったとしても強度が1であれば侵略する
                            next_position = visit[0]
                            puts "# 強度1の他プレイヤーの領地を侵略した #{next_position}"
                            break
                        end
                        if visit[1][1] == 0 # 自分の領地の中では価値が高い順に補強する
                            if u > 1 && field[visit[0][0]][visit[0][1]][2] < u
                                next_position = visit[0]
                                puts "# 価値の高い自分の領地を補強した #{next_position}"
                                break
                            end
                        end
                    end
                end
                if next_position == []
                    can_visit.each do |visit|
                        next if visit[1][1] == 0 # 自分の領地はスルー
                        next_position = visit[0]
                        puts "# とりあえず√ #{next_position}"
                        break
                    end
                end
            end
        end
        # #playerのポイントが高い順にソート
        #   new_can_visit = []
        #   players.each_with_index.sort.reverse.each do |player|
        #       can_visit.each do |visit|
        #           new_can_visit << visit if visit[1][1] == player[1]
        #       end
        #       can_visit.each do |visit|
        #           new_can_visit << visit if visit[1][1] == -1
        #       end
        #   end
        
        # 自分の回答を出力
          puts next_position.join(" ")


        # リフレッシュしますよん
          STDOUT.flush
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
def main
    $n = int
    $map = make_map($n, "s")
    $ways = [[0, 1],[0, -1],[1, 0], [-1, 0]]
    $ps = []
    $map.each.with_index do |v, i|
        v.each.with_index do |vv, ii|
            $ps << [i, ii] if vv == "P"
        end
    end
    $visited = []
    $n.times do |i|
        $visited << make_visited($n)
    end
    $go = []
    $ans = 10000000000000
    saiki($ps[0][0], $ps[0][1])
    pp $ans
end

#----------------------------------------------------------------------------------
require "set"
def saiki(y, x)
    list = []
    nlist = []
    $ways.each.with_index do |way, i|
        if y + way[0] < 0 || y + way[0] > $n - 1 || x + way[1] < 0 || x + way[1] > $n - 1 || $map[y + way[0]][x + way[1]] == "#"
            list << way
        else
            nlist << way
        end
    end
    if list.size > 0
        $twovisited = []
        $n.times do |i|
            $twovisited << make_visited($n)
        end
        yy = $ps[1][0]
        xx = $ps[1][1]
        $twovisited[yy][xx] = true
        $go.each do |i|
            unless yy + $ways[i][0] < 0 || yy + $ways[i][0] > $n - 1 || xx +  $ways[i][1] < 0 || xx +  $ways[i][1] > $n - 1 || $map[yy +  $ways[i][0]][xx +  $ways[i][1]] == "#"
                yy += $ways[i][0]
                xx += $ways[i][1]
                $twovisited[yy][xx] = true
            end
        end
        twosaiki(yy, xx, list, 0) 
    end
    nlist.each.with_index do |way, i|
        if $map[y + way[0]][x + way[1]] == "." && $visited[y + way[0]][x + way[1]] == false
            $visited[y + way[0]][x + way[1]] = true
            $go << i
            saiki(y + way[0], x + way[1])
            $visited[y + way[0]][x + way[1]] = false
            $go.pop
        end
    end
end

def twosaiki(y, x, list, count)
    list.each.with_index do |way, i|
        next if y + way[0] < 0 || y + way[0] > $n - 1 || x + way[1] < 0 || x + way[1] > $n - 1 || $map[y + way[0]][x + way[1]] == "#"        
        if $map[y + way[0]][x + way[1]] == "P"
            $ans = [$ans, $go.size + count].min
            return
        end
        if $map[y + way[0]][x + way[1]] == "." && $twovisited[y + way[0]][x + way[1]] == false
            $twovisited[y + way[0]][x + way[1]] = true
            twosaiki(y + way[0], x + way[1], list, count + 1)
            $twovisited[y + way[0]][x + way[1]] = false
        end
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

main
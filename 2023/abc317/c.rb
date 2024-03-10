def main
    $v, $e = gets.chomp.split.map(&:to_i)
    @edges = []
    $e.times do |i|
        u, v, c = intary
        @edges << [u, v, -c]
        @edges << [v, u, -c]
    end
    pp @edges
    min = 0
    $v.times do |i|
        pp shortest_path(i + 1)
        min = [min, shortest_path(i + 1).min].min
    end
    pp min
    return
    n, m = intary
    tree = {}
    n.times do |i|
        tree
    end
    
    pp tree
    max = 0
    n.times do |i|
        pp start = i + 1
        pp dijkstra(tree, start.to_s)
        break
    end
end

#----------------------------------------------------------------------------------
require "set"
def shortest_path(s)
    d = Array.new($v, Float::INFINITY)
    d[s - 1] = 0
    while true
      update = false
  
      @edges.each do |e|
  
        from = e[0]
        to = e[1]
        cost = e[2]
  
        if d[from - 1] != Float::INFINITY && d[to - 1] > (d[from - 1] + cost)
          d[to - 1] = (d[from - 1] + cost)
          update = true
        end
      end
  
      break if !update
    end
    return d
  end
def dijkstra(graph, start)
    h = graph.map {|x| [x[0], x[1].keys]}.to_h
    
    shortest = Hash.new(Float::INFINITY)    #デフォルトは充分大きな数
    pred = {}
    done = h.keys.map {|node| [node, false]}.to_h
    shortest[start] = 0
    
    loop do
      #確定していない中でスタート地点から最短のノードを探す（u）
      u = nil
      h.each_key.reject {|node| done[node]}.each do |node|
        u = node if !u or shortest[node] < shortest[u]
      end
      done[start] = true
      break unless u
      done[u] = true    #探されたuは確定
      
      
      #ノードuから行けるノードvまで、スタート地点からuを経由した方が短ければshortest[v]を更新する
      h[u].each do |v|
        if (a = shortest[u] + graph[u][v]) < shortest[v]
          shortest[v] = a
          pred[v] = u
        end
      end
    end
    
    [shortest, pred]
end
def saiki(n)
    $map[n].each do |i|
        next if $visited[i[0]]
        $nowmax += i[1]
        $visited[i[0]] = true
        saiki(i[0])
        $max = [$max, $nowmax].max
        $nowmax -= i[1]
        $visited[i[0]] = false
    end
end

def int
    gets.to_i
end

def intary
    gets.split(" ").map(&:to_i)
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
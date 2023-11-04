def main
    start_time = Time.now
    $h, $w = intary
    $map = make_map($h, "s")
    $new_map = []
    $h.times do |i|
        $new_map << Array.new($w, 0)
    end
    check = []
    union = UnionFind.new $h * $w
    p "処理概要 #{Time.now - start_time}s"
    ans = 0
    cc = 0
    $h.times do |i|
        $w.times do |j|
            if $map[i][j] == "#"
                check << [i, j]
                ((i)..(i + 1)).each do |ii|
                    ((j - 1)..(j + 1)).each do |jj|
                        ans += 1
                    end
                end
            end
        end
    end
    pp ans
    check.each do |i|
        judge = false
        ((i[0])..(i[0] + 1)).each do |ii|
            ((i[1] - 1)..(i[1] + 1)).each do |jj|
                next unless ii >= 0 && ii < $h
                next unless jj >= 0 && jj < $w
                if $new_map[ii][jj] == cc
            end
        end
        cc += 1 if judge
        ((i[0])..(i[0] + 1)).each do |ii|
            ((i[1] - 1)..(i[1] + 1)).each do |jj|
                next unless ii >= 0 && ii < $h
                next unless jj >= 0 && jj < $w
                if 
                $new_map[ii][jj] = cc
            end
        end
    end
    pp ans
    p "処理概要 #{Time.now - start_time}s"
    return
    p union.size
    
    # $h.times do |i|
    #     $w.times do |j|
    #         if $map[i][j] == "#" && $visited.include?("#{i} #{j}") != true
    #             $visited << "#{i} #{j}"
    #             saiki(i, j, 1)
    #             ans += 1
    #         end
    #     end
    # end
    puts ans
end

#----------------------------------------------------------------------------------
require "set"
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
        Set.new(@parent.map { |id_x| get_parent(id_x) }).size
      end
  end
  
def saiki(h, w, v)
    ((h)..(h + 1)).each do |i|
        pp v
        ((w - 1)..(w + 1)).each do |j|
            next unless i >= 0 && i < $h
            next unless j >= 0 && j < $w
            if $map[i][j] == "#" && $visited.include?("#{i} #{j}") != true
                $visited << "#{i} #{j}"
                saiki(i, j, v + 1)
            end
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
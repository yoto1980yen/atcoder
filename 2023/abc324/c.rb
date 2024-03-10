def main
    n, t = strary
    ans = []
    t = t.split("")

    n.to_i.times do |k|
        ansjudge = false
        judge = false
        s = gets.chomp.split("")
        if s.size > t.size && s.size - t.size == 1
            scount = 0
            t.size.times do |i|
                next if t[i] == s[i + scount]
                if t[i] != s[i + scount]
                    if judge
                        ansjudge = true
                        break
                    end
                    judge = true
                    scount = 1
                    next if t[i] == s[i + scount]
                    ansjudge = true
                end
            end
        elsif s.size == t.size
            s.size.times do |i|
                next if t[i] == s[i]
                if t[i] != s[i]
                    if judge
                        ansjudge = true
                        break
                    end
                    judge = true
                    
                end
            end
        elsif t.size > s.size && t.size - s.size == 1
            tcount = 0
            s.size.times do |i|
                next if t[i + tcount] == s[i]
                if t[i + tcount] != s[i]
                    
                    if judge
                        ansjudge = true
                        break
                    end
                    judge = true
                    tcount = 1
                    next if t[i + tcount] == s[i]
                    ansjudge = true
                end
            end
        else
            ansjudge = true
        end
        next if ansjudge
        ans << k + 1
    end
    puts ans.size
    puts ans.join(" ")
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
    gets.chomp.split(" ")
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
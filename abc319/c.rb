def main
    c = make_map(3, "i")
    ans = 1.to_f
    now = (0..8).to_a.permutation(9).to_a
    ans = 0
    now.each do |i|
        judge = Array.new(8, false)
        hantei = true
        i.each do |j|
            if j == 0
                if judge[0]
                    if judge[0] == c[0][0]
                        hantei = false
                        break
                    end
                    judge[0] = 10
                end
                if judge[3]
                    if judge[3] == c[0][0]
                        hantei = false
                        break
                    end
                    judge[3] = 10
                end
                if judge[6]
                    if judge[6] == c[0][0]
                        hantei = false
                        break
                    end
                    judge[6] = 10
                end
                judge[0] = c[0][0] unless judge[0]
                judge[3] = c[0][0] unless judge[3]
                judge[6] = c[0][0] unless judge[6]
                
            elsif j == 1
                if judge[0]
                    if judge[0] == c[0][1]
                        hantei = false
                        break
                    end
                    judge[0] = 10
                end
                if judge[4]
                    if judge[4] == c[0][1]
                        hantei = false
                        break
                    end
                    judge[4] = 10
                end
                judge[0] = c[0][1] unless judge[0]
                judge[4] = c[0][1] unless judge[4]
            elsif j == 2
                if judge[0]
                    if judge[0] == c[0][2]
                        hantei = false
                        break
                    end
                    judge[0] = 10
                end
                if judge[5]
                    if judge[5] == c[0][2]
                        hantei = false
                        break
                    end
                    judge[5] = 10
                end
                if judge[7]
                    if judge[7] == c[0][2]
                        hantei = false
                        break
                    end
                    judge[7] = 10
                end
                judge[0] = c[0][2] unless judge[0]
                judge[5] = c[0][2] unless judge[5]
                judge[7] = c[0][2] unless judge[7]
            elsif j == 3
                if judge[1]
                    if judge[1] == c[1][0]
                        hantei = false
                        break
                    end
                    judge[1] = 10
                end
                if judge[3]
                    if judge[3] == c[1][0]
                        hantei = false
                        break
                    end
                    judge[3] = 10
                end
                judge[1] = c[1][0] unless judge[1]
                judge[3] = c[1][0] unless judge[3]
            elsif j == 4
                if judge[1]
                    if judge[1] == c[1][1]
                        hantei = false
                        break
                    end
                    judge[1] = 10
                end
                if judge[4]
                    if judge[4] == c[1][1]
                        hantei = false
                        break
                    end
                    judge[4] = 10
                end
                if judge[6]
                    if judge[6] == c[1][1]
                        hantei = false
                        break
                    end
                    judge[6] = 10
                end
                if judge[7]
                    if judge[7] == c[1][1]
                        hantei = false
                        break
                    end
                    judge[7] = 10
                end
                judge[1] = c[1][1] unless judge[1]
                judge[4] = c[1][1] unless judge[4]
                judge[6] = c[1][1] unless judge[6]
                judge[7] = c[1][1] unless judge[7]
            elsif j == 5
                if judge[1]
                    if judge[1] == c[1][2]
                        hantei = false
                        break
                    end
                    judge[1] = 10
                end
                if judge[5]
                    if judge[5] == c[1][2]
                        hantei = false
                        break
                    end
                    judge[5] = 10
                end
                judge[1] = c[1][2] unless judge[1]
                judge[5] = c[1][2] unless judge[5]
            elsif j == 6
                if judge[2]
                    if judge[2] == c[2][0]
                        hantei = false
                        break
                    end
                    judge[2] = 10
                end
                if judge[3]
                    if judge[3] == c[2][0]
                        hantei = false
                        break
                    end
                    judge[3] = 10
                end
                if judge[7]
                    if judge[7] == c[2][0]
                        hantei = false
                        break
                    end
                    judge[7] = 10
                end
                judge[2] = c[2][0] unless judge[2]
                judge[3] = c[2][0] unless judge[3]
                judge[7] = c[2][0] unless judge[7]
            elsif j == 7
                if judge[2]
                    if judge[2] == c[2][1]
                        hantei = false
                        break
                    end
                    judge[2] = 10
                end
                if judge[4]
                    if judge[4] == c[2][1]
                        hantei = false
                        break
                    end
                    judge[4] = 10
                end
                judge[2] = c[2][1] unless judge[2]
                judge[4] = c[2][1] unless judge[4]
            elsif j == 8
                if judge[2]
                    if judge[2] == c[2][2]
                        hantei = false
                        break
                    end
                    judge[2] = 10
                end
                if judge[5]
                    if judge[5] == c[2][2]
                        hantei = false
                        break
                    end
                    judge[5] = 10
                end
                if judge[6]
                    if judge[6] == c[2][2]
                        hantei = false
                        break
                    end
                    judge[6] = 10
                end
                judge[2] = c[2][2] unless judge[2]
                judge[5] = c[2][2] unless judge[5]
                judge[6] = c[2][2] unless judge[6]
            end
        end
        ans += 1 if hantei
    end
    pp (ans.to_f / now.size.to_f).to_f
end

#----------------------------------------------------------------------------------
require "set"
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
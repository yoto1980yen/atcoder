def main
    p = []
    3.times do |j|
        p << []
        4.times do |i|
            p[j] << strary
        end
    end
    p.each do |i|
        i.size.times do |j|
            break if i[j] == nil
            i.delete_at(j) unless i[j].include?("#")
        end
    end
    p.each do |i|
        i.transpose.size.times do |j|
            break if i.transpose[j] == nil
            unless i.transpose[j].include?("#")
                i.each do |k|
                    k.delete_at(j)
                end
            end
        end
    end
    inp = [[], [], []]
    p.each.with_index do |i, ii|
        i.each.with_index do |j, jj|
            j.each.with_index do |k, kk|
                inp[ii] << [jj, kk] if k == "#"
            end
        end
    end
    mapp = []
    4.times do |i|
        mapp << [".", ".", ".", "."]
    end
    judge = make_visited(2)
    4.times do |y|
        4.times do |x|
            map = mapp.dup
            # 1を見る
            judge = false
            inp[0].each do |p1|
                if map[p1[0] + y] == nil
                    judge = true
                    break
                end
                if map[p1[0] + y][p1[1] + x] == nil #|| map[p[0] + y, p[1] + x] == "#"
                    judge = true
                    break
                end
            end
            next if judge
            newmap = []
            map.each do |mp|
                newmap << mp.dup
            end
            inp[0].each do |p1|
                newmap[p1[0] + y][p1[1] + x] = "#"
            end

            # 2を見る
            4.times do |kai|
                newmap = newmap.dup.transpose.map(&:reverse)
                4.times do |yy|
                    4.times do |xx|
                        judge = false
                        inp[1].each do |p2|
                            if newmap[p2[0] + yy] == nil
                                judge = true
                                break
                            end
                            if newmap[p2[0] + yy][p2[1] + xx] == nil || newmap[p2[0] + yy][p2[1] + xx] == "#"
                                judge = true
                                break
                            end
                        end
                        next if judge
                        newnewmap = []
                        newmap.each do |mp|
                            newnewmap << mp.dup
                        end
                        inp[1].each do |p2|
                            newnewmap[p2[0] + yy][p2[1] + xx] ="#"
                        end
                        
                        # 3miru
                        4.times do |kai2|
                            newnewmap = newnewmap.dup.transpose.map(&:reverse)
                            4.times do |yyy|
                                4.times do |xxx|
                                    judge = false
                                    inp[2].each do |p3|
                                        if newnewmap[p3[0] + yyy] == nil
                                            judge = true
                                            break
                                        end
                                        if newnewmap[p3[0] + yyy][p3[1] + xxx] == nil || newnewmap[p3[0] + yyy][p3[1] + xxx] == "#"
                                            judge = true
                                            break
                                        end
                                    end
                                    next if judge
                                    newnewnewmap = []
                                    newnewmap.each do |mp|
                                        newnewnewmap << mp.dup
                                    end
                                    inp[2].each do |p3|
                                        newnewnewmap[p3[0] + yyy][p3[1] + xxx] ="#"
                                    end
                                    lastjudge = false
                                    newnewnewmap.each do |last|
                                        if last.include?(".")
                                            lastjudge = true
                                        end
                                    end
                                    next if lastjudge
                                    puts "Yes"
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    puts "No"
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
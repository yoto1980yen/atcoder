def main
    n, m = intary
    map = []
    map << Array.new(m + 9,".")
    n.times do |i|
        map << strary
        9.times do
            map[i + 1].push(".")
        end
        map[i + 1].unshift(".")
    end
    ans = []
    9.times do
        map << Array.new(m + 9,".")
    end
    map.each.with_index do |v, i|
        v.each.with_index do |vv, j|
            judge = false
            if map[i][j] == "#"
                4.times do |y|
                    4.times do |w|
                        if y == 3
                            if w == 3
                                judge = true unless map[i + y][j + w] == "." && map[i + y + 2][j + w + 2] == "." 
                            else
                                judge = true unless map[i + y][j + w] == "." && map[i + y + 2][j + w + 6] == "." 
                            end
                        elsif w == 3
                            judge = true unless map[i + y][j + w] == "." && map[i + y + 6][j + w + 2] == "."
                        else
                            judge = true unless map[i + y][j + w] == "#" && map[i + y + 6][j + w + 6] == "#"
                        end
                    end
                end
                next if judge
                ans << [i, j]
            end
        end
    end
    ans.each do |i|
        puts i.join(" ")
    end
end

#----------------------------------------------------------------------------------
require "set"
require "prime"
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
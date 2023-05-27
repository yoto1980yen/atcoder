def main
    h, w = intary
    map = []
    5.times do
        map << Array.new(w + 10,"z")
    end
    h.times do |i|
        map << strary
        map[5 + i].unshift(Array.new(5,"z"))
        map[5 + i].push(Array.new(5,"z"))
        map[5 + i].flatten!
    end
    5.times do
        map << Array.new(w + 10,"z")
    end
    ans = []
    map.each.with_index do |v, i|
        v.each.with_index do |vv, j|
            if vv == "s"
                # 上方向
                if map[i + 1][j + 1] == "n" && map[i + 2][j + 2] == "u" && map[i + 3][j + 3] == "k" && map[i + 4][j + 4] == "e"
                    ans = [[i, j], [i + 1, j + 1], [i + 2, j + 2], [i + 3, j + 3], [i + 4, j + 4]]

                elsif map[i][j + 1] == "n" && map[i][j + 2] == "u" && map[i][j + 3] == "k" && map[i][j + 4] == "e"
                    ans = [[i, j], [i,j + 1], [i,j + 2], [i,j + 3], [i,j + 4]]

                elsif map[i][j - 1] == "n" && map[i][j - 2] == "u" && map[i][j - 3] == "k" && map[i][j - 4] == "e"
                    ans = [[i, j], [i ,j - 1], [i, j - 2], [i, j - 3], [i ,j - 4]]

                elsif map[i + 1][j - 1] == "n" && map[i + 2][j - 2] == "u" && map[i + 3][j - 3] == "k" && map[i + 4][j - 4] == "e"
                    ans = [[i, j], [i + 1, j - 1], [i + 2, j - 2], [i + 3, j - 3], [i + 4, j - 4]]
                    
                elsif map[i - 1][j + 1] == "n" && map[i - 2][j + 2] == "u" && map[i - 3][j + 3] == "k" && map[i - 4][j + 4] == "e"
                    ans = [[i, j], [i - 1, j + 1], [i - 2, j + 2], [i - 3, j + 3], [i - 4, j + 4]]
                    
                elsif map[i - 1][j - 1] == "n" && map[i - 2][j - 2] == "u" && map[i - 3][j - 3] == "k" && map[i - 4][j - 4] == "e"
                    ans = [[i, j], [i - 1, j - 1], [i - 2, j - 2], [i - 3, j - 3], [i - 4, j - 4]]

                elsif map[i + 1][j] == "n" && map[i + 2][j] == "u" && map[i + 3][j] == "k" && map[i + 4][j] == "e"
                    ans = [[i, j], [i + 1, j], [i + 2, j], [i + 3, j], [i + 4, j]]

                elsif map[i - 1][j] == "n" && map[i - 2][j] == "u" && map[i - 3][j] == "k" && map[i - 4][j] == "e"
                    ans = [[i, j], [i - 1, j], [i - 2, j], [i - 3, j], [i - 4, j]]
                end
            end
        end
    end
    ans.each do |i|
        i.map! do |j|
            j -= 4
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
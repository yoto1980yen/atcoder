def main
    h, w = intary
    map = []
    h.times do
        map << strary
    end
    map << Array.new(w, ".")
    map.each do |i|
        i << "."
    end
    n = [h, w].min
    s = Array.new(n + 1, 0)
    h.times do |i|
        w.times do |j|
            next if i == 0 || j == 0 || i == h - 1 || j == w - 1
            if map[i][j] == "#" && map[i + 1][j + 1] == "#" && map[i + 1][j - 1] == "#" && map[i - 1][j + 1] == "#" && map[i - 1][j - 1] == "#"
                n.times do |k|
                    if map[i + (k + 1)][j + (k + 1)] == "."
                        s[k] += 1
                        break
                    end
                end
            end
        end
    end
    s.shift
    puts s.join(" ")
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
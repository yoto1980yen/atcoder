def main
    r, c = intary
    map = []
    nnn = []
    r.times do |i|
        now = strary
        map << now.dup
        nnn << now.dup
    end
    map.each.with_index do |retu, i|
        retu.each.with_index do |v, j|
            if v != "." && v != "#"
                
                now = v.to_i
                (now + 1).times do |k|
                    if j - k >= 0
                        (now + 1 - k).times do |l|
                            if i - l >= 0
                                nnn[i - l][j - k] = "."
                                # pp "#{ j - k}#{i - l}"
                            end
                            if i + l < r
                                nnn[i + l][j - k] = "."
                                # pp "#{ j - k}#{i + l}"
                            end
                            
                        end
                    end
                    if j + k < c 
                        (now + 1 - k).times do |l|
                            if i - l >= 0
                                nnn[i - l][j + k] = "."
                                # pp "#{ j + k}#{i - l}"
                            end
                            if i + l < r
                                nnn[i + l][j + k] = "."
                                # pp "#{ j + k}#{i + l}"
                            end
                            
                        end
                    end
                end
                
            end
            
        end
    end
    nnn.each do |i|
        puts i.join("")
    end
end

#----------------------------------------------------------------------------------
require "set"
def int
    gets.to_i
end

def intary
    gets.split().map(&:to_i)
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
    result.uniq
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
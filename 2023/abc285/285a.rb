def main
    a, b = intary
    list = {}
    list[1] = [2, 3]
    list[2] = [1, 4, 5]
    list[3] = [1, 6, 7]
    list[4] = [2, 10, 11]
    list[5] = [2, 10, 11]
    list[6] = [3, 12, 13]
    list[7] = [3, 14, 15]
    list[8] = [4]
    list[9] = [4]
    list[10] = [5]
    list[11] = [5]
    list[12] = [6]
    list[13] = [6]
    list[14] = [7]
    list[15] = [7]
    if list[a].include?(b)
        puts "Yes"
    else
        puts "No"
    end

end

#----------------------------------------------------------------------------------
def int
    gets.to_i
end

def intary
    gets.split.map(&:to_i)
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
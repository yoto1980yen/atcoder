def main
    n = int
    list = {}
    before = []
    after = []
    tukau = Set.new([])
    n.times do
        b, a = strary
        list[b] = a
        tukau.add(b)
    end
    tukau.each do |i|
        tukata = Set.new([])
        nexts = i
        tukata.add(i)
        while true
            now = list[nexts]
            tukau.delete(now)
            if tukata.include?(now)
                puts "No"
                return
            end
            if tukau.include?(list[now])
                tukata.add(now)
                nexts = now
                next
            end
            break
        end
    end
    puts "Yes"

end

require 'set'
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
    gets.chomp.split
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
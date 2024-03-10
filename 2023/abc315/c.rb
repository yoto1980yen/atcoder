def main
    n = int
    ice = {}
    n.times do |i|
        f, s = intary
        ice[f] ? ice[f] << s : ice[f] = [s]
    end
    max = 0
    ice.map {|f, s| s.sort!}
    zanmax = [[0, 0]]
    ice.each do |f, s|
        if zanmax.first[1] <= s.last
            if zanmax[1] == s.last
                zanmax << [f, s.last]
            else
                zanmax = [[f, s.last]]
            end
        end
    end
    if zanmax.size > 1
        ice.each do |f, s|
            max = [max, s.last + zanmax.first[1]].max
        end
    else
        ice.each do |f, s|
            if f == zanmax.first[0]
                unless s.size == 1
                    max = [max, s.last + s[-2] / 2].max
                end
            else
                max = [max, s.last + zanmax.first[1]].max
            end
        end
    end
    puts max
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
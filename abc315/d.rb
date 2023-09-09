def main
    h, w = intary
    kukki = []
    h.times {kukki << strary}
    while true
        # pp "#{h} #{w}"
        # pp kukki
        yoko = []
        tate = []
        if w >= 2
            kukki.each.with_index do |v, i|
                yoko << i if v.uniq.size == 1
            end
        end
        if h >= 2
            kukki.transpose.each.with_index do |v, i|
                tate << i if v.uniq.size == 1
            end
        end
        yoko.reverse.each do |i|
            kukki.delete_at(i)
        end
        tate.reverse.each do |i|
            kukki.map do |j|
                j.delete_at(i)
            end
        end
        
        h -= yoko.size
        w -= tate.size
        if yoko.size + tate.size == 0
            break
        end
        
    end
    puts h * w
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
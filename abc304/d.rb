def main
    w, h = intary
    n = int
    itigo = []
    # tate = []
    # yoko = []
    n.times do |i|
        itigo << intary
        # t, y = intary
        # tate << t
        # yoko << y
    end
    ako = int
    a = intary
    bko = int
    b = intary
    basho = {}
    itigo.each do |i|
        x = a.bsearch {|x| x >= i[0] }
        y = b.bsearch {|y| y >= i[1] }
        x = "+" if x == nil
        y = "+" if y == nil
        basho["#{x}#{y}"] ? basho["#{x}#{y}"] += 1 : basho["#{x}#{y}"] = 1
    end
    basho.values.size < (ako + 1) * (bko + 1) ? min = 0 : min = basho.values.min
    puts [min, basho.values.max].join(" ")
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
def main
    s = strary
    box = []
    kakko = []
    count = 0
    s.each_with_index do |x, i|
        if x == "("
            kakko << i
            next
        end
        if x == ")"
            hiku = kakko.pop
            unless i - hiku - 1 == 0
                box.pop(i - hiku - 1)
            end
            
        else
            if box.include?(x)
                puts "No"
                return
            end
            box << x
        end
    end
    puts "Yes"
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
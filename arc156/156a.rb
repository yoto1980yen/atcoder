def main
    t = int
    t.times do 
        n = int
        a = intary
        kara1 = []
        kara2 = []
        count = 0
        a.each.with_index do |v, i|
            if v == 1
                if kara2.empty? == false && kara2.first == i - 1
                    kara2 = []
                    count += 1
                elsif kara1.empty?
                    kara1 << i
                elsif kara1.first == i - 1
                    if kara2.empty?
                        kara2 << i
                    elsif kara2.first == i - 1
                        kara2 = []
                        count += 1
                    end
                elsif kara1.first != i - 1
                    kara1 = []
                    count += 1
                end
            end
        end
        if kara1.empty? && kara2.empty?
            puts count
        else
            puts -1
        end
    end
end

#----------------------------------------------------------------------------------
def int
    gets.to_i
end

def intary
    gets.split("").map(&:to_i)
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
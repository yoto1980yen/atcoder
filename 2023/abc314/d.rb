def main
    n = int
    s = strary
    up = Set.new([])
    s.each.with_index do |v, i|
        if ('A'..'Z').include?(v)
            up.add(i + 1)
        end
    end
    judge = false
    cash = []
    int.times do |i|
        t, x, c = gets.chomp.split(" ")
        x = x.to_i
        t = t.to_i
        if t == 1
            if judge == 1
                if ('A'..'Z').include?(c)
                    cash << x - 1
                end
            elsif judge == 2
                if ('a'..'z').include?(c)
                    cash << x - 1
                end
            end
            s[x - 1] = c
        elsif t == 2
            judge = 1
            cash = []
        else
            judge = 2
            cash = []
        end
    end
    ans = []
    cash = cash.sort
    if judge == 1
        s = s.join("").downcase.split("")
        s.each.with_index do |v, i|
            if cash.size != 0
                if cash.first == i
                    ans << v.upcase
                    cash.shift
                else
                    ans << v
                end
            else
                ans << v
            end
        end
        puts ans.join("")
    elsif judge == 2
        s = s.join("").upcase.split("")
        s.each.with_index do |v, i|
            if cash.size != 0
                if cash.first == i
                    ans << v.downcase
                    cash.shift
                else
                    ans << v
                end
            else
                ans << v
            end
        end
        puts ans.join("")
    else
        puts s.join("")
    end
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
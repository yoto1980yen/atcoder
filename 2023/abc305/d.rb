def main
    n = int
    a = intary
    s = Array.new(a.size + 1)
    s[0] = 0
    (0...a.size).each do |i|
        if i % 2 == 1
            s[i+1] = - a[i]
        else
            s[i+1] = s[i] + a[i]
        end
    end
    s.each.with_index do |v, i|
        s.delete_at(i) if v < 0
    end
    reversea = a.dup.reverse
    s.shift
    ss = Array.new(s.size + 1)
    ss[0] = 0
    (0...s.size).each do |i|
        ss[i+1] = ss[i] + s[i]
    end
    ss.shift
    q = int
    q.times do
        # pp "つぎ"
        ans = 0
        l, r = intary
        start = a.bsearch_index { |x| x >=   l }
        if start % 2 == 0
            ans += a[start] - l 
        else
            # pp (start.to_f / 2).ceil
            ans += s[(start.to_f / 2).ceil]
            # pp ans
        end
        owari = a.size - reversea.bsearch_index { |x| x <=   r } - 1
        if owari % 2 == 1
            ans += r - a[owari]
        end
        owarim = a.bsearch_index { |x| x >= r }
        ans += ss[(owari / 2).ceil] - ss[(start.to_f / 2).ceil]
        puts ans
    end
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
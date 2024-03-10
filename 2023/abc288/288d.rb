def main
    n, k = intary
    a = intary
    q = int
    r = []
    
    q.times do
        rr, ll = intary
        r << [rr, ll - rr]
        now = a.slice(rr - 1, ll - rr + 1)
        defo = now.first 
        ks = []
        sabun = 0
        count = 0
        ss = Set.new
        now.each.with_index do |v, i|
            next if i == 0
            pp i
            sabun = defo - (v + sabun)
            if i >= ll - rr + 1 - k - k + 1 
                if count == 0
                    pp ks << sabun
                else
                    ks << sabun + ks[count - 1]
                end
                count += 1
            end
            pp "#{v} #{sabun} #{ks}"
            if i == ll - rr - k + 1
                k.times do |j|
                    next if j == 0 
                    pp "#{now[i + j]} #{ks.last}"
                    ss.add(now[i + j] + ks.pop)
                end
                if ss.size == 1 && ss.first == defo
                    puts "Yes"
                else
                    puts "No"
                end
                pp ss
                break
            end
        end
    end
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
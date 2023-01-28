def main
    s = strary
    t = strary
    l = s[(s.count - t.count)..-1]
    fac = 0
    judge = false
    t.count.times do |i|
        next if l[i] == t[i] || l[i] == "?" || t[i] == "?"
        fac += 1
    end
    if fac == 0
        puts "Yes"
    else
        puts "No"
    end
    t.count.times do |i|
        nows = s.shift
        nowt = t.shift
        # pp "#{nows} #{nowt}"
        if nowt == nows ||  nowt == "?" || nows == "?"
            fac -= 1
            if fac <= 0
                fac = 0
            end
        else
            judge = true
        end
        if fac == 0 && judge == false
            puts "Yes"
        else
            puts "No"
        end
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
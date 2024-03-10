def main
    x, y, z = intary
    s = strary
    
    cap = false
    judge = s[0]
    sa = [0]
    sasa = [0]
    count = 0
    mini = 0
    max = 0
    moji = false
    if s[0] == "A"
        moji = true
    end
    s.each.with_index do |v, i|
        if judge != v
            sasa << i
            judge = v
        end
        sasa << i + 1 if i == s.size - 1
    end
    sasa.size.times do |i|
        next if i == 0
        sa << sasa[i] - sasa[i - 1]
        if moji
            max += sa.last
        else
            mini += sa.last
        end
        moji ? moji = false : moji = true
    end
    sa.shift
    moji = false
    if s[0] == "A"
        moji = true
    end

    ans = 0
    (sa.size + 1).times do |i|
        break if i == sa.size
        if moji
            max -= sa[i]
        else
            mini -= sa[i]
        end
        if cap == moji 
            xx = sa[i] * x
            yy = z + sa[i] * y
            if xx == yy
                ans += xx
                if max > mini && cap == false
                    cap ? cap = false : cap = true
                end
                if max < mini && cap == true
                    cap ? cap = false : cap = true
                end
            elsif xx < yy
                ans += xx
                #pp "#{ans} #{moji} #{cap}!" 
            else
                ans += yy
                #pp "#{ans} #{moji} #{cap}!" 
                cap ? cap = false : cap = true
            end
        else
            xx = z + sa[i] * x
            yy = sa[i] * y
            if xx == yy
                ans += xx
                if max > mini && cap == false
                    cap ? cap = false : cap = true
                end
                if max < mini && cap == true
                    cap ? cap = false : cap = true
                end
            elsif xx < yy
                ans += xx
                #pp "#{ans} #{moji} #{cap}!" 
                cap ? cap = false : cap = true
            else
                ans += yy
                #pp "#{ans} #{moji} #{cap}!" 
            end
        end
        
        moji ? moji = false : moji = true
        
    end
    pp ans
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
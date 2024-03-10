def main
    n, a, b, c, d = intary
    sa = (a + b + c + d) * 2 - n
    pp ad = a + d
    bc = b + c
    bcmin = [b, c].min
    yobun = a/2 + d/2
    ad -= yobun * 2
    defsa = sa
    while sa > 0
        pp "#{ad} #{bc} #{sa} #{bcmin}"
        if sa > yobun && yobun != 0
            sa -= yobun
            yobun = 0
        elsif yobun != 0
            yobun -= sa
            sa = 0
            ad += yobun * 2
        end
        pp "#{ad} #{bc} #{sa} #{bcmin}"
        if bc >= 1
            if sa >= ad
                sa -= ad
                ad = 0
                
            else
                ad -= sa 
                sa = 0
            end
        end
        pp "#{ad} #{bc} #{sa} #{bcmin}"
        if sa > 0
            if bcmin <= sa && bcmin != 0
                sa -= bcmin
                bc -= bcmin * 2
                ad += bcmin
                bcmin = 0
            elsif bcmin != 0
                bc -= sa * 2
                ad += sa
                bcmin -= sa
                sa = 0
            end
        end
        pp "#{ad} #{bc} #{sa} #{bcmin}"
        if defsa == sa
            puts "No"
            return
        end
        defsa = sa
    end
    if ad + bc <= 1
        puts "Yes"
    elsif ad.even? && bc.even?
        puts "Yes"
    else
        puts "No"
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
def main
    puts n = int
    

    
    list = {}
    (n+1).times do |i|
        next if i == 0
        list[i] = 0
        pp 1 /2 
        ii = 1
        aite = (i.to_f / ii.to_f).to_f
        if aite - aite.to_i == 0
            pp "#{i} #{ii} #{aite}"
            if ii == aite
                list[i] += 1
            else
                list[i] += 2
            end
            ii = ii * 2
        end
        visited = Set.new([1])
        Prime.each(n / 2 + 1) do |prime|
            ii = prime
            while true
                aite = (i.to_f / ii.to_f).to_f
                break if aite == 0 || ii * 2 > i
                if aite - aite.to_i == 0
                    pp "#{i} #{ii} #{aite}"
                    if ii == aite
                        list[i] += 1
                    elsif ii * 2 < i && visited.include?(aite.to_i) == false
                        list[i] += 2
                    end
                    visited.add(ii)
                    ii = ii * prime
                else
                    break
                end
            end
        end
        
        puts list
    end
    ans = 0
    (n / 2 + 1).times do |i|
        next if i == 0
        pp "#{list[i]} #{list[n - i]}"
        ans += list[i] * list[n - i]
    end
    puts ans
    
    
end
require 'prime'
require 'set'
#----------------------------------------------------------------------------------
def int
    gets.to_i
end

def intary
    gets.split().map(&:to_i)
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
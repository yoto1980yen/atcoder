def main
    n = int
    nextkennsaku = false
    check = false
    ccheck = 0
    genzaiti = 0
    puts "? 1\n"
    STDOUT.flush
    18.times do |i|
        s = int
        if i == 0 && s == 1
            puts "! 1\n"
            STDOUT.flush
            return
        end
        if check
            if check != s
                puts "! #{genzaiti}"
                STDOUT.flush
                return
            elsif i != 17
                genzaiti += 1
                puts "? #{genzaiti}\n"
            end
        end
        if i == 1
            ccheck = s
        elsif i <= 8
            if ccheck != s && nextkennsaku == false
                nextkennsaku = true
                genzaiti = 10 * i
                check = s
                puts "? #{10 * i + 1}\n"
            end
        elsif nextkennsaku == false
            nextkennsaku = true
            genzaiti = 10 * i
            check = s
            puts "? #{10 * i + 1}\n"
        end
        if nextkennsaku == false
            puts "? #{10 * (i + 1)}\n"
        end
        STDOUT.flush
    end
    puts "? #{n - 1}\n"
    STDOUT.flush
    s = int
    if s == 0
        puts "! #{n - 1}\n"
    end
end

#----------------------------------------------------------------------------------
require "set"
require "prime"
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
    
    result.uniq.sort
end
def divisors2(n)
    n.prime_division.inject([1]) do |ary, (p, e)|
      (0..e).map{ |e1| p ** e1 }.product(ary).map{ |a, b| a * b }
    end.sort
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
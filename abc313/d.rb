def main
    n, k = intary
    x = (1..k).to_a
    puts "? #{x.join(" ")}"
    STDOUT.flush
    kisu = []
    gusu = []
    judge = false
    (n - k + 1).times do |i|
        t = int
        if t == 0
            gusu << x.last
        else
            kisu << x.last
        end
        x.push(x.pop + 1)
        puts "? #{x.join(" ")}"
        STDOUT.flush
    end
    t = int
    if t == 0
        gusu << x.last
    else
        kisu << x.last
    end
    judge = true if gusu.size >= kisu.size
    if judge
        x = gusu.slice(0..(k - 1)).dup.push(0)
    else
        x = kisu.slice(0..(k - 1)).dup.push(0)
    end
    (k - 2).times do |j|
        if judge
            x.pop
            x.push(j + 1)
            puts "? #{x.join(" ")}"
            STDOUT.flush
        else
            x.pop
            x.push(j + 1)
            puts "? #{x.join(" ")}"
            STDOUT.flush
        end
        t = int
        if judge
            if t == 0
                gusu << x.last
            else
                kisu << x.last
            end
        else
            if t == 0
                kisu << x.last
            else
                gusu << x.last
            end
        end
    end

    x.pop
    x.push(k - 1)
    puts "? #{x.join(" ")}"
    STDOUT.flush
    t = int
    gusu.sort!
    kisu.sort!
    a = []
    if t == 0
        if gusu.include?(k - 1)
            n.times do |i|
                if gusu.first == i + 1
                    a << 0
                    gusu.shift
                else
                    a << 1
                end
            end
        else
            n.times do |i|
                if kisu.first == i + 1
                    a << 0
                    kisu.shift
                else
                    a << 1
                end
            end
        end
        puts "! #{a.join(" ")}"
        return
    else
        if gusu.include?(k - 1)
            n.times do |i|
                if gusu.first == i + 1
                    a << 1
                    gusu.shift
                else
                    a << 0
                end
            end
        else
            n.times do |i|
                if kisu.first == i + 1
                    a << 1
                    kusu.shift
                else
                    a << 0
                end
            end
        end
        puts "! #{a.join(" ")}"
        return
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
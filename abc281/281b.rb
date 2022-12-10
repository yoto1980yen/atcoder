def main
    n = strary
    if n.size != 8
        puts "No"
        return
    end
    first = n.shift
    last = n.pop
    if first != is_lower?(first) && number?(first) == false
        if number?(n.join(""))
            if n.first != "0"
                if last != is_lower?(last) && number?(last) == false
                    puts "Yes"
                    return
                end
            end
        end
    end
    puts "No"
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
# 文字列の先頭(\A)から末尾(\z)までが「0」から「9」の文字か
nil != (str =~ /\A[0-9]+\z/)
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
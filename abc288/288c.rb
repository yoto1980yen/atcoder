def main
    n, m = intary
    $path = {}
    $judge = {}
    m.times do |i|
        u, v = intary
        $path[u]? $path[u] << v : $path[u] = [v]
        $path[v]? $path[v] << u : $path[v] = [u]
        $judge[u] = false
        $judge[v] = false
    end
    $ans = 0
    $path.keys.each do |k|
        next if $judge[k]
        $judge[k] = true
        # pp "いです#{k}"
        saiki(k, 0)
        # pp $judge
    end
    pp $ans / 2
end
def saiki(i, before)
    now = $path[i]
    if i == nil
        return
    end
    $path[i].each do |j|
        if $judge[j] && before != j
            $ans += 1
            # pp "#{i} #{j} #{$judge} #{before}"
            next
        end
        if $judge[j] == false
            $judge[j] = true
            saiki(j, i)
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
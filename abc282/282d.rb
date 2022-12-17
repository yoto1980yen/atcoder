def main
    N, M = intary
    $graph = []
    (M + 1).times { $graph << [] }
    @parent = Array.new(n, -1)
    @parity = Array.new(n, 0)
end
def hukasa(list)
    list.each do |i|
        next if $check[i] == true
        $check[i] = true
        hukasa($graph[i])
    end
end
N, M = gets.split.map(&:to_i)
$graph = []
(N + 1).times { $graph << [] }
$check = []
(N + 1).times { $check << false }
M.times do
    u, v = gets.split.map(&:to_i)
    $graph[u] << v
    $graph[v] << u
end
$check[1] = true
hukasa($graph[1])
 
$check.shift
if $check.include?(false)
    puts "The graph is not connected."
else 
    puts "The graph is connected."
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
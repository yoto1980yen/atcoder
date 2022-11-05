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

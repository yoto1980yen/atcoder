
def find(i)
    return i if @parent[i] < 0

    j = @parent[i]
    k = find(j)
    @parity[i] ^= @parity[j]
    @parent[i] = k
end

def union(i, j)
    ii = find(i)
    jj = find(j)
    expected = 1 ^ @parity[i] ^ @parity[j]

    if ii == jj
        return 0 if expected != 0
    end
    

    ii, jj = jj, ii if -@parent[ii] < -@parent[jj]
    @parent[ii] += @parent[jj]
    @parent[jj] = ii
    @parity[jj] = expected
    return 1
end

n, m = gets.split.map!(&:to_i)
graph = []
edges = []
n.times { graph << [] }
(m).times do |i|
    edges << gets.split.map(&:to_i).map!(&:pred)
    graph[edges[i][0]] << edges[i][1]
    graph[edges[i][1]] << edges[i][0]
end
pp graph
pp edges
##########

@parent = Array.new(n, -1)
@parity = Array.new(n, 0)  # relative to @parent[i]
ans = 0
edges.each do |i, j|
    union(i, j)
end
aparent = []
@parent.each do |i|
    aparent << i.dup
end
aparity = []
@parity.each do |i|
    aparity << i.dup
end
n.times do |i|
    ss = graph[i].sort
    n.times do |j|
        next if i == j
        if ss.first == j
            ss.shift
            next
        end
        pp i
        pp j
        ans += union(i, j)
        pp @parent
        pp @parent = aparent.dup
        @parity = aparity.dup
    end
    
end
# n.times { |k| find(k) }  # fix @parity: relative to find(i)
puts ans
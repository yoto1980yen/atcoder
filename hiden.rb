input = gets.chomp

input = gets.split

n = gets.to_i

a = gets.split.map(&:to_i)

# 使う範囲を[]で指定できる
a = gets.split.map(&:to_i)[1...]

X.times do 
    input += gets.split
end

# nまで繰り返し
(0...n).each do |i|

end

# 無限ループ
while true
    
end

#木構造の配列
n = gets.to_i
a = gets.split.map(&:to_i)
list = []
n.times do
    list << []
end
(n - 1).times do |i|
    now = gets.split.map(&:to_i)
    list[now[0]] << now[1]
    # 両方向いけるなら追加
    # 一方通行ならなし
    list[now[1]] << now[0]
end
# A to Z
atoz = ('A'..'Z').to_a

# 奇数判定
def kisu(i)
    if i & 1 == 1
        return true
    end
    return false
end

# 素数判定
require "prime"
Prime.prime?(i)

# 素因数分解
require 'prime'
12.prime_division #=> [[2,2], [3,1]]
10.prime_division #=> [[2,1], [5,1]]

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

# 重複を取り除く
ary.uniq

# 先頭に要素を追加
ary.unshift

# 先頭の要素を削除
ary.shift

# 末尾の要素を削除
ary.pop

# 末尾に要素追加
ary.push
# sort
ary.sort
ary.sort.reverse
# インデックス付きでソート
ary.each_with_index.sort

# 累積和
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
s = Array.new(arr.size + 1)
s[0] = 0
(0...arr.size).each do |i|
    s[i+1] = s[i] + arr[i]
end
# 3~6の合計が欲しい場合
pp s[6] - s[2]

# バイナリサーチ 近くの要素取得(最初に該当するものが返り値となる)
aryr = [1,2,3,4,5,6,7,8,9,10].sort.reverse
ary = [1,2,3,4,5,6,7,8,9,10].sort
aryr.bsearch {|x| x < 5 }

# HashのKeyがあるかValueがあるか？
p({1 => "one"}.key?(1)) # => true
p({1 => "one"}.key?(2)) # => false
p({1 => "one"}.value?("one")) #=> true
p({1 => "one"}.value?("two")) #=> false

# 配列の要素の数を集計したい
["a", "b", "c", "b"].tally  #=> {"a"=>1, "b"=>2, "c"=>1}

# 配列の列と行を入れ替える(しかし要素のサイズが同じでないとエラーになる)
[[1,2],[3,4],[5,6]].transpose
# => [[1, 3, 5], [2, 4, 6]]

# 配列の作れる組み合わせ
a = [1, 2, 3, 4]
a.combination(1).to_a  #=> [[1],[2],[3],[4]]
a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
a.combination(4).to_a  #=> [[1,2,3,4]]
a.combination(0).to_a  #=> [[]]: one combination of length 0
a.combination(5).to_a  #=> []  : no combinations of length 5

a = [1, 2, 3]
a.permutation.to_a     #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
a.permutation(1).to_a  #=> [[1],[2],[3]]
a.permutation(2).to_a  #=> [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
a.permutation(3).to_a  #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
a.permutation(0).to_a  #=> [[]]: one permutation of length 0
a.permutation(4).to_a

# 優先度付きキュー
def add(n)
    i = @size
    while i > 0 do
        parent_index = (i - 1) / 2
        break if n >= @heap[parent_index]
    
        @heap[i] = @heap[parent_index]
        i = parent_index
    end
    
    @heap[i] = n
    @size += 1
end

def pop
    return if @size <= 0
    min_n = @heap[0]
    @size -= 1
    n = @heap[@size]
    i = 0
    while i * 2 + 1 < @size do
        child_index1 = i * 2 + 1
        child_index2 = i * 2 + 2
        if child_index2 < @size && @heap[child_index2] < @heap[child_index1]
        child_index1 = child_index2
        end
        break if @heap[child_index1] >= n
    
        @heap[i] = @heap[child_index1]
        i = child_index1
    end
    @heap[i] = n
    min_n
end

def min; @heap[0] end
def values; @heap.first(@size) end
def inspect; "Heap: #{values}" end
n, k = gets.split.map(&:to_i)
@heap = gets.split.map(&:to_i)
@size = n
# 順番気にしなくていいならSet使え
require 'set'
p Set.new
p Set.new([1, 2])  
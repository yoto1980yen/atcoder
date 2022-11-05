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



# 配列の作れる組み合わせ
a = [1, 2, 3, 4]
a.combination(1).to_a  #=> [[1],[2],[3],[4]]
a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
a.combination(4).to_a  #=> [[1,2,3,4]]
a.combination(0).to_a  #=> [[]]: one combination of length 0
a.combination(5).to_a  #=> []  : no combinations of length 5
# tips
# 順番気にしなくていいならSet使え
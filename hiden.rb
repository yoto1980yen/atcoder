input = gets.chomp

input = gets.split

input = gets.to_i

input = gets.split.map(&:to_i)

X.times do 
    input += gets.split
end

# nまで繰り返し
(0...n).each do |i|

end

# 無限ループ
while true
    
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
ary.uniq()

# 先頭の要素を追加
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
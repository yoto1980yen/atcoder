input = gets.chomp.split("")
counts = Hash.new(0)                             # ハッシュを生成
input.each { |v| counts[v] += 1 }                  # 重複している要素を検索
i = counts.select { |v, count| count == 1 }.keys
if i.empty?   
    puts "-1"
else
    puts i.first
end

n = gets.to_i
a = gets.split.map(&:to_i)
inde = []
(1...a.size).each do |i|
    if a[i - 1] > a[i]
        inde << 0
    else
        inde << 1
    end
end
aa = []
answers = []
ans = format("%0#{n - 1}d", (inde.join("").to_i(2) + 1).to_s(2)).split("").map(&:to_i)
(0...(n - 1)).each do |i|
    if inde[i] != ans[i]
        aa = a[i..-1]
        ans = ans[i..-1]
        break
    end
    answers << a[i]
end
kensakur = aa.sort.reverse
kensaku = aa.sort
(0...aa.size).each do |i|
    now = ans[i]
    if i == 0
        if now == 1
            answers << kensakur.bsearch {|x| x < aa[i] }
            kensakur.delete(answers.last)
            kensaku.delete(answers.last)
        else
            answers << kensaku.bsearch {|x| x > aa[i] }
            kensakur.delete(answers.last)
            kensaku.delete(answers.last)
        end
    else 
        if now == 1
            answers << kensaku.shift
        else
            answers << kensaku.pop
        end
    end
end
puts answers.join(" ")
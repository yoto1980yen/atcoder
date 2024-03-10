a, b = gets.split.map(&:to_i)
ans = b.to_f / a.to_f
puts sprintf("%.3f",ans.round(3))
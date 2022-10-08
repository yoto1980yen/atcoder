n = gets.to_i
a = gets.split.map(&:to_i).sort.reverse
if a[0].even? && a[1].even?
    puts a[0] + a[1]
    return
elsif a[0].even? == false && a[1].even? == false
    puts a[0] + a[1]
    return
end
gusu = [] 
kisu = []
(0...n).each do |i|
    if a[i].even?
        gusu << a[i]
    else
        kisu << a[i]
    end
    if gusu.size >= 2 && kisu.size >= 2
        ans1 = gusu[0] + gusu[1]
        ans2 = kisu[0] + kisu[1]
        if ans1 >= ans2
            puts ans1
            return
        else
            puts ans2
            return
        end
    end
end
if gusu.size >= 2
    puts gusu[0] + gusu[1]
elsif kisu.size >= 2
    kisu[0] + kisu[1]
else
    puts -1
end
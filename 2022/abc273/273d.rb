# やろうとしたけど時間的に無理そうなので断念
h, w, nowr, nowc = gets.split.map(&:to_i)
n = gets.to_i
kabe = []
n.times do 
    kabe << gets.split.map(&:to_i)
end
q = gets.to_i
siji = []
q.times do 
    siji << gets.split.map(&:to_i)
end
pp kabe.sort
(0...q).each do |i|
    nowsiji = siji.shift
    muki = nowsiji[0]
    kyori = nowsiji[1]
    gotolist = []
    if muki == "L"
        (0...kyori).each do |j|
            # kabe.include?
        end
    elsif muki == "R"

    elsif muki == "U"

    elsif muki == "D"

    end
end
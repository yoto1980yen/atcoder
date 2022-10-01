a, b = gets.split.map(&:to_i)
if a == 1 
    if b == 6 || b == 7
        pp 7
    elsif b == 2 || b == 3
        pp 3
    elsif b == 4 || b == 5
        pp 5
    else
        pp 1
    end
end
if a == 2
    if b == 1 || b == 3
        pp 3
    end
    if b == 5 || b == 7
        pp 7
    end
    if b == 4 || b == 6
        pp 6
    end
    if b == 2
        pp 2
    end
end
if a == 3
    if b >= 4
        pp 7
    else
        pp 3
    end
end
if a == 4
    if b == 1 || b == 5
        pp 5
    end
    if b == 2 || b == 6
        pp 6
    end
    if b == 3 || b == 7
        pp 7
    end
    if b == 4
        pp 4
    end
end
if a == 5
    if b == 2 || b == 6 || b == 3
        pp 7
    else
        pp 5
    end
end
if a == 6
    if b == 1 || b == 5 || b == 3
        pp 7
    else
        pp 6
    end
end
if a == 7
    pp 7
end
if a == 0
    pp b
elsif b == 0
    pp a
end
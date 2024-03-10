input = gets.split.map(&:to_i)
n = input[0]
x = input[1]
y = input[2]
bluee = 0
def red(n, x, y, bluee)
    return 0 if n == 1
    (0...x + 1).each do |i|
        red(n-1, x, y, bluee)
    end
    (0...x).each do |i|
        bluee += blue(n-1, y, x, bluee)
    end
    return bluee
end
def blue(n, y, x, bluee)
    return y if n == 1
    (0...x * y).each do |i|
        red(n-1, x, y, bluee)
    end
    return (n - 1) * y *x
end
pp red(n, x, y, bluee)
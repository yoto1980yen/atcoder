def saiki(list)
    list[1].times do
        $list << list[0] / 2
        $list << list[0] / 3
    end
    $list = $list.group_by(&:itself).map{ |key, value| [key, value.count] }
end
n = gets.to_i
$list = []
# saiki(n)
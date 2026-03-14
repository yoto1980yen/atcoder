def int
  gets.to_i
end

def intary
  gets.split.map!(&:to_i)
end

def make_map(n)
  a = Array.new(n)
  n.times { |i| a[i] = intary }
  a
end

def adjacent8?(p1, p2)
  [(p1[0] - p2[0]).abs, (p1[1] - p2[1]).abs].max == 1
end

def score_path(path, a)
  sc = 0
  path.each_with_index do |(i, j), day|
    sc += day * a[i][j]
  end
  sc
end

def valid_path?(path, n)
  return false unless path.size == n * n
  used = Array.new(n) { Array.new(n, false) }
  path.each_with_index do |(i, j), idx|
    return false if i < 0 || i >= n || j < 0 || j >= n || used[i][j]
    used[i][j] = true
    next if idx == 0
    return false unless adjacent8?(path[idx - 1], path[idx])
  end
  true
end

def snake_path(n)
  path = []
  (0...n).each do |i|
    if i.even?
      (0...n).each { |j| path << [i, j] }
    else
      (0...n).to_a.reverse_each { |j| path << [i, j] }
    end
  end
  path
end

def build_requested_path(n, a)
  return { ok: false, path: [], reason: "n is odd" } if n.odd?

  path = []
  used = Array.new(n) { Array.new(n, false) }
  row_choice = Array.new(n / 2) { Array.new(n, nil) }

  append_cell = lambda do |i, j|
    return false if i < 0 || i >= n || j < 0 || j >= n
    return false if used[i][j]
    if !path.empty?
      return false unless adjacent8?(path[-1], [i, j])
    end
    used[i][j] = true
    path << [i, j]
    true
  end

  pair_count = n / 2
  pair_count.times do |k|
    r0 = 2 * k
    r1 = r0 + 1
    left_to_right = k.even?
    cols = left_to_right ? (1..(n - 2)).to_a : (1..(n - 2)).to_a.reverse
    one_before_edge = left_to_right ? (n - 2) : 1

    cols.each_with_index do |c, idx|
      row = if idx == 0
        r0
      elsif c == one_before_edge
        r1
      else
        a[r0][c] <= a[r1][c] ? r0 : r1
      end
      row_choice[k][c] = row

      if idx == 0 && !path.empty? && path[-1] == [row, c]
        next
      end

      unless append_cell.call(row, c)
        return { ok: false, path: path, reason: "failed to append phase1 cell (#{row},#{c})" }
      end
    end

    edge_col = cols[-1]
    if path[-1] != [r1, edge_col]
      unless append_cell.call(r1, edge_col)
        return { ok: false, path: path, reason: "failed to move to lower row at edge col #{edge_col}" }
      end
    end

    if k + 1 < pair_count
      unless append_cell.call(r0 + 2, edge_col)
        return { ok: false, path: path, reason: "failed to descend to next 2-row band" }
      end
    end
  end

  # フェーズ2: 端列を使って下から上へ、未訪問の相方マスを確実に回収
  if path[-1] != [n - 1, 0]
    unless append_cell.call(n - 1, 0)
      return { ok: false, path: path, reason: "failed to move to left edge for return phase" }
    end
  end

  (n / 2 - 1).downto(0) do |k|
    r0 = 2 * k
    r1 = r0 + 1
    dir_lr = k.odd?

    if dir_lr
      # start at [r1,0]
      if path[-1] != [r1, 0]
        unless append_cell.call(r1, 0)
          return { ok: false, path: path, reason: "cannot align to [#{r1},0] in return phase" }
        end
      end

      if !used[r0][0]
        unless append_cell.call(r0, 0)
          return { ok: false, path: path, reason: "failed to enter upper cell on left edge" }
        end
      end

      (1..(n - 2)).each do |c|
        vrow = row_choice[k][c]
        next if vrow.nil?
        trow = (vrow == r0 ? r1 : r0)
        unless append_cell.call(trow, c)
          return { ok: false, path: path, reason: "failed to collect counterpart at (#{trow},#{c})" }
        end
      end

      need_r1 = !used[r1][n - 1]
      need_r0 = !used[r0][n - 1]
      if need_r1 || need_r0
        ok = false
        # 順序1: r1 -> r0
        saved = [path.dup, Marshal.load(Marshal.dump(used))]
        ok1 = true
        if need_r1
          ok1 &&= append_cell.call(r1, n - 1)
        end
        if need_r0
          ok1 &&= append_cell.call(r0, n - 1)
        end
        if ok1
          ok = true
        else
          path.replace(saved[0])
          used = saved[1]
          # 順序2: r0 -> r1 -> r0(必要なら)
          ok2 = true
          if need_r0
            ok2 &&= append_cell.call(r0, n - 1)
          end
          if need_r1
            ok2 &&= append_cell.call(r1, n - 1)
          end
          if need_r0 && path[-1] != [r0, n - 1]
            ok2 &&= append_cell.call(r0, n - 1)
          end
          ok = ok2
        end
        unless ok
          return { ok: false, path: path, reason: "failed to settle on right edge cells" }
        end
      end

      if k > 0
        unless append_cell.call(r0 - 1, n - 1)
          return { ok: false, path: path, reason: "failed to move up on right edge" }
        end
      end
    else
      # start at [r1,n-1]
      if path[-1] != [r1, n - 1]
        unless append_cell.call(r1, n - 1)
          return { ok: false, path: path, reason: "cannot align to [#{r1},#{n - 1}] in return phase" }
        end
      end

      if !used[r0][n - 1]
        unless append_cell.call(r0, n - 1)
          return { ok: false, path: path, reason: "failed to enter upper cell on right edge" }
        end
      end

      (n - 2).downto(1) do |c|
        vrow = row_choice[k][c]
        next if vrow.nil?
        trow = (vrow == r0 ? r1 : r0)
        unless append_cell.call(trow, c)
          return { ok: false, path: path, reason: "failed to collect counterpart at (#{trow},#{c})" }
        end
      end

      need_r1 = !used[r1][0]
      need_r0 = !used[r0][0]
      if need_r1 || need_r0
        ok = false
        saved = [path.dup, Marshal.load(Marshal.dump(used))]
        ok1 = true
        if need_r1
          ok1 &&= append_cell.call(r1, 0)
        end
        if need_r0
          ok1 &&= append_cell.call(r0, 0)
        end
        if ok1
          ok = true
        else
          path.replace(saved[0])
          used = saved[1]
          ok2 = true
          if need_r0
            ok2 &&= append_cell.call(r0, 0)
          end
          if need_r1
            ok2 &&= append_cell.call(r1, 0)
          end
          if need_r0 && path[-1] != [r0, 0]
            ok2 &&= append_cell.call(r0, 0)
          end
          ok = ok2
        end
        unless ok
          return { ok: false, path: path, reason: "failed to settle on left edge cells" }
        end
      end

      if k > 0
        unless append_cell.call(r0 - 1, 0)
          return { ok: false, path: path, reason: "failed to move up on left edge" }
        end
      end
    end
  end

  return { ok: false, path: path, reason: "final path invalid" } unless valid_path?(path, n)
  { ok: true, path: path, reason: nil }
end

def main
  n = int
  a = make_map(n)

  result = build_requested_path(n, a)
  if result[:ok]
    result[:path].each { |i, j| puts "#{i} #{j}" }
    return
  end

  result[:path].each { |i, j| puts "#{i} #{j}" }
  warn "build_requested_path failed: #{result[:reason]}"
  warn "visited cells: #{result[:path].size} / #{n * n}"
  exit 1
end

main

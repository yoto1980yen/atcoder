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
  di = (p1[0] - p2[0]).abs
  dj = (p1[1] - p2[1]).abs
  di <= 1 && dj <= 1 && (di + dj > 0)
end

def adjacent_diag?(p1, p2)
  (p1[0] - p2[0]).abs == 1 && (p1[1] - p2[1]).abs == 1
end

def path_score(path, a)
  sc = 0
  path.each_with_index do |(i, j), day|
    sc += day * a[i][j]
  end
  sc
end

def valid_full_path?(path, n)
  return false unless path.size == n * n
  used = Array.new(n) { Array.new(n, false) }
  path.each_with_index do |(i, j), idx|
    return false if i < 0 || i >= n || j < 0 || j >= n || used[i][j]
    used[i][j] = true
    next if idx == 0
    pi, pj = path[idx - 1]
    return false unless [(pi - i).abs, (pj - j).abs].max == 1
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

def build_parity_diag_path_candidates(n, a, parity, day_base, high_cut, penalty_weight)
  pair_count = n / 2

  cols_for_row = ->(row, p) {
    start = ((p - row) & 1)
    cols = []
    j = start
    while j < n
      cols << j
      j += 2
    end
    cols
  }

  rows_for_col = ->(col, p) {
    start = ((p - col) & 1)
    rows = []
    i = start
    while i < n
      rows << i
      i += 2
    end
    rows
  }

  build_from_segments = ->(segments) {
    lengths = Array.new(pair_count, n)
    pref = Array.new(pair_count + 1, 0)
    lengths.each_with_index { |len, i| pref[i + 1] = pref[i] + len }
    m = pair_count

    eval_seg = ->(cells, start_day) {
      sc = 0.0
      cells.each_with_index do |(i, j), t|
        day = start_day + t
        v = a[i][j]
        gain = day * v
        penalty = 0.0
        if penalty_weight > 0.0 && day < (n * n) / 2 && v > high_cut
          penalty = penalty_weight * ((n * n) / 2 - day) * (v - high_cut)
        end
        sc += gain - penalty
      end
      sc
    }

    pattern0 = Array.new(m) { |k| k & 1 }
    pattern1 = Array.new(m) { |k| 1 - (k & 1) }

    eval_pattern = ->(pat) {
      sc = 0.0
      m.times do |k|
        sc += eval_seg.call(segments[k][pat[k]], day_base + pref[k])
      end
      sc
    }

    build_path = ->(choice) {
      path = []
      m.times do |k|
        segments[k][choice[k]].each { |p| path << p }
      end
      (1...path.size).each do |kk|
        return nil unless adjacent_diag?(path[kk - 1], path[kk])
      end
      path
    }

    out = []
    p0 = build_path.call(pattern0)
    p1 = build_path.call(pattern1)
    out << [eval_pattern.call(pattern0), p0] unless p0.nil?
    out << [eval_pattern.call(pattern1), p1] unless p1.nil?
    out
  }

  row_segments = Array.new(pair_count) { Array.new(2) }
  pair_count.times do |k|
    r0 = 2 * k
    r1 = r0 + 1
    c0 = cols_for_row.call(r0, parity)
    c1 = cols_for_row.call(r1, parity)
    top_first = ((r0 & 1) == parity)

    seg0 = []
    (0...(n / 2)).each do |t|
      if top_first
        seg0 << [r0, c0[t]]
        seg0 << [r1, c1[t]]
      else
        seg0 << [r1, c1[t]]
        seg0 << [r0, c0[t]]
      end
    end
    seg1 = []
    (0...(n / 2)).to_a.reverse_each do |t|
      if top_first
        seg1 << [r0, c0[t]]
        seg1 << [r1, c1[t]]
      else
        seg1 << [r1, c1[t]]
        seg1 << [r0, c0[t]]
      end
    end
    row_segments[k][0] = seg0
    row_segments[k][1] = seg1
  end

  col_segments = Array.new(pair_count) { Array.new(2) }
  pair_count.times do |k|
    c0 = 2 * k
    c1 = c0 + 1
    r0 = rows_for_col.call(c0, parity)
    r1 = rows_for_col.call(c1, parity)
    left_first = ((c0 & 1) == parity)

    seg0 = []
    (0...(n / 2)).each do |t|
      if left_first
        seg0 << [r0[t], c0]
        seg0 << [r1[t], c1]
      else
        seg0 << [r1[t], c1]
        seg0 << [r0[t], c0]
      end
    end
    seg1 = []
    (0...(n / 2)).to_a.reverse_each do |t|
      if left_first
        seg1 << [r0[t], c0]
        seg1 << [r1[t], c1]
      else
        seg1 << [r1[t], c1]
        seg1 << [r0[t], c0]
      end
    end
    col_segments[k][0] = seg0
    col_segments[k][1] = seg1
  end

  cand = []
  cand.concat(build_from_segments.call(row_segments))
  cand.concat(build_from_segments.call(col_segments))
  cand.sort_by! { |x| -x[0] }
  cand.map { |x| x[1] }.uniq
end

def main
  n = int
  a = make_map(n)

  # 高人口しきい値（上位30%）
  vals = a.flatten.sort
  idx = (vals.size * 0.70).to_i
  idx = vals.size - 1 if idx >= vals.size
  high_cut = vals[idx]

  # 前半フェーズは高人口を強く避ける
  strong_penalty = 0.22
  weak_penalty = 0.02

  p0_list = build_parity_diag_path_candidates(n, a, 0, 0, high_cut, strong_penalty)
  p1_list = build_parity_diag_path_candidates(n, a, 1, 0, high_cut, strong_penalty)

  if p0_list.empty? || p1_list.empty?
    ans = snake_path(n)
    rev = ans.reverse
    ans = rev if path_score(rev, a) > path_score(ans, a)
    ans.each { |i, j| puts "#{i} #{j}" }
    return
  end

  p0 = p0_list[0]
  p1 = p1_list[0]

  avg0 = p0.sum { |i, j| a[i][j] }
  avg1 = p1.sum { |i, j| a[i][j] }

  low_parity = avg0 <= avg1 ? 0 : 1
  high_parity = 1 - low_parity

  first_list = build_parity_diag_path_candidates(n, a, low_parity, 0, high_cut, strong_penalty)
  second_list = build_parity_diag_path_candidates(n, a, high_parity, n * n / 2, high_cut, weak_penalty)

  if first_list.empty? || second_list.empty?
    ans = snake_path(n)
    rev = ans.reverse
    ans = rev if path_score(rev, a) > path_score(ans, a)
    ans.each { |i, j| puts "#{i} #{j}" }
    return
  end

  candidates = []
  first_list.each do |bf|
    [bf, bf.reverse].each do |f|
      second_list.each do |bs|
        [bs, bs.reverse].each do |s|
          next unless adjacent8?(f[-1], s[0])
          candidates << (f + s)
        end
      end
    end
  end

  if candidates.empty?
    # 接続不能ならフェーズ順を逆にして試す
    first2_list = build_parity_diag_path_candidates(n, a, high_parity, 0, high_cut, strong_penalty)
    second2_list = build_parity_diag_path_candidates(n, a, low_parity, n * n / 2, high_cut, weak_penalty)
    first2_list.each do |bf|
      [bf, bf.reverse].each do |f|
        second2_list.each do |bs|
          [bs, bs.reverse].each do |s|
            next unless adjacent8?(f[-1], s[0])
            candidates << (f + s)
          end
        end
      end
    end
  end

  best = nil
  best_sc = -1 << 60
  candidates.each do |cand|
    next unless valid_full_path?(cand, n)
    sc = path_score(cand, a)
    if best.nil? || sc > best_sc
      best_sc = sc
      best = cand
    end
  end

  if best.nil?
    ans = snake_path(n)
    rev = ans.reverse
    ans = rev if path_score(rev, a) > path_score(ans, a)
    ans.each { |i, j| puts "#{i} #{j}" }
    return
  end

  best.each { |i, j| puts "#{i} #{j}" }
end

main

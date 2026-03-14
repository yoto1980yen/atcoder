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

def main
  n = int
  a = make_map(n)

  score_path = ->(path) {
    sc = 0
    path.each_with_index { |(i, j), day| sc += day * a[i][j] }
    sc
  }

  snake_path = -> {
    path = []
    (0...n).each do |i|
      if i.even?
        (0...n).each { |j| path << [i, j] }
      else
        (0...n).to_a.reverse_each { |j| path << [i, j] }
      end
    end
    path
  }

  b = (n % 4 == 0) ? 4 : 1
  if b != 4
    ans = snake_path.call
    rev = ans.reverse
    ans = rev if score_path.call(rev) > score_path.call(ans)
    ans.each { |i, j| puts "#{i} #{j}" }
    return
  end

  bh = n / b
  bw = n / b
  cells = b * b
  to_id = ->(r, c) { r * b + c }
  id_r = ->(id) { id / b }
  id_c = ->(id) { id % b }

  neigh = Array.new(cells) { [] }
  (0...b).each do |r|
    (0...b).each do |c|
      id = to_id.call(r, c)
      (-1..1).each do |dr|
        (-1..1).each do |dc|
          next if dr == 0 && dc == 0
          nr = r + dr
          nc = c + dc
          next if nr < 0 || nr >= b || nc < 0 || nc >= b
          neigh[id] << to_id.call(nr, nc)
        end
      end
    end
  end

  side_ids = {
    up:    (0...b).map { |c| to_id.call(0, c) },
    down:  (0...b).map { |c| to_id.call(b - 1, c) },
    left:  (0...b).map { |r| to_id.call(r, 0) },
    right: (0...b).map { |r| to_id.call(r, b - 1) }
  }
  boundary_ids = []
  (0...cells).each do |id|
    r = id_r.call(id)
    c = id_c.call(id)
    boundary_ids << id if r == 0 || r == b - 1 || c == 0 || c == b - 1
  end

  move_to_side = {
    [-1, 0] => :up,
    [1, 0] => :down,
    [0, -1] => :left,
    [0, 1] => :right
  }
  opposite = {
    up: :down,
    down: :up,
    left: :right,
    right: :left
  }

  block_sum = Array.new(bh) { Array.new(bw, 0) }
  block_vals = Array.new(bh) { Array.new(bw) }
  (0...bh).each do |br|
    (0...bw).each do |bc|
      vals = Array.new(cells, 0)
      total = 0
      (0...b).each do |lr|
        (0...b).each do |lc|
          v = a[br * b + lr][bc * b + lc]
          vals[to_id.call(lr, lc)] = v
          total += v
        end
      end
      block_sum[br][bc] = total
      block_vals[br][bc] = vals
    end
  end

  local_internal_score = ->(id_path, vals) {
    sc = 0
    id_path.each_with_index { |id, t| sc += t * vals[id] }
    sc
  }

  full_mask = (1 << cells) - 1
  path_cache = {}
  find_local_path = ->(s_id, e_id, reverse_order) {
    key = [s_id, e_id, reverse_order]
    return path_cache[key] if path_cache.key?(key)
    return nil if s_id == e_id

    used = Array.new(cells, false)
    used[s_id] = true
    path = [s_id]
    dead = {}
    found = false

    dfs = nil
    dfs = ->(cur, mask, depth) {
      if mask == full_mask
        return cur == e_id
      end

      state = (mask << 5) | cur
      return false if dead[state]

      cand = neigh[cur].select { |nid| !used[nid] }
      if depth == cells - 1
        return false unless !used[e_id] && cand.include?(e_id)
        cand = [e_id]
      else
        cand.sort_by! { |nid| neigh[nid].count { |nn| !used[nn] } }
        cand.reverse! if reverse_order
      end

      cand.each do |nid|
        used[nid] = true
        path << nid
        if dfs.call(nid, mask | (1 << nid), depth + 1)
          found = true
          return true
        end
        path.pop
        used[nid] = false
      end

      dead[state] = true
      false
    }

    dfs.call(s_id, 1 << s_id, 1)
    path_cache[key] = found ? path.dup : nil
  }

  local_paths = {}
  boundary_ids.each do |s_id|
    boundary_ids.each do |e_id|
      next if s_id == e_id
      p1 = find_local_path.call(s_id, e_id, false)
      p2 = find_local_path.call(s_id, e_id, true)
      ary = []
      ary << p1 if !p1.nil?
      ary << p2 if !p2.nil? && (p1.nil? || p1 != p2)
      local_paths[[s_id, e_id]] = ary
    end
  end

  block_order_score = ->(order) {
    sc = 0
    order.each_with_index { |(br, bc), t| sc += t * block_sum[br][bc] }
    sc
  }

  block_adj4 = ->(p1, p2) {
    (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs == 1
  }

  make_row_snake = ->(reverse_rows) {
    order = []
    rows = reverse_rows ? (0...bh).to_a.reverse : (0...bh).to_a
    rows.each_with_index do |br, idx|
      if idx.even?
        (0...bw).each { |bc| order << [br, bc] }
      else
        (0...bw).to_a.reverse_each { |bc| order << [br, bc] }
      end
    end
    order
  }

  make_col_snake = ->(reverse_cols) {
    order = []
    cols = reverse_cols ? (0...bw).to_a.reverse : (0...bw).to_a
    cols.each_with_index do |bc, idx|
      if idx.even?
        (0...bh).each { |br| order << [br, bc] }
      else
        (0...bh).to_a.reverse_each { |br| order << [br, bc] }
      end
    end
    order
  }

  optimize_block_order = ->(seed_order, iter) {
    ord = seed_order.dup
    cur = block_order_score.call(ord)
    m = ord.size

    iter.times do |it|
      temp = 2500.0 * (1.0 - it.to_f / iter) + 1.0
      if rand < 0.55
        i = rand(1...(m - 2))
        a0 = ord[i - 1]
        b0 = ord[i]
        c0 = ord[i + 1]
        d0 = ord[i + 2]
        next unless block_adj4.call(a0, c0)
        next unless block_adj4.call(b0, d0)

        wb = block_sum[b0[0]][b0[1]]
        wc = block_sum[c0[0]][c0[1]]
        delta = i * wc + (i + 1) * wb - (i * wb + (i + 1) * wc)

        if delta >= 0 || rand < Math.exp(delta / temp)
          ord[i], ord[i + 1] = ord[i + 1], ord[i]
          cur += delta
        end
      else
        l = rand(1...(m - 3))
        r = rand((l + 2)..(m - 2))

        a0 = ord[l - 1]
        b0 = ord[l]
        c0 = ord[r]
        d0 = ord[r + 1]
        next unless block_adj4.call(a0, c0)
        next unless block_adj4.call(b0, d0)

        old_seg = 0
        new_seg = 0
        idx = l
        while idx <= r
          br, bc = ord[idx]
          w = block_sum[br][bc]
          old_seg += idx * w
          new_idx = l + r - idx
          new_seg += new_idx * w
          idx += 1
        end
        delta = new_seg - old_seg

        if delta >= 0 || rand < Math.exp(delta / temp)
          ord[l..r] = ord[l..r].reverse
          cur += delta
        end
      end
    end

    ord
  }

  base_orders = [
    make_row_snake.call(false),
    make_row_snake.call(true),
    make_col_snake.call(false),
    make_col_snake.call(true)
  ]

  order_candidates = []
  base_orders.each do |ord|
    order_candidates << ord
    order_candidates << ord.reverse
    opt = optimize_block_order.call(ord, 16_000)
    order_candidates << opt
    order_candidates << opt.reverse
  end

  uniq_orders = {}
  order_candidates.each { |ord| uniq_orders[ord.join("|")] = ord }

  compatible = {}
  [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dbr, dbc|
    comp = Array.new(cells) { Array.new(cells, false) }
    (0...cells).each do |e_id|
      re = id_r.call(e_id)
      ce = id_c.call(e_id)
      (0...cells).each do |s_id|
        rs = id_r.call(s_id) + dbr * b
        cs = id_c.call(s_id) + dbc * b
        comp[e_id][s_id] = [re - rs, ce - cs].map(&:abs).max == 1
      end
    end
    compatible[[dbr, dbc]] = comp
  end

  build_with_dp = ->(order) {
    in_side = Array.new(order.size)
    out_side = Array.new(order.size)

    (0...order.size).each do |k|
      if k > 0
        pbr, pbc = order[k - 1]
        cbr, cbc = order[k]
        mv = [cbr - pbr, cbc - pbc]
        side = move_to_side[mv]
        return nil if side.nil?
        in_side[k] = opposite[side]
      end
      if k + 1 < order.size
        cbr, cbc = order[k]
        nbr, nbc = order[k + 1]
        mv = [nbr - cbr, nbc - cbc]
        side = move_to_side[mv]
        return nil if side.nil?
        out_side[k] = side
      end
    end

    options = Array.new(order.size) { [] }
    order.each_with_index do |(br, bc), k|
      vals = block_vals[br][bc]
      s_ids = in_side[k].nil? ? boundary_ids : side_ids[in_side[k]]
      e_ids = out_side[k].nil? ? boundary_ids : side_ids[out_side[k]]

      s_ids.each do |sid|
        e_ids.each do |eid|
          next if sid == eid
          cands = local_paths[[sid, eid]]
          next if cands.nil? || cands.empty?

          best_path = nil
          best_sc = -1
          cands.each do |id_path|
            sc = local_internal_score.call(id_path, vals)
            if best_path.nil? || sc > best_sc
              best_sc = sc
              best_path = id_path
            end
          end
          options[k] << { s: sid, e: eid, path: best_path, sc: best_sc }
        end
      end
      return nil if options[k].empty?
    end

    dp = Array.new(order.size)
    prev_idx = Array.new(order.size)
    dp[0] = Array.new(options[0].size, -1 << 60)
    prev_idx[0] = Array.new(options[0].size, -1)
    options[0].each_with_index { |op, i| dp[0][i] = op[:sc] }

    (1...order.size).each do |k|
      dbr = order[k][0] - order[k - 1][0]
      dbc = order[k][1] - order[k - 1][1]
      comp = compatible[[dbr, dbc]]
      return nil if comp.nil?

      dp[k] = Array.new(options[k].size, -1 << 60)
      prev_idx[k] = Array.new(options[k].size, -1)

      options[k].each_with_index do |op2, j|
        best = -1 << 60
        best_i = -1
        options[k - 1].each_with_index do |op1, i|
          next unless comp[op1[:e]][op2[:s]]
          cand = dp[k - 1][i] + op2[:sc]
          if cand > best
            best = cand
            best_i = i
          end
        end
        dp[k][j] = best
        prev_idx[k][j] = best_i
      end
    end

    last_k = order.size - 1
    best_last = 0
    options[last_k].each_index do |i|
      best_last = i if dp[last_k][i] > dp[last_k][best_last]
    end
    return nil if dp[last_k][best_last] < (-1 << 50)

    chosen = Array.new(order.size)
    idx = best_last
    last_k.downto(0) do |k|
      chosen[k] = options[k][idx]
      idx = prev_idx[k][idx]
      break if k == 0
    end

    path = []
    order.each_with_index do |(br, bc), k|
      chosen[k][:path].each do |id|
        path << [br * b + id_r.call(id), bc * b + id_c.call(id)]
      end
    end

    used = Array.new(n) { Array.new(n, false) }
    path.each_with_index do |(i, j), t|
      return nil if i < 0 || i >= n || j < 0 || j >= n || used[i][j]
      used[i][j] = true
      next if t == 0
      pi, pj = path[t - 1]
      return nil if [(pi - i).abs, (pj - j).abs].max != 1
    end
    return nil unless path.size == n * n

    path
  }

  best_path = nil
  best_score = -1
  uniq_orders.each_value do |ord|
    path = build_with_dp.call(ord)
    next if path.nil?
    sc = score_path.call(path)
    if best_path.nil? || sc > best_score
      best_score = sc
      best_path = path
    end
  end

  ans = best_path.nil? ? snake_path.call : best_path
  rev = ans.reverse
  ans = rev if score_path.call(rev) > score_path.call(ans)
  ans.each { |i, j| puts "#{i} #{j}" }
end

main

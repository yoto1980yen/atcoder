M, eps = input().split()
M = int(M)
eps = float(eps)
print(20)
for k in range(M):
    l = [random.randrange(0, 2, 1) for i in range(190)]
    n = int("".join(map(str, l)))
    print(n)

for q in range(100):
    H = input()
    t = min(H.count('1'), M - 1)
    print(t)
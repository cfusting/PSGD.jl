# Dummy case test.
@everywhere using PSGD, Base.Test

x = linspace(1, 100, 100000)
y = linspace(100, 200, 100000)

res = psgd(.0002, 200, x, y, lineargradient)

@test_approx_eq_eps res[1] 98.9898 .0001
@test_approx_eq_eps res[2] 1.0101 .0001

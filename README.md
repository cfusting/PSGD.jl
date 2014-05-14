# Parallel Stochastic Gradient Descent

A Parallel version of Stochastic Gradient Descent as detailed in: [Parallelized Stochastic Gradient Descent](http://www.research.rutgers.edu/~lihong/pub/Zinkevich11Parallelized.pdf) .

Takes advantage of all available cores locally and on remote servers.

Example usage (linear regression):

```julia
everywhere using PSGD, Base.Test

x = linspace(1, 100, 100000)
y = linspace(100, 200, 100000)

res = psgd(.0002, 200, x, y, lineargradient)

```

[![Build Status](https://travis-ci.org/cfusting/PSGD.jl.png)](https://travis-ci.org/cfusting/PSGD.jl)

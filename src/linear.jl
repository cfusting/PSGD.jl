function linear_gradient(theta::Array{Float64}, x::Float64, y::Float64, yhat::Float64)
    return ((yhat - y) * x)
end

function linear_hyp(theta::Array{Float64}, x::Array{Float64})
  j = length(x)
  hyp = 0.0
  for i = 1:j
    hyp += theta[i] * x[i]
  end
  return hyp
end

function cost(hyp::Float64, y::Float64)
  return (hyp - y)^2 / 2
end

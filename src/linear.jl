# Compute the stochastic hypothesis of a linear function.
function linear_hyp(theta::Array{Float64}, x::Array{Float64})
  hyp = 0.0
  for i = 1:length(x)
    hyp += theta[i] * x[i]
  end
  return hyp
end

# Compute the stochastic gradient of a linear function.
function lineargradient(theta::Array{Float64}, x::Array{Float64}, y::Float64)
    tmptheta = zeros(Float64, length(theta))
    for i = 1:length(theta)
        tmptheta[i] = ((linear_hyp(theta, x) - y) * x[i])
    end
    return tmptheta
end 

# Stochastic cost function
function stochasticcost(theta::Array{Float64}, x::Array{Float64}, y::Float64)
    return (linear_hyp(theta, x) - y)^2 / 2
end



function linear_hyp(theta::Array{Float64}, x::Array{Float64})
  hyp = 0.0
  for i = 1:length(x)
    hyp += theta[i] * x[i]
  end
  return hyp
end

function lineargradient(theta::Array{Float64}, x::Array{Float64}, y::Float64)
    tmptheta = zeros(Float64, length(theta))
    for i = 1:length(theta)
        tmptheta[i] = ((linear_hyp(theta, x) - y) * x[i])
    end
    return tmptheta
end 

function cost(hyp::Float64, y::Float64)
    return (hyp - y)^2 / 2
end



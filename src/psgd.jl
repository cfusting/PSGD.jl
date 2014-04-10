function psgd(a::Float64, passes::Int64, x::Array{Float64}, y::Array{Float64}, gradient::Function, hyp::Function)
    x = [ones(size(x)[1]) x]
    k = nworkers()
    sgdworkers = Array(Any, k)
    sgdtheta = Array(Any, k)
    dat = [x y]
    shuffle!(dat)
    xslices = part(dat[1:end, 1:ncols(dat) - 1], k)
    yslices = part(dat[1:end, ncols(dat)], k)
    theta = zeros(Float64, ncols(x))
    for i = 1:k  
        println("Starting process")
        sgdworkers[i] = @spawn sgd(a, passes, xslices[i], yslices[i], gradient, hyp)
    end
    for i = 1:k
        println("Fetching Results")
        sgdtheta[i] = fetch(sgdworkers[i])
    end
    println(sgdtheta)
    for i = 1:k
        theta += sgdtheta[i]
    end 
    println(sgdtheta)
    return theta / k
end

function sgd(a::Float64, passes::Int64, x::Array{Float64}, y::Array{Float64}, gradient::Function, hyp::Function)
    if ndims(x) == 1
        theta = zeros(Float64, 1)
    else
        theta = zeros(Float64, size(x)[2])
    end
    seq = shuffle([ 1:size(x)[1] ])
    for p = 1:passes
        for i in seq
            theta = sgd_update(a, theta, x[i, 1:end], y[i], gradient, hyp)
        end
    end
    return theta
end

function ncols(x)
    if ndims(x) == 1
        return 1
    else
        return size(x)[2]
    end
end

function sgd_update(a::Float64, theta::Array{Float64}, x::Array{Float64}, y::Float64, gradient::Function, hyp::Function)
    j = length(theta)
    tmptheta = zeros(Float64, j)
    yhat = hyp(theta, x)
    for i = 1:j
        tmptheta[i] = theta[i] - (a * gradient(theta, x[i], y, yhat))
    end
  return tmptheta
end

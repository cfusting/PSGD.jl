# Parallel Stochastic Gradient Descent
# Shuffle data, divide into k groups (k = procs available) and compute Stochastic Gradient Descent on remote processes.
# Gather results and compute the average.  Solution will be optimal.
# This function determines procs available using nworkers().
function psgd(a::Float64, passes::Int64, x::Array{Float64}, y::Array{Float64}, gradient::Function)
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
        sgdworkers[i] = @spawn sgd(a, passes, xslices[i], yslices[i], gradient)
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

# Stochastic Gradient Descent - find the minumim of a function.
function sgd(a::Float64, passes::Int64, x::Array{Float64}, y::Array{Float64}, gradient::Function)
    if ndims(x) == 1
        theta = zeros(Float64, 1)
    else
        theta = zeros(Float64, size(x)[2])
    end
    seq = shuffle([ 1:size(x)[1] ])
    for p = 1:passes
        for i in seq
            theta = theta - (a * gradient(theta, x[i, 1:end], y[i]))
        end
    end
    return theta
end

# Get the number of "columns"
function ncols(x)
    if ndims(x) == 1
        return 1
    else
        return size(x)[2]
    end
end



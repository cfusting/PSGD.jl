# Divide up the data into k groups
# TODO optimize this.. 
# Column wise copy and pre-allocate the returned array
function part(d::Array{Float64}, k)
    m = size(d)[1]
    if k > m || k <= 0
        error("Groups must be smaller than rows")
    end
    step = int(floor(m / k))
    lw = 1
    up = step
    res = Array(Array{Float64}, k)
    i = 1
    for i = 1:k
        res[i] = d[lw:up, 1:end]
        lw += step
        up += step
    end
    res[k] = vcat(res[k], d[lw:m, 1:end])
    return res
end

# Randomly shuffle a Matrix
function shuffle!(x::Matrix)
    n = size(x)[1]
    for i = 1:n
        j = rand(i:n)
        x[i, 1:end], x[j, 1:end] = x[j, 1:end], x[i, 1:end]
    end
    return x
end

# Get the number of "columns"
function ncols(x)
    if ndims(x) == 1
        return 1
    else
        return size(x)[2]
    end
end



using Plots; pythonplot()
a = exp(im*(1+sqrt(5))/2)
R = 4
maxIter = 1000
xMin = -1.5
xMax = 1.5
yMin = -2
yMax = 1
step = 0.01
xNum = length(xMin:step:xMax)
yNum = length(yMin:step:yMax)
juliaColor = ones(xNum,yNum)
juliaSet = []
let offSet = 0
x = 1
for j in xMin:step:xMax
    y = 1
    for k in yMin:step:yMax
        p0 = j + im*k
        p = p0
        p_iter = 0
        for p_iter in 1:maxIter
            p = p^2 + a*p
            if abs(p) > R
                juliaColor[x,y] = p_iter
                break
            end
        end
        y += 1
    end
    x += 1
end
#contourf(juliaColor)
contour(log.(juliaColor),fill=true)
# plot!(yticks=yMin:step:yMax, xticks=xMin:step:yMax)
end
% A script to plot the Julia set for z^2 + az
clear, close all
a = exp(1i*(1+sqrt(5))/2);
R = 1000;
maxIter = 1000;
xMin = -1.5; 
xMax = 1.5;
yMin = -2;
yMax = 1;
step = .01;
xNum = length(xMin:step:xMax);
yNum = length(yMin:step:yMax);
juliaColor = zeros(xNum, yNum);
juliaSet = [];
x = 1;
offSet = 0;
for j = xMin:step:xMax
    y = 1;
    for k = yMin:step:yMax
        p0 = j + 1i*k;
        p = p0;
        iter = 0;
        for iter = 1:maxIter
            p = p^2 + a*p;
            if abs(p) > R
                break % Stop counting more iterations
            end % if
        end % for loop
        if (iter == maxIter)
            juliaColor(x,y) = 1 + offSet;
        else % not maximum iterations
            juliaColor(x,y) = iter;
        end % if
        if (y == 1) && (x == 1) && (iter > 0)
            offSet = iter - 1;
        elseif (y == 1) && (x == 1)
            offSet = 0;
        end % if
        y = y + 1;
    end % for loop
    x = x + 1;
end % for loop
contour(log(log(log((juliaColor-offSet)+1)+1))', 'Fill','on')
title('Julia Set')
xlab = xMin:.5:xMax;
xval = (xlab-xMin)/step + 1;
xticks(xval)
xticklabels(xlab)
ylab = yMin:.5:yMax;
yval = (ylab-yMin)/step + 1;
yticks(yval)
yticklabels(ylab)

% We plot complex points and their rotations by rho.
% Rotation number
rho = (sqrt(5) + 1)/2;
rrho = exp(rho*2*pi*1i);
z = 0:.1:1;
rz = z;

hold on
axis([-1 1 -1 1])
plot(0,0,'ob')
plot(z,zeros(length(z),1),'k')

for j = 1:400
    rz = rz*rrho;
    plot(rz,'r')
end
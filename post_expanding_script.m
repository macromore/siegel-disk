%% Plot some pre-images of the largest siegel disk
orbit = Pz(:,iter-1);
figure(1)
hold on
for k = 1:50
    [newOrbit1 , newOrbit2] = map_f_preimage(orbit, a);
    orbit = [newOrbit1; newOrbit2];
    plot((real(orbit)-xMin)/step,(imag(orbit)-yMin)/step,'.k','markersize',1);
    if k >= 1
       orbit = orbit(1:2:end); 
    end
end
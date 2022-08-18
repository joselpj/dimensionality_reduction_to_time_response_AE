load('Xnfull.mat');
Xnfull=Xnfull;
xin=Xnfull(:,1:5);
NSamples=501;

XNoise=[];
for i=1:NSamples
    snr=i/10;
    XNoise(:,5*i-4:5*i)=awgn(xin,20+snr,'measured');
    
end

for j=1:NSamples
    plot(XNoise(:,5*j))
    hold on
    pause(0.1)
end



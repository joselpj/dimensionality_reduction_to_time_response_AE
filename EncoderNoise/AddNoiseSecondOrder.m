load('Xin.mat');
Xin=Xin;
xin=Xin(:,1:6);
NSamples=501;

XNoise=[];
for i=1:NSamples
    snr=i/10;
    XNoise(:,6*i-5:6*i)=awgn(xin,20+snr,'measured');
    
end

for j=1:NSamples
    plot(XNoise(:,6*j))
    hold on
    pause(0.1)
end



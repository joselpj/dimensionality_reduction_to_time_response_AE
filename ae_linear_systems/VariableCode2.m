load('EncoderResult2.mat')

%decoder
decoder=newff([ones(3,1) zeros(3,1)],x,[100 200],{'tansig','tansig','purelin'},'trainscg');
decoder.inputs{1}.processFcns={'mapminmax'};
decoder.outputs{3}.processFcns={'mapminmax'};

Wco1=Net.lw{4,3};
Bco1=Net.b{4};
Wco2=Net.lw{5,4};

Bco2=Net.b{5};
Wco3=Net.lw{6,5};
Bco3=Net.b{6};

decoder.iw{1}=Wco1;
decoder.b{1}=Bco1;

decoder.lw{2,1}=Wco2;
decoder.b{2}=Bco2;
decoder.lw{3,2}=Wco3;
decoder.b{3}=Bco3;

%load code
% Code=[];

newCode=[-0.3569 -0.27 -0.1923 0.6469 0.652 0.3524 0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 0.4 0.3 -0.1 0.4 0.6 ;...
4.305 4.126 3.774 4.439 4.399 2.127 0 1 2 2.5 3 3.5 4 4.5 5 5.5 6 7;...
-0.08577 -0.01639 0.03715 1.269 1.253 -0.33112 0 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0.1 0.2 ];

% newCode=[-0.3569 -0.27 -0.1923 0.6469 0.652 0.3524 0 -0.3569 -0.27 -0.1923 0.6469 0.652 0.3524 -0.3569 -0.27 -0.1923 0.6469 0.652;...
%    4.305 4.126 3.774 4.439 4.399 2.127 0 4.305 4.126 3.774 4.439 4.399 2.127 0 4.305 4.126 3.774 4.439;...
%    -0.08577 -0.01639 0.03715 1.269 1.253 -0.33112 0 -0.08577 -0.01639 0.03715 1.269 1.253 -0.33112 0 -0.08577 -0.01639 0.03715 1.269]; %3.66089517558110];

figure
set(gcf,'color','w');
axis([-1 1 1 8 -1 3])
Yrec=[];


for i=1:length(newCode(1,:))
    val=newCode(1,i);
    switch val
        case -0.3569
            marker='+k';
        case -0.27
            marker='ok';
        case -0.1923
            marker='*k';
        case 0.6469
            marker='.k';
        case 0.652
            marker='xk';
        case 0.3524
            marker='sk';
        otherwise
            marker='^k';
    end
    
    hold on
    plot3(newCode(1,i),newCode(2,i),newCode(3,i),marker,'MarkerSize',12,'LineWidth',4)
    text(newCode(1,i),newCode(2,i),newCode(3,i),int2str(i))
    
    grid on
    grid minor
    %pause(2)
    Yrec=[Yrec,sim(decoder,[newCode(1,i),newCode(2,i),newCode(3,i)]')];
%       axis([0.5 5 3 9])
%       addpoints(curve,newCode(1,i),newCode(2,i))
%       drawnow
%       pause(1)
      
end
hold off
[XNor,PS]=mapstd(Xin(:,1:18)');
YdecT=mapstd('reverse',Yrec',PS);
YdecT=YdecT';
%figure
set(gcf,'color','w');
for n=1:length(newCode(1,:))
    
    %subplot(9,2,n)
    figure(n)
    plot(YdecT(:,n),'k','LineWidth',1)
    grid on
    grid minor
    title(strcat('Time Response Generated from code:',int2str(n)),'fontsize',8)
    xlim([-inf 1000]) 
    ylim([0 11])
    
    
end

%subplot
set(gcf, 'PaperPosition', [0 0 5 5]); %Position plot at left hand corner with width 5 and height 5. 
set(gcf, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5. 
saveas(gcf, 'ord2_gen_code18', 'pdf') %Save figure

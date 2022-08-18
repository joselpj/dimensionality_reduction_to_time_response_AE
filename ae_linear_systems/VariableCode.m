load('EncoderResult.mat')

%decoder
decoder=newff([ones(2,1) zeros(2,1)],x,[100 200],{'tansig','tansig','purelin'},'trainscg');
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


newCode=[4.52575108087365 3.60195803559043 3 2.5 1.6 0.600829433140947...
    1 1.33397808518241 1.45635936220395 2 2.5 3 3.5 4 4.5;... %4.52575108087365;...
    3.66089517558110 3.77892341321860 4 5 4 5.27891097886034...
    6 6.71093531898985 8.27124544670219 8 7.5 7 6 5 4]; %3.66089517558110];
%newCode=[4.52575108087365 4.52575108087362 4.52575108087347;...
%    3.66089517558110 3.66089517558108 3.66089517558088];
%newCode=[4.52575108087365,3.60195803559043,10,1.33397808518241,...
 %   1.45635936220395;...
  %  3.66089517558110,3.77892341321860,10,6.71093531898985,...
  %  8.27124544670219];
%newCode=[10,20,30,40,50;10,20,30,40,50];
%curve=animatedline;
figure
axis([0.5 5 3 9])
Yrec=[];


for i=1:length(newCode(1,:))
    val=newCode(1,i);
    switch val
        case 4.52575108087365
            marker='vk';
        case 3.60195803559043
            marker='+k';
        case 0.600829433140947
            marker='ok';
        case 1.33397808518241
            marker='*k';
        case 1.45635936220395
            marker='xk';
        otherwise
            marker='.k';
    end
    
    hold on
    plot(newCode(1,i),newCode(2,i),marker,'MarkerSize',12,'LineWidth',4)
    text(newCode(1,i),newCode(2,i),int2str(i))
    
    grid on
    grid minor
    %pause(2)
    Yrec=[Yrec,sim(decoder,[newCode(1,i),newCode(2,i)]')];
%       axis([0.5 5 3 9])
%       addpoints(curve,newCode(1,i),newCode(2,i))
%       drawnow
%       pause(1)
      
end
hold off
[XNor,PS]=mapstd(Entrada(:,1:15)');
YdecT=mapstd('reverse',Yrec',PS);
YdecT=YdecT';
%figure
set(gcf,'color','w');
for n=1:length(newCode(1,:))
    
    %subplot(8,2,n)
    figure(n)
    plot(YdecT(1:4000,n),'k','LineWidth',1)
    grid on
    grid minor
    title(strcat('Time Response Generated from code:',int2str(n)),'fontsize',8)
    xlim([-inf 4000]) 
    ylim([0 11])
    
    
    
end

%subplot
set(gcf, 'PaperPosition', [0 0 5 5]); %Position plot at left hand corner with width 5 and height 5. 
set(gcf, 'PaperSize', [5 5]); %Set the paper to have width 5 and height 5. 
saveas(gcf, 'ord1_gen_code1', 'pdf') %Save figure
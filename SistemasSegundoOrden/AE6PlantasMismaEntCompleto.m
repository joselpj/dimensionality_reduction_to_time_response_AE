%%
%This code applied an autoencoder to 2nd order system data.
%Author: Jose Luis Paniagua - jlpaniagua@uao.edu.co 
%date: 25/Feb/2019
%%


close all
%clear all

load('Xin');
XNor=mapstd(Xin');
XNorT=XNor';

x=XNorT;
Xtrain=zeros(1001,18);

for i=1:18
  
   Xtrain(:,i)=x(:,i); 
end
x=Xtrain;
%Create Net
Net=newff(x,x,[200 100 3 100 200],{'tansig','tansig','purelin','tansig','tansig','purelin'},'trainscg');
Net.trainparam.epochs=30000;

Net.inputs{1}.processFcns={'mapminmax'};
Net.outputs{6}.processFcns={'mapminmax'};

Net.dividefcn='';

%The network is trained
Net=train(Net,x,x);


Out=sim(Net,x);

view(Net)

Error=x-Out;

%%
%encoder
encoder=newff(x,[ones(3,1) zeros(3,1)],[200 100],{'tansig','tansig','purelin'},'trainscg');
encoder.inputs{1}.processFcns={'mapminmax'};
encoder.outputs{3}.processFcns={'mapminmax'};

Wco1=Net.iw{1};
Bco1=Net.b{1};
Wco2=Net.lw{2,1};
Bco2=Net.b{2};
WcoCode=Net.lw{3,2};
BcoCode=Net.b{3};
 
encoder.iw{1}=Wco1;
encoder.b{1}=Bco1;
encoder.lw{2,1}=Wco2;
encoder.b{2}=Bco2;
encoder.lw{3,2}=WcoCode;
encoder.b{3}=BcoCode;

NPuntos=18;%10;
Patrones= [1:18];%randperm(Total_Digitost,NPuntos);
Code=(sim(encoder,x(:,Patrones)));

figure

Escala=minmax(Code);

Xmin=Escala(1,1);
Xmax=Escala(1,2);
Ymin=Escala(2,1);
Ymax=Escala(2,2);

%NPuntos=10
% for i=1:NPuntos
%     plot(Code(1,i),Code(2,i),'oc')
%     hold on
%     axis([Xmin Xmax Ymin Ymax])
% end;

for i=1:6
    
YtestLabelP((6*i)-5:6*i)=[1:6];

end

for i=1:NPuntos
    if YtestLabelP(Patrones(i))==1
       plot3(Code(1,i),Code(2,i),Code(3,i),'ob') %Planta1-entrada1
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
    if YtestLabelP(Patrones(i))==2
       plot3(Code(1,i),Code(2,i),Code(3,i),'or') %Planta2
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==3
       plot3(Code(1,i),Code(2,i),Code(3,i),'og') %Planta3
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
      if YtestLabelP(Patrones(i))==4
       plot3(Code(1,i),Code(2,i),Code(3,i),'oy') % Planta4
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==5
       plot3(Code(1,i),Code(2,i),Code(3,i),'ok') %Planta 5
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==6
       plot3(Code(1,i),Code(2,i),Code(3,i),'*m') %Planta 6
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
    
    
end;

%%
%decoder
% decoder=newff([ones(2,1) zeros(2,1)],x,[100 200],{'tansig','tansig','purelin'},'trainscg');
% decoder.inputs{1}.processFcns={'mapminmax'};
% decoder.outputs{3}.processFcns={'mapminmax'};
% 
% Wco1=Net.lw{4,3};
% Bco1=Net.b{4};
% Wco2=Net.lw{5,4};
% 
% Bco2=Net.b{5};
% Wco3=Net.lw{6,5};
% Bco3=Net.b{6};
% 
% decoder.iw{1}=Wco1;
% decoder.b{1}=Bco1;
% decoder.lw{2,1}=Wco2;
% decoder.b{2}=Bco2;
% decoder.lw{3,2}=Wco3;
% decoder.b{3}=Bco3;

%patrones=x
%cambiar la semilla de random number 10 veces y guardar.
%reducir el tamaño de las neuronas en las capas.
%hacer lo mismo con varias plantas.
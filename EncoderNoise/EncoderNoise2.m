%This code applied an autoencoder to 1st order system data.

close all

Entrada=XNoise;


% para normalizar cuando la entrada tiene dimensiones (1001,15) o (n,15)
% Ndata=size(Entrada,1);
% XNor=mapstd(Entrada');
% XNorT=XNor';

x=XNoise;
NSamples=size(x,2); %columns of x
Ndata=size(x,1); % rows of x
% Xtrain=zeros(1001,NSamples);
epochs=5000;
% for i=1:NSamples
%   
%    Xtrain(1:i)=x(1:i);% solo se toman 8000 muestras para acelerar el train 
% end
%x=Xtrain;
%Create Net
Net=newff(x,x,[200 100 3 100 200],{'tansig','tansig','purelin','tansig','tansig','purelin'},'trainscg');
Net.trainparam.epochs=epochs;

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

NPuntos=NSamples;%10;
Patrones= [1:NSamples];%randperm(Total_Digitost,NPuntos);
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

for i=1:501
    
YtestLabelP((6*i)-5:6*i)=[1:6];

end

for i=1:NPuntos
    if YtestLabelP(Patrones(i))==1
       plot3(Code(1,i),Code(2,i),Code(3,i),'ob') %Planta1-entrada1
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
    if YtestLabelP(Patrones(i))==2
       plot3(Code(1,i),Code(2,i),Code(3,i),'og') %Planta2
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==3
       plot3(Code(1,i),Code(2,i),Code(3,i),'ok') %Planta3
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
      if YtestLabelP(Patrones(i))==4
       plot3(Code(1,i),Code(2,i),Code(3,i),'or') % Planta4
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==5
       plot3(Code(1,i),Code(2,i),Code(3,i),'oy') %Planta 5
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==6
       plot3(Code(1,i),Code(2,i),Code(3,i),'om') %Planta 6
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
    
end;

%planta1: tao= 
%planta2: tao= 
%planta3: tao= 
%planta4: tao= 
%planta5: tao= 

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


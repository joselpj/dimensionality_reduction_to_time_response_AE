%This code applied an autoencoder to 1st order system data.

close all
%clear all

%load('Xin');
%XNor=mapstd(Xin');

load('Xnfull');
Entrada=Xnfull;

% load('Xfila');
% Entrada=Xfila;
% XNor=mapstd(Entrada);
% XNorT=reshape(XNor,[1001,15]);

% para normalizar cuando la entrada tiene dimensiones (1001,15) o (n,15)
Ndata=size(Entrada,1);
XNor=mapstd(Entrada');
XNorT=XNor';

x=XNorT;
Ndata=size(x,1);
Xtrain=zeros(Ndata,15);

for i=1:15
  
   Xtrain(1:8000,i)=x(1:8000,i);% solo se toman 8 muestras para acelerar el train 
end

x=Xtrain;
%Create Net
Net=newff(x,x,[200 100 2 100 200],{'tansig','tansig','purelin','tansig','tansig','purelin'},'trainscg');
Net.trainparam.epochs=60000;

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
encoder=newff(x,[ones(2,1) zeros(2,1)],[200 100],{'tansig','tansig','purelin'},'trainscg');
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

NPuntos=15;%10;
Patrones= [1:15];%randperm(Total_Digitost,NPuntos);
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

for i=1:5
    
YtestLabelP((5*i)-4:5*i)=[1:5];

end

for i=1:NPuntos
    if YtestLabelP(Patrones(i))==1
       plot(Code(1,i),Code(2,i),'ob') %Planta1-entrada1
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
    if YtestLabelP(Patrones(i))==2
       plot(Code(1,i),Code(2,i),'og') %Planta2
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==3
       plot(Code(1,i),Code(2,i),'ok') %Planta3
       hold on
       axis([Xmin Xmax Ymin Ymax])
    end;
  
      if YtestLabelP(Patrones(i))==4
       plot(Code(1,i),Code(2,i),'or') % Planta4
       hold on
      axis([Xmin Xmax Ymin Ymax])
    end;
    if YtestLabelP(Patrones(i))==5
       plot(Code(1,i),Code(2,i),'oy') %Planta 5
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

%patrones=x
%cambiar la semilla de random number 10 veces y guardar.
%reducir el tamaño de las neuronas en las capas.
%hacer lo mismo con varias plantas.


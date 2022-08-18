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
[XNor,PS]=mapstd(Entrada');
Ydec=sim(decoder,Code);
YdecT=mapstd('reverse',Ydec',PS);
YdecT=YdecT';
[m,n] = size(eeg_signals) ;
P = 0.70 ;
idx = randperm(m)  ;
Training = eeg_signals(idx(1:round(P*m)),:) ; 
Testing = eeg_signals(idx(round(P*m)+1:end),:) ;
time = [1:4094];
[Rm,Rn] = size(Training);
Rr = 1+(Rm-1).*rand(1,1);
[Em,En] = size(Testing);
Er = 1+(Em-1).*rand(1,1);
[Rm,Rn] = size(Training);
Rr = round(1+(Rm-1).*rand(1,1),0);
[Em,En] = size(Testing);
Er = round(1+(Em-1).*rand(1,1),0);
figure
subplot(2,1,1)
plot(time,Training(Rr,:))
title('Random Training D8ata')
subplot(2,1,2)
plot(time,Testing(Er,:))
title('Random Testing Data')
AX = gca;
AX.XTick = 0:178:4094;
xlabel('Time')

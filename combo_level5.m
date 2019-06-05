function y = combo_level5(x)
load("eeg_signals.mat","eeg_signals");
load("seizure_info.mat","seizure_info");
eeg_signals;
seizure_info;
[a,d] = haart(eeg_signals(x,:),5);
u1 = repelem(d{1,1},2);
u2 = repelem(d{1,2},4);
u3 = repelem(d{1,3},8);
u4 = repelem(d{1,4},16);
u5 = repelem(d{1,5},32);
umatrix = nan(4096,5);
umatrix(1:length(u1), 1) = u1;
umatrix(1:length(u2), 2) = u2;
umatrix(1:length(u3), 3) = u3;
umatrix(1:length(u4), 4) = u4;
umatrix(1:length(u5), 5) = u5;
adj_umatrix = umatrix';
adj_umatrix = adj_umatrix(:,1:end-2)
det1 = adj_umatrix(1,:);
det2 = adj_umatrix(2,:);
det3 = adj_umatrix(3,:);
det4 = adj_umatrix(4,:);
det5 = adj_umatrix(5,:);
[pts_Opt_1,kopt_1,t_est_1] = wvarchg(det1);
[pts_Opt_2,kopt_2,t_est_2] = wvarchg(det2);
[pts_Opt_3,kopt_3,t_est_3] = wvarchg(det3);
[pts_Opt_4,kopt_4,t_est_4] = wvarchg(det4);
[pts_Opt_5,kopt_5,t_est_5] = wvarchg(det5);
num_els = [numel(pts_Opt_1),numel(pts_Opt_2),numel(pts_Opt_3),numel(pts_Opt_4),numel(pts_Opt_5)];
max_els = max(num_els);
pts_Opt_1(1,max_els) = 0;
pts_Opt_2(1,max_els) = 0;
pts_Opt_3(1,max_els) = 0;
pts_Opt_4(1,max_els) = 0;
pts_Opt_5(1,max_els) = 0;
changepts = [pts_Opt_1; pts_Opt_2; pts_Opt_3; pts_Opt_4; pts_Opt_5];
changepts_v = nonzeros(changepts);
changepts_v = sort(nonzeros(changepts));
changepts_s = changepts_v/178
time = (1:4094);
figure
subplot(6,1,1)
plot(time,eeg_signals(x,:))
title('EEG Signal')
subplot(6,1,2)
plot(time,adj_umatrix(1,:))
title('Level 1 Details')
subplot(6,1,3)
plot(time,adj_umatrix(2,:))
title('Level 2 Details')
subplot(6,1,4)
plot(time,adj_umatrix(3,:))
title('Level 3 Details')
subplot(6,1,5)
plot(time,adj_umatrix(4,:))
title('Level 4 Details')
subplot(6,1,6)
plot(time,adj_umatrix(5,:))
title('Level 5 Details')
AX = gca;
AX.XTick = 0:178:4094;
xlabel('Time')
changepts_plot=figure;
subplot(2,1,1)
AX = gca;
AX.XTick = 0:178:4094;
xticklabels({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23})
hold on
plot(time,eeg_signals(x,:))
line([changepts_v changepts_v], ylim,'Color','green')
title("Predicted Seizures")
subplot(2,1,2)
seizures = (find(~seizure_info(x,:))-1)
seizures2 = (find(~seizure_info(x,:)))
seizures = seizures*178;
seizures2 = seizures2*178;
plot(time,eeg_signals(x,:))
AX = gca;
AX.XTick = 0:178:4094;
xticklabels({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23})
xlabel('Time')
line([seizures; seizures], ylim,'Color','red');
line([seizures2; seizures2], ylim,'Color','red');
title("True Seizures")
end

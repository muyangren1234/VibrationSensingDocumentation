clear all;
close all;

data_path = 'E:\dataset\vibration_system\';
date = "2019-12-16";
peak_number = 60;
%sensor =[165, 152, 111, 118,117, 138,153,106,243,203,104,143,109,112,101];
sensor =[117,101,104,203,138,153,165,243];
geophone =[1,1, -1, 1,-1,-1,-1,1]
hour =["19"]
min = [1]

cc =zeros(size(sensor,2),size(sensor,2));
nor_cc =zeros(size(sensor,2),size(sensor,2));
for kk =1:size(sensor,2)
    [signals1, arrival_time] = signal_extract(data_path ,sensor(kk),geophone(kk), date, hour(1), min(1), 60);
    nor_signals1 = signals1 ./ sqrt(sum(signals1.^2,2));
    for ii =kk:size(sensor,2)
        [signals2, arrival_time] = signal_extract(data_path ,sensor(ii),geophone(ii), date, hour(1), min(1), 60);
        nor_signals2 = signals2 ./ sqrt(sum(signals2.^2,2));
        cccc =[];
        nor_cccc = [];
        for tmp_m =1:size(nor_signals1, 1)
                tmp_cc =corrcoef(signals1(tmp_m,:), signals2(tmp_m,:));
                tmp_nor_cc = corrcoef(nor_signals1(tmp_m,:), nor_signals2(tmp_m,:));
                cccc = [cccc, abs(tmp_cc(1,2))];
                nor_cccc = [nor_cccc, abs(tmp_nor_cc(1,2))];
            
        end
        ttt = mean(cccc);
        nor_ttt = mean(nor_cccc);
        cc(kk,ii) = ttt;
        nor_cc(kk,ii) = nor_ttt;
    end
end
save('corrcoef.mat', 'cc');
%%
ave_cc = [];
for ii =1:8
    tmp_cc=[];
    for jj=1:8
        if ii == jj
            continue
        end
        if ii < jj
            tmp_cc = [tmp_cc, cc(ii,jj)];
        else
            tmp_cc = [tmp_cc, cc(jj, ii)];
        end
    end
    if size(tmp_cc,2) ~=7
        c='ddddddddddddd'
        break
    end
    ave_cc = [ave_cc, mean(tmp_cc)];
end
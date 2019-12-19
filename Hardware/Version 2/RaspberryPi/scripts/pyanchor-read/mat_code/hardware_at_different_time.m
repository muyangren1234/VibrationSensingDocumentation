clear all;
close all;

data_path = 'E:\dataset\vibration_system\';
date = "2019-12-16";
peak_number = 60;
%sensor =[165, 152, 111, 118,117, 138,153,106,243,203,104,143,109,112,101];
sensor =[117,101,104,203,138,153,165,243];
geophone =[1,1, -1, 1,-1,-1,-1,1]
hour =["19"]
min = 1
old_min = 32

cc =zeros(size(sensor,2),size(sensor,2));

for kk =1:size(sensor,2)
    [signals1, arrival_time] = signal_extract(data_path ,sensor(kk),geophone(kk), date, hour(1), min(1), 60);

        cccc =[];
        nor_cccc = [];
        for tmp_m =1:size(signals1, 1)-1
            for tmp_n = tmp_m+1:size(signals1, 1)
                tmp_cc =corrcoef(signals1(tmp_m,:), signals1(tmp_n,:));
                
                cccc = [cccc, abs(tmp_cc(1,2))];
            end

            
        end
        ttt = mean(cccc);
        nor_ttt = mean(nor_cccc);
        cc(kk,kk) = ttt; 
end


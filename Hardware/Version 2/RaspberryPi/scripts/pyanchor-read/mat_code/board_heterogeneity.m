clear all;
close all;

data_path = 'E:\dataset\vibration_system\';
date = "2019-12-14";
peak_number = 50;
sensor =[104,143,109,112];
geophone =[1,-1,-1,-1];
hour =["21"];
min = [35];
num_peak = 60;

cc =zeros(size(sensor,2),size(sensor,2));
nor_cc =zeros(size(sensor,2),size(sensor,2));

[signals1, arrival_time1] = signal_extract(data_path ,sensor(1),geophone(1), date, hour(1), min(1), num_peak);
[signals2, arrival_time2] = signal_extract(data_path ,sensor(2),geophone(2), date, hour(1), min(1), num_peak);
[signals3, arrival_time3] = signal_extract(data_path ,sensor(3),geophone(3), date, hour(1), min(1), num_peak);
[signals4, arrival_time4] = signal_extract(data_path ,sensor(4),geophone(4), date, hour(1), min(1), num_peak);    

%%
cc = zeros(4,4);
for ii=1:3
    for kk=ii+1:4
        %eval(['t_err(', num2str(ii),',', num2str(kk), ') = mean(abs(arrival_time', num2str(ii), '- arrival_time', num2str(kk),'));'])
        eval(['s1 = signals',num2str(ii), ';'])
        eval(['s2 = signals',num2str(kk), ';'])
        tmp_c =[];
        for tmp_m = 1:size(s1,1)
            for tmp_n = 1:size(s2,1)
                
                tmp_tmp_c = corrcoef(s1(tmp_m,:), s2(tmp_n,:));
                tmp_c =[tmp_c, abs(tmp_tmp_c(1,2))];
                
            end
        end
        cc(ii, kk) = mean(tmp_c);
    end
end


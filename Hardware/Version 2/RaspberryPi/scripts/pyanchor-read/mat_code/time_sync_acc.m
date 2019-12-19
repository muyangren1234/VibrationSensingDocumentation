clear all;
close all;

data_path = 'E:\dataset\vibration_system\';
date = "2019-12-14";
peak_number = 50;
sensor =[104,143,109,112];
geophone =[1,-1,-1,-1];
hour =["21"];
min = [19];
num_peak = 61;

cc =zeros(size(sensor,2),size(sensor,2));
nor_cc =zeros(size(sensor,2),size(sensor,2));

[signals1, arrival_time1] = signal_extract(data_path ,sensor(1),geophone(1), date, hour(1), min(1), num_peak);
[signals2, arrival_time2] = signal_extract(data_path ,sensor(2),geophone(2), date, hour(1), min(1), num_peak);
[signals3, arrival_time3] = signal_extract(data_path ,sensor(3),geophone(3), date, hour(1), min(1), num_peak);
[signals4, arrival_time4] = signal_extract(data_path ,sensor(4),geophone(4), date, hour(1), min(1), num_peak);    

%%
t_err = zeros(4,4);
for ii=1:3
    for kk=ii+1:4
        %eval(['t_err(', num2str(ii),',', num2str(kk), ') = mean(abs(arrival_time', num2str(ii), '- arrival_time', num2str(kk),'));'])
        eval(['tmp_tt = abs(arrival_time', num2str(ii), '- arrival_time', num2str(kk),');'])
        new_t =[];
        count = 0
        for tmp_t = 1:size(tmp_tt,2)
            if tmp_tt(tmp_t) > 200
                figure
                eval(['s1 = signals',num2str(ii), '(tmp_t, :)']) 
                eval(['s2 = signals',num2str(kk), '(tmp_t, :)'])
                plot(s1)
                hold on
                plot(s2)
                title(num2str(tmp_tt(tmp_t)))
                continue
            end
            count = count +1;
            new_t(count)= tmp_tt(tmp_t);
        end
        t_err(ii,kk) = mean(new_t);
    end
end

%% raw time difference
close all
t_err = zeros(4,4);
for ii=1:3
    for kk=ii+1:4
        %eval(['t_err(', num2str(ii),',', num2str(kk), ') = mean(abs(arrival_time', num2str(ii), '- arrival_time', num2str(kk),'));'])
        eval(['tmp_tt = abs(arrival_time', num2str(ii), '- arrival_time', num2str(kk),');'])
        figure
        plot(tmp_tt)
        title([num2str(ii), ' VS ', num2str(kk)])
        t_err(ii,kk) = mean(tmp_tt);
    end
end

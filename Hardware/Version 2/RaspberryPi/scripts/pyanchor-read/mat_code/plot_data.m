clear all;
close all;
clc;

date = '2019-12-23';
hour = '12';
min = 50;
sensor = 18;
append = '_39775';
data_path ='E:\github_lib\VibrationSensingDocumentation\Hardware\Version 2\RaspberryPi\scripts\pyanchor-read\hw_decode_data\'

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, min+ii);
    all_data = [all_data, tmp_all_data];
end
%all_data1 = all_data(10000: 240000);
figure
plot(all_data)
ylim([0-100 2^10+100])

%%
min = 43;
sensor = 15;
append = '_48943';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, min+ii);
    all_data = [all_data, tmp_all_data];
end
all_data2 = all_data(90000: 320000);
figure
plot(all_data2)
ylim([0-100 2^10+100])

%%
min = 43;
sensor = 16;
append = '_64540';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, min+ii);
    all_data = [all_data, tmp_all_data];
end
all_data3 = all_data(130000: 360000);
figure
plot(all_data3)
ylim([0-100 2^10+100])

%%
min = 43;
sensor = 18;
append = '_13622';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, min+ii);
    all_data = [all_data, tmp_all_data];
end
all_data4 = all_data(130000: 360000);
figure
plot(all_data4)
ylim([0-100 2^10+100])

%%

all_data1 = all_data1-mean(all_data1);
all_data2 = all_data2-mean(all_data2);
all_data3 = all_data3-mean(all_data3);
all_data4 = all_data4-mean(all_data4);

[signals1] = signal_extract(all_data1, 60);
[signals2] = signal_extract(all_data2, 60);
[signals3] = signal_extract(all_data3, 60);
[signals4] = signal_extract(all_data4, 60);

cc =[];
var_cc =[];
for ii=1:4
    eval(['s1= signals', num2str(ii),';'])
    ii
    for kk=ii:4
        
        eval(['s2= signals', num2str(kk),';'])
        level_cc = [];
        for m=1:size(s1,1)
            tmp_s1 = s1(m,:);
            tmp_s2 = s2(m,:);
            tmp_cc = [];
            for wind=1:100
                ts1 = tmp_s1(wind:wind+300);
                for wind2 =1:100
                    ts2 = tmp_s2(wind2:wind2+300);
                    ss= corrcoef(ts1, ts2);
                    tmp_cc =[tmp_cc, abs(ss(1,2))];
                end
            end
            level_cc =[level_cc, max(tmp_cc)];
        end
        cc(ii,kk) = mean(level_cc);
        var_cc(ii,kk) = var(level_cc);
    end
end
        
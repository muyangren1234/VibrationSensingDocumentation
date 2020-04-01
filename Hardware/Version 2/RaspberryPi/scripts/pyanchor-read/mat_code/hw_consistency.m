clear all;
close all;
clc;

date = '2019-12-23';
hour = '16';
minute = 26;
sensor = 11;
append = '_86325';
data_path ='..\hw_decode_data\'

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s1 = all_data(1:270000);
figure
plot(s1)
ylim([0-100 2^10+100])

%%

minute = 26;
sensor = 12;
append = '_19162';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s2 = all_data(1:270000);
figure
plot(s2)
ylim([0-100 2^10+100])

%%

sensor = 13;
append = '_71705';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s3 = all_data(1:270000);
figure
plot(s3)
ylim([0-100 2^10+100])

%%

sensor = 14;
append = '_89456';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s4 = all_data(1:270000);
figure
plot(s4)
ylim([0-100 2^10+100])

%%

sensor = 15;
append = '_4926';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s5 = all_data(1:270000);
figure
plot(s5)
ylim([0-100 2^10+100])

%%

sensor = 16;
append = '_48908';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s6 = all_data(1:270000);
figure
plot(s6)
ylim([0-100 2^10+100])


%%

sensor = 18;
append = '_83801';

all_data = [];
for ii=0:0
    tmp_all_data = read_txt_extract_data(data_path ,sensor, append, date, hour, minute+ii);
    all_data = [all_data, tmp_all_data];
end
s7 = all_data(1:270000);
figure
plot(s7)
ylim([0-100 2^10+100])


%%
for ii=1:7
    eval(['s',num2str(ii),' = s',num2str(ii),' - mean(s',num2str(ii),');'])
    ii
    eval(['[sample', num2str(ii),'] = signal_extract(s',num2str(ii), ', 50);'])
end

%%
cc =[];
var_cc =[];
for ii=1:7
    eval(['ts1= sample', num2str(ii),';'])
    ii
    for kk=ii:7
        
        eval(['ts2= sample', num2str(kk),';'])
        level_cc = [];
        for m=1:size(s1,1)
            tmp_s1 = ts1(m,:);
            tmp_s2 = ts2(m,:);
            tmp_cc = [];
            for wind=1:100
                tts1 = tmp_s1(wind:wind+300);
                for wind2 =1:100
                    tts2 = tmp_s2(wind2:wind2+300);
                    ss= corrcoef(tts1, tts2);
                    tmp_cc =[tmp_cc, abs(ss(1,2))];
                end
            end
            level_cc =[level_cc, max(tmp_cc)];
        end
        cc(ii,kk) = mean(level_cc);
        var_cc(ii,kk) = var(level_cc);
    end
end
        
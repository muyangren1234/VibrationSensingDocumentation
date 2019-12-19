function [signals, arrival_time] = signal_extract(data_path ,sensor, g_flag, date, hour, min,peak_number)

%data_path = 'E:\dataset\vibration_system\';
%date = "2019-12-14";
%hour = '21';
%min = 19;


signals = [];
arrival_time = [];


    [all_data, time_stamp_us, record_time_us] = read_txt_extract_data(data_path ,sensor, date, hour, min);
    all_data = all_data*g_flag;
    all_data = all_data - mean(all_data);
    t='ddddddddddddd'
    size(all_data,2)
    %delete weird impluse
    for kk=1:size(all_data,2)
        if abs(all_data(kk)) > 20000
            all_data(kk) =0;
        end
    end
    
    figure
    plot(all_data)
    title(num2str(sensor))
   
    [maxv,maxl]=findpeaks(all_data,'minpeakdistance',4000,'NPeaks',peak_number, 'MinPeakHeight', 3000);
    
    if size(maxv,2) ~= peak_number
        size(maxv,2) 
        eee='errorrrrrrr'
        
    end
    
    for kk=1:size(maxv,2)
        tmp_l = maxl(kk);
        tmp_loc = floor((tmp_l-1)/600)+1;
        tmp_tsp = time_stamp_us(tmp_loc);
        tmp_res = mod((tmp_l-1), 600);
        tmp_ti = tmp_tsp + tmp_res*100;        
        tmp_sig = all_data(tmp_l-250:tmp_l + 250);
        
        signals = [signals; tmp_sig];
        arrival_time = [arrival_time,tmp_ti];
    end
    figure
    plot(tmp_sig)
end


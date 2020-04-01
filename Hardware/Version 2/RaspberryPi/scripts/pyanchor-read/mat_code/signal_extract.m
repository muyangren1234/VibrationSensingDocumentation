function [signals] = signal_extract(all_data, peak_number)

%data_path = 'E:\dataset\vibration_system\';
%date = "2019-12-14";
%hour = '21';
%min = 19;
   
    [maxv,maxl]=findpeaks(all_data,'minpeakdistance',2000,'NPeaks',peak_number, 'MinPeakHeight', 200);
    
    if size(maxv,2) ~= peak_number
        size(maxv,2) 
        eee='errorrrrrrr'
        
    end
    signals = [];
    for kk=1:size(maxv,2)
        tmp_l = maxl(kk);      
        tmp_sig = all_data(tmp_l-100:tmp_l + 300);
        
        signals = [signals; tmp_sig];
    end
    %figure
    %plot(tmp_sig)
end


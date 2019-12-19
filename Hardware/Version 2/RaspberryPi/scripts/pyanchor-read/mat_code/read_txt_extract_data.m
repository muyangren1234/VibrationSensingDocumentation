function all_data = read_txt_extract_data(data_path ,sensor, date, hour, min)
%date = '2018-04-23';
%hour = '13';
%start_min = 41;
%min_count =1;
%start_ip = 238;
%sensor_count = 10;

%bad_ip =[220,225];

ip = '192.168.1.';

all_data=[];

 
    tmp_sensor = [num2str(sensor)]
    
    file_path = strcat(data_path, tmp_sensor ,'\',date,'\');
    all_data =[];
    
    
    if min <10
        strmin = strcat(int2str(0), int2str(min));
    else
        strmin = int2str(min);
    end
    tmpfilename = strcat(file_path,date,'_', hour, '-', strmin, '.txtout.txt')
    
    if exist(tmpfilename, 'file') ==0
        all_data =0;
        time_stamp_us = 0;
record_time_us = 0;
        ttttt='file error'
        return
    end
    
    tmpdata = importdata(tmpfilename);
    [a,b] = size(tmpdata);
   
    
    all_data = tmpdata';

end
date = '2019-12-19';
hour = '10';
min = 07;
sensor = 1937;
data_path ='E:\github_lib\VibrationSensingDocumentation\Hardware\Version 2\RaspberryPi\scripts\pyanchor-read\decode_data\'

all_data = read_txt_extract_data(data_path ,sensor, date, hour, min);
figure
plot(all_data)
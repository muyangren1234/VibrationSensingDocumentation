import serial
import types
import time
import datetime
import threading
import os
from parser_pi2mac import decode_data

import copy
import numpy as np
import Queue
import errno
from struct import *

# file saved path.
FILEPATH = './data/'  #data saved path

data_time = 80 #receiv data time limit, the unit is seconds, 0 means receive data all the time.
#windows
port='COM3'
#Linux
#port='/dev/ttyUSB0'

ser = serial.Serial('COM7', 115200)

sensor_ip_list =[]
sensor_ip_list.append('1937')


queue = []
for ii in range(len(sensor_ip_list)):
    queue.append(Queue.Queue(0))

def all_receive_data(sensor_ip_list, time_lim):
    time_tag = get_time_tag()
    old_min = time_tag[14:16]
    file_date = time_tag[0:14]
    start_second = int(time.time());

    all_data  = []

    for ii in range(len(sensor_ip_list)):
        all_data.append([])  #initial data list
        all_data[ii] = ''
  
    data_flag = False
    initial_flag = True
    while True:
        time_tag = get_time_tag()
        new_min = time_tag[14:16]
 
        #time_limit
        now_second = int(time.time())
        if (time_lim >0) & (now_second - start_second > time_lim):
            #save file
            filename = file_date + new_min + '.txt'
            print(filename)
            writ_data = copy.deepcopy(all_data)
            threading.Thread(target=save_file, args=(sensor_ip_list, filename,writ_data,)).start()
            break
       
        # save file
        if new_min != old_min:
            filename = file_date + old_min + '.txt'
            old_min = new_min
            file_date = time_tag[0:14]
            writ_data = copy.deepcopy(all_data)
            threading.Thread(target=save_file, args=(sensor_ip_list,filename,writ_data,)).start()
            #set
            for ii in range(len(sensor_ip_list)):
                all_data[ii] = ''
            initial_flag = False

# receive sensor package
        n = ser.inWaiting()

        if (n):
            receive_data = ser.read(n)
            
            client_address=['1937'];
            data_flag = True
            time_tag = get_time_tag()
        else:
            receive_data =[]
            client_address=['1937']
            data_flag = False
        
        t1 = time.clock()
        data_ip = str(client_address[0])
        
        if len(receive_data) < 1:
            continue 
        if data_ip in sensor_ip_list:
            data_location_num = sensor_ip_list.index(data_ip)
        else:
            print ('%s sensor still upload data!'%data_ip)
            continue
        
        de_code_data =  receive_data
#        print time_tag 
#        print len(receive_data)
        
        all_data[data_location_num] =all_data[data_location_num] + de_code_data
        time.sleep(0.01)
        t2 = time.clock()
#       print("data process time is %f"%(t2-t1))

def save_file( sensor_ip_list,filename, data_list):
    
    date = filename.split('_')[0]
    for count in range( len(sensor_ip_list)):
        if os.path.exists(FILEPATH + sensor_ip_list[count] +'/'+ date +'/') == False:
            os.makedirs(FILEPATH + sensor_ip_list[count] + '/'+ date)
        complete_filename = FILEPATH + sensor_ip_list[count] +'/' + date +'/' +filename
        print(complete_filename)
        datafile = open(complete_filename,'wb')
        print(len(data_list[count]))
        datafile.write(data_list[count])
        datafile.close()

def get_time_tag():

    timenow = datetime.datetime.now()
    filename = str(timenow)
    filename = filename.replace(' ','_')
    filename = filename.replace(':','-')
    return filename


if __name__ == "__main__":
     
    time_lim = data_time
    all_receive_data(sensor_ip_list, time_lim)
    ser.close()
    time.sleep(2)
    decode_data(FILEPATH)
    ss= input('wait')
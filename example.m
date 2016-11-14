% clear all
% clc
% [~,~,c]=xlsread('data/Pedestrian_Counts.csv');
% 
% colHeadings = c(1,:);
% data = cell2struct(c, colHeadings, 2);
% clear c colHeadings
% data = rmfield(data,{'Date_Time','ID','Sensor_Name'});
% data = data(2:end);

query = struct();
query.Year = 2014;
query.Day = 'Monday';
query.Sensor_ID = 1;
query.Time = 0;
% query.fake_field = 'test';
% query.fake_field1 = 'test';


% data = struct();
[result] = array_of_struct_filter(data,query);

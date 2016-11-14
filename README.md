# array_of_struct_filter
% filtering array of structures
% Input :
%         data: array structure containing data that can be accessed using
%         field names and indices
%         query : structure containing values assigned to fieldnames
%         matching existing filednames in data


% Output :
%        result : structure similar to data containing elements matching
%        the query only
%         
% Example : 

%         query = struct();
%         query.Name = 'Robert';
%         query.Day = 'Monday';
%         query.Month = 'June';
%         
%         [~,~,data] = xlsread('file.csv')
%         colHeadings = data(1,:);
%         data = cell2struct(data, colHeadings, 2);
%         result = array_of_struct_filter(data,query)

function [result] = array_of_struct_filter(data,query)
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

debug_data = {};
result = true(1,length(data));
if ~(isstruct(data) && isstruct(query))
    err = '(data) and/or (query) type is not structure';
    debug_data{end+1} = err;
    error(err);
end

% Check field names
data_fnames = fieldnames(data);
query_fnames = fieldnames(query);

% Confirm that data and query hava valid field names
if isempty(data_fnames)
    err = 'data can\''t have zero fields';
    debug_data{end+1} = err;
    error(err);
end

if isempty(query_fnames)
    err = 'query can\''t have zero fields';
    debug_data{end+1} = err;
    error(err);
end

memb_test = ismember(query_fnames,data_fnames);
if all(memb_test)
    for i = 1:length(query_fnames)
        field = char(query_fnames(i));
        if (isnumeric(data(1).(field)))
            result = result & ([data.(field)] == query.(field));
        elseif (ischar(data(1).(field)))
            result = result & (strcmp({data.(field)},query.(field)));
        else
            err = sprintf('data at field (%s) is of unknown type',field);
            debug_data{end+1} = err;
            error(err);
        end
    end
else
    err_fields = char(strjoin(query_fnames(~memb_test),', '));
    err = sprintf('%s is/are not valid field name(s)',err_fields);
    debug_data{end+1} = err;
    error(err);
end
result = data(result);
end
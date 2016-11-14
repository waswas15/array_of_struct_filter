function [result,debug_data] = array_of_struct_filter(data,query)
% filtering array of structures
debug_data = {};
result = struct();
if ~(isstruct(data) && isstruct(query))
    error(' (data) and/or (query) type is not structure');
end

% Check field names
data_fnames = fieldnames(data);
query_fname = fieldnames(query);

% Confirm that data and query are not
if isempty(data_fnames)
    debug_data{end+1} = 'data can\''t have zero fields';
    error(debug_data{end})
end

if isempty(query_fnames)
    error('query can\''t have zero fields')
end

memb_test = ismember(query_fname,data_fnames);
if all(memb_test)
    
    
    
else
    debug_data{end+1} = sprintf('%s is/are not valid field name(s)',query_fname(~memb_test));
    error(debug_data(end))
end
d(([d.Sensor_ID] == 1) & ([d.Year] == 2014) & (strcmp({d.Day},'Monday')))

end
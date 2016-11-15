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
% Examples : 
%         [~,~,data] = xlsread('file.csv')
%         colHeadings = data(1,:);
%         data = cell2struct(data, colHeadings, 2);
%         query1 = struct();
%         query1.Name = 'Robert';
%         query1.Mdate = 1;
%         query1.Day = 'Monday';
%         query1.Month = 'June';
%         result1 = array_of_struct_filter(data,query1)

%         query2 = struct();
%         query2.Name = {'Robert','Peter'};
%         query2.Mdate = [1,2];
%         query2.Day = {'Monday','Friday','Saturday'};
%         query2.Month = 'June';    
%         result2 = array_of_struct_filter(data,query2)

debug_data = {};
N = length(data);
result = true(1,N);
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
%         handle numeric query fields including array of numeric
        if (isnumeric(data(1).(field)))
            if (isnumeric(query.(field)))
                query_length = length(query.(field));
                temp_result = false(1,N);
                for j=1:query_length
                    query_item = query.(field)(j);
                    temp_result = temp_result | ([data.(field)] == query_item);
                end
                result = result & temp_result;
            else
                err = sprintf('query at field (%s) is of unknown type',field);
                debug_data{end+1} = err;
                error(err);
            end
%          handle fields of type char including query fields including
%          multiple char values in a cell
        elseif (ischar(data(1).(field)))
            
            if (ischar(query.(field)))
                result = result & (strcmp({data.(field)},query.(field)));
            elseif (iscell(query.(field)))
                query_length = length(query.(field));
                temp_result = false(1,N);
                for j=1:query_length
                    query_item = query.(field)(j);
                    temp_result = temp_result | (strcmp({data.(field)},query_item));
                end
                result = result & temp_result;
            else
                err = sprintf('query at field (%s) is of unknown type',field);
                debug_data{end+1} = err;
                error(err);
            end
            
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
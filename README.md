# array_of_struct_filter.m function
**filtering array of structures**
### Input :
         data: array structure containing data that can be accessed using
         field names and indices
         query : structure containing values assigned to fieldnames
         matching existing filednames in data


### Output :
        result : structure similar to data containing elements matching
        the query only
         
### Examples :
```matlab
         [~,~,data] = xlsread('file.csv');
         colHeadings = data(1,:);
         data = cell2struct(data, colHeadings, 2);
         query1 = struct();
         query1.Name = 'Robert';
         query1.Mdate = 1;
         query1.Day = 'Monday';
         query1.Month = 'June';
         result1 = array_of_struct_filter(data,query1);
```
```matlab
         query2 = struct();
         query2.Name = {'Robert','Peter'};
         query2.Mdate = [1,2];
         query2.Day = {'Monday','Friday','Saturday'};
         query2.Month = 'June';    
         result2 = array_of_struct_filter(data,query2);
```
% SPLIT_DATA split gesture dataset into training and testing sets.
% Usage
%       [train, test] = split_data(dataset, fractionTraining)
%
% where fractionTraining is the fraction of data to use as training set.
%
function [train, test] = split_data(dataset, fracTrain)

for i=1:length(dataset)
    n = floor(length(dataset{i})*fracTrain);
    n2 = max(n, floor(length(dataset{i})*0.5));
    if iscell(dataset{i})
       train{i} = {dataset{i}{1:n}};
       test{i} = {dataset{i}{n2+1:end}};
    else
       train{i} = dataset{i}(:,:,1:n);
       test{i} = dataset{i}(:,:,n2+1:end);
    end
end

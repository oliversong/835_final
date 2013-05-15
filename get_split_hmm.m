function [ split ] = get_split_hmm( data, ratio )
    split.seqs_train={};
    split.labels_train={};
    split.seqs_test={};
    split.labels_test={};
    
    [train,test] = split_data(data,ratio);
    for i=1:numel(train),
        for j=1:numel(train{i}),
            split.seqs_train{end+1} = train{i}{j};
            split.labels_train{end+1} = zeros(length(train{i}{j}),1) + i;
        end
    end
    for i=1:numel(test),
        for j=1:numel(test{i}),
            split.seqs_test{end+1} = test{i}{j};
            split.labels_test{end+1} = zeros(length(test{i}{j}),1) + i;
        end
    end
end
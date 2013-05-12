function [model, accuracy] = experiment_hmm(data, ratio, h, g)

    % Default values to nbHiddenStates and nbGaussMixtures
    if ~exist('h','var'),
        h = 6;
    end
    if ~exist('g','var'),
        h = 3;
    end
    
    % Set HMM params
    params.verbose = 0;
    params.randSeed = 12345;
    params.maxiter_em = 100;
    params.nbHiddenStates = h;
    params.nbGaussMixtures = g;
    
    % Load the data and split 
    split = get_split_hmm(data,ratio);
    
    % Train model    
    model = trainHMM( split.seqs_train, split.labels_train, params);
    
    % Test model
    Ystar = testHMM( model, split.seqs_test );
    Ytrue = cellfun(@(x) mode(x), split.labels_test);
    accuracy = sum(Ystar==Ytrue)/numel(Ytrue);
        
    fprintf('HMM: nbHiddenStates=%d, nbGaussMixtures=%d, accuracy=%f\n', ...
        params.nbHiddenStates,params.nbGaussMixtures,accuracy);
    
end

function [ split ] = get_split_hmm( data, ratio )
    split.seqs_train={}; split.labels_train={};
    split.seqs_test={};  split.labels_test={};
    
    [train,test] = split_data(data,ratio);
    for i=1:numel(train),
        for j=1:numel(train{i}),
            split.seqs_train{end+1} = train{i}{j};
            split.labels_train{end+1} = zeros(1,size(train{i}{j},2)) + i;
        end
    end
    for i=1:numel(test),
        for j=1:numel(test{i}),
            split.seqs_test{end+1} = test{i}{j};
            split.labels_test{end+1} = zeros(1,size(test{i}{j},2)) + i;
        end
    end
end

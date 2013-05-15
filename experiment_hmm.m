function [model, accuracy] = experiment_hmm(data, ratio, h, g)

    % Default values to nbHiddenStates and nbGaussMixtures
    if ~exist('h','var'),
        h = 6;
    end
    if ~exist('g','var'),
        g = 3;
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

% [ hmm ] = trainHMM( seqs, labels, params )
%   

function [ hmm ] = trainHMM( seqs, labels, params )
    RandStream.setGlobalStream(...
        RandStream('mt19937ar', 'seed', params.randSeed));

    Q = params.nbHiddenStates;
    M = params.nbGaussMixtures;
    
    Y = cellfun(@(x) mode(x), labels);
    unique_Y = unique(Y);
    hmm.models = cell(1, numel(unique_Y));
    ll = cell(1, numel(unique_Y));

    for y = 1:numel(unique_Y)
        if params.verbose
            fprintf('-- Training an HMM for label=%d\n', unique_Y(y));
        end
        hmm.models{y}.label = unique_Y(y);
        seqs_y = seqs(Y==unique_Y(y));
        [ll{y}, hmm.models{y}.prior, hmm.models{y}.transmat, hmm.models{y}.mu, ...
            hmm.models{y}.sigma, hmm.models{y}.mixmat] = ...
            train_hmm(Q,M,seqs_y,params.maxiter_em,params.verbose);    
    end
    hmm.params = params;
end

function [ll, prior, transmat, mu, sigma, mixmat] = train_hmm(Q, M, seqs, maxiter_em, verbose)
    dim_obs = size(seqs{1},1);
    cov_type = 'diag'; % 'full' is much slower

    prior0    = normalise(rand(Q,1));
    transmat0 = mk_stochastic(rand(Q,Q));
    mixmat0   = mk_stochastic(rand(Q,M));
    
    [mu0, sigma0] = mixgauss_init(Q*M, cell2mat(seqs), cov_type, 'kmeans');
    mu0    = reshape(mu0, [dim_obs Q M]);
    sigma0 = reshape(sigma0, [dim_obs dim_obs Q M]);
    
    if M<=1, mixmat0 = []; end; % Single-Gaussian mixtures

    % Sanity check
    for i=1:Q
        if sum(sum(isnan(sigma0(:,:,i))))>0
            sigma0(:,:,i) = eye(dim_obs);
        end
    end
      
    [ll, prior, transmat, mu, sigma, mixmat] = ...
        mhmm_em(seqs,prior0,transmat0,mu0,sigma0,mixmat0,...
              'max_iter',maxiter_em,'verbose',verbose,'cov_type',cov_type);
        
    assert(~sum(isnan(prior)));
end
% function [ ll, Y ] = testHMM( R, seqs, labels )
%    

function [Ystar, ll] = testHMM( hmm, seqs )
    ll = cell(1, numel(seqs)); 
    for i=1:numel(seqs) 
        for j=1:numel(hmm.models)
            m = hmm.models{j};
            ll{i}(j,1) = mhmm_logprob(seqs{i}, m.prior, ...
                m.transmat, m.mu, m.sigma, m.mixmat);
        end
    end
    [~, Ystar] = max(cell2mat(ll));
end


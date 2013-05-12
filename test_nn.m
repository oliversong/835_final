% TEST_NN: test the nearest neighbor classifier on an even split of the
% input data. 
%
% Requires you to implement the functions NORMALIZE_FRAMES and CLASSIFY_NN.

function [accuracy] = test_nn(data, ratio)
    [train, test] = split_data(data, ratio);
    n = length(train); % number of gesture types
    correct = 0;
    total = 0;

    for i=1:n
        m = length(test{i}); % number of examples for the gesture type
        for j=1:m
            label = classify_nn(test{i}{j}, train);
            if (label == i)
                correct = correct + 1;
            end
            total = total + 1;
        end
    end

    accuracy = correct/total;
end
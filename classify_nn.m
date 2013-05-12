% CLASSIFY_NN: nearest neighbor classifier. Returns the label index of the
% nearest neighbor to the test gesture in the training set.

function [label] = classify_nn(test, train) 
    % test is a DxN matrix of a single gesture, where D is the number of
    % body segments and N is the number of frames
    % train is a training set containing test gestures in the form of the
    % gesture array.
    % I have to use euclidean distance, or (sqrt(sum(xi-yi)**2)) between
    % every point in the test matrix and every point in every gesture
    % matrix and find the gesture that has the smallest distance, then
    % return it.
    %
    % Based on this:
    % FOR every gesture
    %   FOR every set in gesture
    %       eucdist(matrix1,matrix2)
    %       use matrix operations for this: sqrt(sum((matrix1-matrix2)**2))
    scores = zeros(size(train));
    i = 1;
    while i <= length(train)
        j = 1;
        running_total = 0;
        while j <= length(train{i})
            hwat = (train{i}{j}-test).^2;
            ho = sqrt(sum(sum(hwat)));
%             disp('distance')
%             disp(ho)
            running_total = running_total + ho;
            j = j + 1;
        end
        scores(i) = running_total;
        i = i + 1;
    end
%     disp('scores')
%     disp([scores])
    [smallest_val, index] = min(scores);
%     disp('index')
%     disp(index);
    label = index;
end
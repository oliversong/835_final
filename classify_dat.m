% classify using highest overlap

function [Ystar, Ytrue] = classify_dat(data)
    Ystar = zeros(1,numel(data)*numel(data{1}));
    Ytrue = zeros(1,numel(data)*numel(data{1}));
    for i=1:numel(data)
        for j=1:numel(data{i})
            Ystar((i-1)*numel(data{i})+j) = classify_one(data{i}{j}, data);
            Ytrue((i-1)*numel(data{i})+j) = i;
        end
    end
    confmat = build_confmat(Ystar, Ytrue);
    plot_confmat(confmat);
    accuracy = sum(Ystar==Ytrue)/numel(Ytrue);
    fprintf('Accuracy: %d',accuracy);
end

function [ highest_probability ] = classify_one( to_check, data)
    scores = zeros(1,numel(data));
    for i=1:numel(data)
        intermediate = zeros(1,numel(data{i}));
        for j=1:numel(data{i})
            % intermediate.append sum(to_check*scratch2)
            intermediate(1,j) = compare_one(to_check,data{i}{j});
        scores(1,i) = mean(intermediate);
        end
    end
    [ maxval, highest_probability ] = max(scores);
end

function [ score ] = compare_one( to_check, compare_against )
    % pad 200 zeros on either size of compare against
    % run 200 times and find the maximum score
    to_check = to_check / norm(to_check,2);
    compare_against = compare_against / norm(compare_against,2);
    padding = 1000;
    padded = padarray(compare_against,[0 padding]);
    %to_check = 10*to_check;
    scores = zeros(1,padding*2);
    for i=1:padding*2
        blah = sum(to_check.*padded(i:i+length(compare_against)-1));
        scores(i) = blah;
    end
    score = max(scores);
end
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
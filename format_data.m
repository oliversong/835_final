function [bro] = format_data(filtered)
    bro = cell(1, numel(filtered));
    for i=1:numel(bro)
       bro{i} = cell(1,numel(filtered{i}.data));
    end
    for i=1:numel(bro)
        for j=1:numel(bro{i})
            bro{i}{j} = abs(filtered{i}.data{j})';
        end
    end
end
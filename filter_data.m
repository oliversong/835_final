function [filtered_data] = filter_data(scratch_data)
    % after a little experimentation, it seems like most scratches
    % (regardless of shape) have around the same frequency profile.
    % Therefore, I'm going to stick with the time domain and scale the
    % scratches to consistent dimensions.
    
    filtered_data = scratch_data;
    domains= zeros(numel(scratch_data)*numel(scratch_data{1}.data));
    
    for i=1:numel(scratch_data)
        for j=1:numel(scratch_data{i}.data)
            current = scratch_data{i}.data{j};
            % trim data of zeros left and right
            i1 = find(current, 1, 'first');
            i2 = find(current, 1, 'last');
            segment = current(i1:i2);
            % apply a gaussian filter
            sigma = std(segment);
            size = 6*sigma;
            x = linspace(-size / 2, size/2, size);
            gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
            gaussFilter = gaussFilter / sum(gaussFilter);
            f_seg = conv(segment, gaussFilter, 'same');
            % figure out the average domain
            domains(i*j) = length(f_seg);
            % output
            filtered_data{i}.data{j} = f_seg;
        end
    end
    avg_domain = mean(domains);
    for i=1:numel(scratch_data)
        for j=1:numel(scratch_data{i}.data)
        % scale data to average domain
            filtered_data{i}.data{j} = interpft(filtered_data{i}.data{j},avg_domain);
        end
    end
end
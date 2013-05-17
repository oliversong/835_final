function [filtered_data] = filter_data(scratch_data)
    % after a little experimentation, it seems like most scratches
    % (regardless of shape) have around the same frequency profile.
    % Therefore, I'm going to stick with the time domain and scale the
    % scratches to consistent dimensions.
    
    filtered_data = scratch_data;
    domains= zeros(numel(scratch_data)*numel(scratch_data{1}.data),1);
    disp('attempting to remove white noise')
%     for i=1:numel(scratch_data)
%         for j=1:numel(scratch_data{i}.data)
%             for k=1:numel(scratch_data{i}.data{j})
%                 if scratch_data{i}.data{j}(k) > 0.1
%                     temp = scratch_data{i}.data{j}(k)-threshold;
%                     %disp(temp)
%                     if temp < 0
%                         temp = 0;
%                     end
%                     scratch_data{i}.data{j}(k) = temp;
%                 elseif scratch_data{i}.data{j}(k) < 0
%                     temp = scratch_data{i}.data{j}(k)+threshold;
%                     if temp > 0
%                         temp = 0;
%                     end
%                     scratch_data{i}.data{j}(k) = temp;
%                 end
%             end
%         end
%     end
    disp('snipping, gaussian, and averaging')
    for i=1:numel(scratch_data)
        for j=1:numel(scratch_data{i}.data)
            current = scratch_data{i}.data{j};
            % trim data of small values left and right
            i1 = find(current>0.01, 1, 'first');
            i2 = find(current>0.01, 1, 'last');
            segment = current(i1:i2);
            % apply a gaussian filter
%             sigma = 1;
%             size = 6*sigma;
%             x = linspace(-size / 2, size/2, size);
%             gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
%             gaussFilter = gaussFilter / sum(gaussFilter);
%             f_seg = conv(segment, gaussFilter, 'same');
            f_seg = segment;
            % figure out the average domain
            domains((i-1)*numel(scratch_data{i}.data)+j) = length(f_seg);
            %disp(length(f_seg))
            %disp((i-1)*numel(scratch_data{i}.data)+j)
            %disp(domains)
            % output
            filtered_data{i}.data{j} = f_seg;
        end
    end
    disp('scaling everything to the same domain')
    
    avg_domain = ceil(mean(mean(domains)));
    for i=1:numel(scratch_data)
        for j=1:numel(scratch_data{i}.data)
        % scale data to average domain
            %disp('attempting to interpolate')
            %disp(numel(filtered_data{i}.data{j}))
            %disp('to')
            %disp(avg_domain)
            filtered_data{i}.data{j} = interpft(filtered_data{i}.data{j},avg_domain);
        end
    end
end
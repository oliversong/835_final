function [scratch_data] = build_dataset()
    num_gestures = 10;
    gesture_types = {'triangle','square','loop','circle','X','oslash','I','doubletap'};
    recObj = audiorecorder(4000,8,1);
    record_length = 2;
    
    % builds the dataset.
    scratch_data = cell(1, numel(gesture_types));
    for i=1:numel(scratch_data)
        scratch_data{i}.label = gesture_types(i);
        scratch_data{i}.data = cell(1, num_gestures);
    end
    
    % make the audio recordings and store them.
    for i=1:numel(gesture_types)
        for j=1:num_gestures
            disp(strcat('Scratch for: ',gesture_types(i),'#',int2str(j)))
            % 2 seconds should be enough
            recordblocking(recObj, record_length);
            disp('End of Recording.');
            scratch_data{i}.data{j} = getaudiodata(recObj);
        end
    end
end
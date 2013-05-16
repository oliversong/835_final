function [enveloped] = envelope(data)
    enveloped = data;
    b = fir1(1000, 1/8000);
    for i=1:numel(data)
        for j=1:numel(data{i})
            enveloped{i}{j} = 3*filter(b,1,data{i}{j});
        end
    end
    figure,plot(data{1}{1})
    hold on
    plot(enveloped{1}{1},'r')
    hold off
    figure,plot(data{2}{4})
    hold on
    plot(enveloped{2}{4},'r')
    hold off
    figure,plot(data{7}{3})
    hold on
    plot(enveloped{7}{3},'r')
    hold off
    figure,plot(data{4}{3})
    hold on
    plot(enveloped{4}{3},'r')
    hold off
end

% NEXT STEPS:

% take taps out from dataset...

% cut off low amplitude like before (literal subtraction)...maybe not

% use 8000 dataset it is better

% USE A BETTER ENVELOPE FUNCTION (!)
function [count] = blah(ll,Ytrue)
    count = 0;
    for i=1:numel(ll)
        temp = ll{i};
        [maxval,ind1] = max(temp);
        [secondmax,ind2] = max(temp~=max(temp));
        if ind1 == Ytrue(i)
            count = count + 1;
        elseif ind2 == Ytrue(i)
            count = count + 1;
        end
    end
end
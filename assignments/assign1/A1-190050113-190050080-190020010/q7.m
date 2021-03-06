clear; clc;
% a=[0 2 3 5 6];
% b=[0 1 2 3 5 6];
% 
% disp(mean(b));
% disp(UpdateMean(mean(a), 1, 5));
% 
% disp(2.5)
% disp(UpdateMedian(3,1,a,5));
% 
% disp(std(b));
% disp (UpdateStd(mean(a), std(a), mean(b), 1, 5));



function newMean = UpdateMean(OldMean, NewDataValue, n)
newMean=(OldMean*n+NewDataValue)/(n+1);
end

function newMedian = UpdateMedian (oldMedian, NewDataVAlue, A, n)
if mod(n,2) ~= 0
    mi=(n+1)/2;
    if NewDataVAlue<A(mi-1)
            newMedian=(A(mi-1)+oldMedian)/2;
    elseif NewDataVAlue<A(mi+1)
        newMedian=(NewDataVAlue+oldMedian)/2;
    else
        newMedian=(A(mi+1)+oldMedian)/2;
    end
    
else
    mi=n/2;
    if NewDataVAlue<A(mi)
            newMedian=A(mi);
    elseif NewDataVAlue<A(mi+1)
        newMedian=NewDataVAlue;
    else
        newMedian=A(mi+1);
    end
    
    
    
end 
end


function newStd = UpdateStd(OldMean, OldStd, NewMean, NewDataValue, n)
    newStd=((1/n)*((n-1)*OldStd^2+ NewDataValue^2+n*OldMean^2-(n+1)*NewMean^2))^(1/2);
end




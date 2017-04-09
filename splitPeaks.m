
% splitPeaks(data, t) returns an array of peak voltages along with 
% their start, max value, and end locations as indices of data

% return: [V, istart, imax, iend], where:

%  V = [pk1, pk2, ..., pkN]
% istart [is1, ..., isN]
% imax [im1, ..., imN] 
% iend [ie1, ..., ieN]

% data should be a 1D vector of voltages

% t should be a float representing noise tolerance 
% any voltage < min(data) + min(data)*t will be considered noise 

function [V, istart, imax, iend] = splitPeaks(data, t)

peaksRemain = 1;

V = zeros(1,5) - 2;
imax = zeros(1,5) - 2;
istart = zeros(1,5) - 2;
iend = zeros(1,5) - 2;
found = 0;

while peaksRemain && found ~= 5

    [pk, im] = max(data);
    floor = mean(data)*(1 + 0.5);

    if pk > floor
        bound = find(data <= t*pk);
        b = bound - im;
        a = find(b > 0);
        c = find(b < 0);
        a = b(a);
        c = b(c);
        
        if ~isempty(a)
            ie = im + min(a);
        else
            ie = -1;
            peaksRemain = 0;
        end
        
        if ~isempty(c)
            is = im + max(c);
        else
            is = -1;
        end
        

        rem = (1:ie);
        data(rem) = [];
        
        found = found + 1;
        
        if found > 1
            V(found) = pk;
            istart(found) = is + iend(found-1);
            imax(found) = im + iend(found-1);
            iend(found) = ie + iend(found-1);
        else
            V(found) = pk;
            istart(found) = is;
            imax(found) = im;
            iend(found) = ie;            
        end
     
    else
        peaksRemain = 0;
    end
end
end








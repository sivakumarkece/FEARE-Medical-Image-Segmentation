function [Filtered_Seed] = zhenzhou_shape_filtering(bobC,T_shape,Band_Width)
    temp = bwboundaries(bobC);
    tempCell = [];
    for i = 1:max(size(temp))
        if max(size(temp{i})) > T_shape
            tempCell{i} = temp{i};
        end
    end
    NS = size(bobC);
    Filtered_Seed = zeros(NS(1),NS(2));
    for i = 1:max(size(tempCell))
        if max(size(tempCell{i})) > 0
            xb = tempCell{i}(:,2);
            yb = tempCell{i}(:,1);
            fhist = fft(xb);
            fhist(Band_Width:(end-Band_Width)) = 0;
            xb1 = ifft(fhist);
            fhist = fft(yb);
            fhist(Band_Width:(end-Band_Width)) = 0;
            yb1 = ifft(fhist);
            ROI = poly2mask(abs(xb1),abs(yb1),size(bobC,1),size(bobC,2));
            Filtered_Seed = Filtered_Seed + ROI;
        end
    end
end

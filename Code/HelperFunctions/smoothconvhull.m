function [smoothia] = smoothconvhull(image)
    s = logical(image);
    ss  = regionprops(s, 'Area');
    areas = cat(1, ss.Area);
    bopen = max(areas)-10;
    ia = bwareaopen(s, bopen);  
    iis = mat2gray(ia);
    BW1 = iis(:,:,1);   
    BW3 = bwconvhull(BW1,'objects',8);
    BW3 = uint8(BW3);
    BW3 = zhenzhou_shape_filtering(BW3,10,4);
    se = strel('disk',2); 
    BW3 = imdilate(BW3,se);   
    smoothia = BW3;
end

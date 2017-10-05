% Inclass11

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.
%a)
file='011917-wntDose-esi017-RI_f0016.tif';
reader=bfGetReader(file);
[reader.getSizeX,reader.getSizeY]

ans =

        1024        1024
%b)
reader.getSizeZ
ans =

     1
%c)
reader.getSizeT

ans =

    68
%d)

reader.getSizeC

ans =

     2


% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.
chan=1;
time=30;
zplane=1;
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img1=bfGetPlane(reader,iplane);

chan=2;
time=30;
zplane=1;
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img2=bfGetPlane(reader,iplane);

im2show=cat(3,imadjust(img1),imadjust(img2),zeros(size(img1)));
imshow(im2show)

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 
img_m=img1 > 800;
img_m=img1 > 900;
img_m=img1 > 1000;
img0=uint16(img_m)*1000;
img2showm=cat(3, imadjust(img0), imadjust(img2), zeros(size(img1)));
imshow(img2showm);
imshow(imadjust(img0));

% The best threshold is around 900.
% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

imge=imerode(img_m, strel('disk',3));
imgd=imdilate(img_m, strel('disk',3));
% In erode function, every pixel within the 3 pixels range of a black pixel will be converted into a black pixel. 
% In dilate function, every pixel within the 3 pixels range of a white pixel will be converted into a white pixel. 


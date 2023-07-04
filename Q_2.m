clc;clear all;
input = imread('pic.jpg');        %Read the Image
[r,c] = size(input);        %get the size of image  
shift=-150; 
scale=3; 
grayscale = 0:255;           %r is grayscale       %Defining input pixels
trans_function = round(scale*grayscale)+ shift;% in gray scale we must have integer values so we need to round our data  %linear Transformation function
output = zeros(r,c);
for i=1:r                                       
    for j=1:c
        t=(input(i,j)+1);            %pixel values in image because of matlab starts from 1 index we need to +1 
        output(i,j)=trans_function(t);        %Making the ouput image using 
    end                                      %the transformation function
end
% Procedure for plotting histogram
hist_input = zeros(1,256);                               %prealocation space for input histogram
hist_output = zeros(1,256);                               %prealocation space for output histogram
for i1=1:r                                      %loop tracing the rows of image 
    for j1=1:c                                   %loop tracing the Columns of image
        for k1=0:255                                %loop checking which graylevel
            if input(i1,j1)==k1                         %match found at k1
                hist_input(k1+1)=hist_input(k1+1)+1;          %because of matlab starts from 1 index we need to +1
            end
            if output(i1,j1)==k1                        %for output image because of matlab starts from 1 index we need to +1
                hist_output(k1+1)=hist_output(k1+1)+1;                
            end
        end
    end
end        
% Plotting input image output image and their respective histograms
figure(1);
sgtitle('linear transformation function')
subplot(2,2,1);
imshow(input);
title('input image')
subplot(2,2,2);
imshow(uint8(output));
title('output image')
subplot(2,2,3);
stem(hist_input);
title('input hist')
subplot(2,2,4);
stem(hist_output);
title('output hist')
%% generating PDF of histograms by fourmula which says hist divide by number of pixels 
pdf_input=hist_input/r/c;
%% generating CDF of PDF
 cdf_tranformation=zeros(1,256);
for i=2:256
    cdf_tranformation(1)=pdf_input(1);
    cdf_tranformation(i)=cdf_tranformation(i-1)+pdf_input(i);
end
cdf_tranformation=round(cdf_tranformation*255);%it is our transformation function % at first we scale it bt 256 according to our grayscale and then round it not to occur float numbers
% defining output matrix
for i=1:r                                        
    for j=1:c
        t=(input(i,j)+1);            %pixel values in image because of matlab starts from 1 index we need to +1
        output(i,j)=cdf_tranformation(t);        %Making the ouput image using 
    end                                      %the transformation function
end
% defining histogram
for i1=1:r                                       %loop tracing the rows of image 
    for j1=1:c                                   %loop tracing the Columns of image
        for k1=0:255                                %loop checking which graylevel
            if output(i1,j1)==k1                        %for output image because of matlab starts from 1 index we need to +1
                hist_output(k1+1)=hist_output(k1+1)+1;                
            end
        end
    end
end     
%Plotting input image output image and their respective histograms 
figure(2);
sgtitle('cdf transformation function')
subplot(2,2,1);
imshow(input);
title('input image')
subplot(2,2,2);
imshow(uint8(output));
title('output image')
subplot(2,2,3);
stem(hist_input);
title('input hist')
subplot(2,2,4);
stem(hist_output);
title('output hist')
%% log and power transformation function 
a=im2double(input);
power_a=zeros(r,c);%pre allocation
log_a=zeros(r,c);%pre allocation
factor=2;
power=1.5;
for i=1:r
    for  j=1:c
log_a(i,j)=factor*log(1 + a(i,j));
power_a(i,j)=factor* (a(i,j)^power);
    end
end
%plot
figure(3);
sgtitle('log and power transformation')
subplot(1,3,1);
imshow(input);
title('input image')
subplot(1,3,2);
imshow((power_a));
title('power transformation')
subplot(1,3,3);
imshow((log_a));
title('log transformation')
%% matlab defined function
y=histeq(input);
figure(4);
imshow(y)
title('histeq')

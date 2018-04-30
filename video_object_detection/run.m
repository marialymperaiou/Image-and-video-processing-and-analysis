clear all;
close all;

root = 'C:/Users/user/Desktop/maria_5h_eikonavideo_2016/';
%path to read from the right folder the scripts and the data. Change for another PC!

seq = input('Choose sequence:','s');
% to avoid not necessary calculations: chose the frames in which the motion that we wish to detect is more observable.
% this can be done by observing the frames for each sequence,

win_ratio=2; % window size comparing to the block size. Default window value is double the size of the block value.
%for k=2:0.1:2.5
   % win_ratio=k;
   %k=k+1;
%end
% the chosen limit for each frame were found after trials

    if (strcmp(seq,'coast'))
         first=10;
         last=50;
         block=8; %block size
   
    elseif (strcmp(seq,'bike'))
         first=55;
         last=80;
         block=10;
     
     elseif (strcmp(seq,'garden'))
         first=20;
         last=40;
         block=9;
   
     elseif (strcmp(seq,'tennis'))
         first=5;
         last=30;
         block=7;
          
     else
         disp('no such sequence');
     end
file_pat = [root seq '/' seq '_%03d.gif'];

i=1;
% for each frame pair the moving objects are detected and stored in obj array.
for j=first:last
    Z = indread(sprintf(file_pat, j));   %current frame
    J = indread(sprintf(file_pat, j+1)); %next frame

    W(:,:,i)=rgb2gray(Z); % store black and white frames in W by transforming the current Z frame in black and white
    % extra parameter: frame sequence, so as for every frame, a different threshold will be chosen, due to
    % the different kind of motion in each video.

    [f_vx, f_vy, object(:,:,j)] =bm_obj(Z, J, [block,block], [floor(block*(win_ratio-1)/2),floor(block*(win_ratio-1)/2)],seq);
    % in every next frame pair, the moving parts are detected and stored in 'object', while f_vx, f_vy
    % are the smoothed motion vectors for every frame sequence.
    % Input: 2 consecutive frames, block, searching window and given sequence.

    i=i+1; % next black and white frame
end
i=1;

%putting together the binary motion detection frames on the real ones, which leads to the creation of the video.

a=size(W);                                   % interesting elements will be extracted from the first 2 dimensions.
b=size(object(:,:,1)); 
s1= zeros(a(1)-b(1),a(2));
s2= zeros(b(1),a(2)-b(2));

for k=first:last
    % video creation, which consists of the real frames on which the binary motion detection frames are placed.
    %figure;
    imshow(+W(:,:,i)+[object(:,:,k) s2 ;s1])
    pause(0.25);                            % ideal value chosen after trials. Necessary to control the frame projection, which results in proper video speed.
    %âñÝèçêå ìå äïêéìÝò
    i=i+1;
end

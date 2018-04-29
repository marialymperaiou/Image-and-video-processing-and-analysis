function y = zigzag(x, n)

z = [ 1     2     6     7    15    16    28    29; 
      3     5     8    14    17    27    30    43; 
      4     9    13    18    26    31    42    44; 
     10    12    19    25    32    41    45    54; 
     11    20    24    33    40    46    53    55; 
     21    23    34    39    47    52    56    61; 
     22    35    38    48    51    57    60    62; 
     36    37    49    50    58    59    63    64];

% Y board is the 8x8 block of the mask table
y = x;

% The elements fulfilling this condition (elements of z > n) are cut off for
% this parameter value n which is given at the input (= 0)
% And thus the cut-off mask is applied on the elements with high values
% which are located as we move down and right,
% Since in the dct compression we generally maintain the information located
% as much as possiblenear to top and left (significant components)
y(z > n) = 0;
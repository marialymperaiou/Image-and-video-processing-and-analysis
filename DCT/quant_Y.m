function Q = quant_Y(Y, q)

QfY = [ 16 11 10 16  24  40  51  61 
        12 12 14 19  26  58  60  55
        14 13 16 24  40  57  69  56
        14 17 22 29  51  87  80  62
        18 22 37 56  68 109 103  77
        24 35 55 64  81 104 113  92
        49 64 78 87 103 121 120 101
        72 92 95 98 112 100 103  99 ];
      
QY = q * QfY;       % Multiplication with the quantization factor
Q = round(Y ./ QY); % Divide the mask table Y with the table above 'element to element' 
% Greater factor q => greater elements of the QY => fewer data
% Of the Q factor (Y constant) and due to rounding, zeroing if they belong
% in the range [0-0,44444], so cut them off. So, the upper left components
% are maintained, and as q increases, fewer and fewer elements survive
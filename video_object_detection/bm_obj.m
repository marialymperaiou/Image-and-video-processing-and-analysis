function [f_vx, f_vy, object] = bm_obj (Z, J, b, d,seq)

Z=padarray(Z,[d(1) d(2)]);

if(nargin<3), b = [8 8]; end % block size
if(nargin<4), d = [4 4]; end % max displacement
bx = b(1); 
by = b(2);
dx = d(1); 
dy = d(2);

% number of blocks
[ny, nx, c] = size(J);
nby = floor(ny / by);
nbx = floor(nx / bx); 

% motion vectors
vx = zeros(nby, nbx);
vy = zeros(nby, nbx);

% loop over blocks
for ibx = 1:nbx
    for iby = 1:nby
	E = zeros(2*dy+1, 2*dx+1);
	% loop over displacements
        for rx = -dx:dx
            for ry = -dy:dy
                x = bx*(ibx-1) + (1:bx);
                y = by*(iby-1) + (1:by);
                D = J(y, x, :) - Z(y+ry+dy, x+rx+dx, :); % block error
                E(ry+dy+1, rx+dx+1) = sum(D(:).^2);
            end
        end
	% minimum error
	E(dy+1, dx+1) = NaN;
	[fy, fx] = find(E == min(E(:)));
	vx(iby, ibx) = fx(1) - (dx+1);
	vy(iby, ibx) = fy(1) - (dy+1);
    end
end
vy = -vy;
% motion vector filtering
f_vx = medfilt2(vx);
f_vy = medfilt2(vy);

    if (strcmp(seq,'coast'))
      % horizontal motion, so v_y is zero
         bi = ((sqrt(f_vx.^2+f_vy.^2)) >0.75*max(max((sqrt(f_vx.^2)))));
    elseif (strcmp(seq,'bike'))
         bi = ((sqrt(f_vy.^2+f_vx.^2)) == 2);
    elseif (strcmp(seq,'garden')) 
         bi = ((sqrt(f_vy.^2+f_vx.^2)) >1.5);
    elseif (strcmp(seq,'tennis'))
        % vertical motion
         bi = ((sqrt(f_vy.^2+f_vx.^2)) >2);
        % the tennis ball has zero velocity for an instance at the point where the direction of motion changes
    end

    % thresholds were chosen after trials

bi=1/2*bi;                                                             % threshold adjustments to detect ptoperly moving objects
object=zeros(b(1)*nby,b(2)*nbx);

    for i=1:(b(1)*nby-1)
        for j=1:(b(2)*nbx-1)
            object(i,j)= bi(floor(i/b(1)+1),floor(j/b(2)+1));
        end
    end

end

function f = adpmedian(g, smax)

% check maximum window size smax
if (smax <= 1) || (smax ~= round(smax)) || (smax/2 == round(smax/2))
	error('SMAX must be an odd integer > 1.')
end

% initialization
f = g;
f(:) = 0;
processed = false(size(g));

% loop over window sizes
for k = 3:2:smax

	% local minimum, maximum and median values
	zmin = ordfilt2(g, 1,     ones(k), 'symmetric');
	zmax = ordfilt2(g, k^2,   ones(k), 'symmetric');
	zmed = medfilt2(g, [k k],          'symmetric');

	% choose positions to process
	level_b  = (zmed > zmin) & (zmax > zmed) & ~processed;
	z        = (g    > zmin) & (zmax > g);
	out_z    = level_b & z;
	out_zmed = level_b & ~z;

	% output in these positions
	f(out_z)    = g(out_z);
	f(out_zmed) = zmed(out_zmed);

	% stop if no changes made
	processed = processed | level_b;
	if all(processed(:)) break; end
end

% assign median value to all unprocessed positions
f(~processed) = zmed(~processed);

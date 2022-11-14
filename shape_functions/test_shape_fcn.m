clear

fcn = @(x) sqrt(x+2);

% data for roughly discretized 'boundary'
xrange = [-1,10];
dx = 1;
x = xrange(1):dx:xrange(2);
y = fcn(x);

% finely discretized for comparison
xtrue = xrange(1):dx*.05:xrange(2);
ytrue = fcn(xtrue);

% shape function discretization
nnode = 3;
Nint = 3;

% gauss points
[xigp, wggp] = legpts1(Nint);
% xigp = linspace(-1,1,Nint);

% shape functions and their derivatives at GPs
[NJGP]  = funf1(xigp,nnode);
[DNJGP] = dfunf1(xigp,nnode);

% selection of coordinates
ni = 0;
elcon = (1:nnode) + ni;
xvals = x(elcon)';
yvals = y(elcon)';

% interpolation
xint = sum(NJGP.*xvals);
yint = sum(NJGP.*yvals);
dx_int = sum(DNJGP.*xvals);
dy_int = sum(DNJGP.*yvals);

J = sqrt(dx_int.^2 + dy_int.^2);

% integration (dx)
auc = sum(wggp.*yint);

% plotting
xstart = x(elcon(1));
xend = x(elcon(end));

% transformation to true coordinates (not necessary)
xplot = (xigp + 1) * (xend - xstart)/2 + xstart;

figure
plot(xint, yint, 'k.')
xlabel('x')
ylabel('y')
title('Interpolated x and y values showing gauss point distribution')

figure
plot(xigp, yint)
xlabel('intrinsic coordinates')
title('Interpolated y values plotted on intrinsic coordinates')

figure
hold on
plot(xint, yint, 'linewidth', 2)
plot(x,y, 'k.', 'MarkerSize', 20)
plot(xtrue, ytrue, 'linewidth', 3', 'color', 'green', 'LineStyle','--')
legend('Interpolated', 'Original', 'True')
xlim([xstart, xend])
xlabel('True coordinates')
title('Interpolated function compared with true')


% plot(xcord, interpolate, 'ko');
% [DNJGP] = dfunf1(xigp,nnode);
% Link to paper describing math: https://drive.google.com/file/d/1AJ7yp8tUqKM4d6FwEOTUtba8EjQ4SX4G/view

% Fargie, D. and Martin, B. (1971). Developing laminar flow in a pipe of 
% circular cross-section. Proceedings of the Royal Society of London. A. 
% Mathematical and Physical Sciences, 321(1547), pp.461-476.


% ************************************************************* %

% Press "Run" to see animation
% Change m, n, t_step, or t_end however you like

% ************************************************************* %

%% Set up simulation variables. Calculate matrix of positions and velocity 'u'
clear 

m = 30; % number of discrete radial steps
n = 100; % number of axial solutions
t_step = .1; % Define length of time between calculated shapes
t_end = .8; % Define duration of simulation

% alpha is the dimensionless radius of the inviscid core of flow
% alpha = 1 upon entry into tube and approaches 0 as it travels through
alpha_range = linspace(0.015, 1, n);

% The X vector will store the positions of the fastest moving part of the
% flow
X = zeros(n, 1)';

% The u matrix will store the velocity of m steps along the radius at n
% steps along the length of the tube
u = zeros(m, n);

% This equation is modified from equation 21 in Fargie (excludes reynolds number and
% diameter). x is a stand-in for alpha, and this equation relates alpha to
% distance along the tube.
fun = @(x) 0.25 * ((1-x).*(6+x).*(1+4.*x+9.*x.^2+4.*x.^3))./(5.*x.*(3+2.*x).*(3+2.*x+x.^2).^2);

% Initialize constants for smoke flow - these are estimated from our
% experimental setup
rho = 1.1644; % kg/m3
d = .019; % diameter m
v_0 = 0.15; % velocity m/s
mu = .0000186; % viscocity Pa-s
re = rho*v_0*d/mu; % Reynolds number 

% Establish counters to be used in for loop
rads = linspace(0, d/2, m);
n_counter = 1;


for n = alpha_range
% Find the position corresponding with each value of alpha - store in X
    q = integral(fun,n,1);
    X(n_counter) = q * re * d;

% phi is the unitless velocity of the fastest moving part of the flow at a
% certain value of alpha - equation 10 in Fargie
    phi = 6 / (3 + 2*n + n^2);
    
% Get u matrix
    m_counter = 1;
    for r = rads

% Here, alpha works to bound AND define the velocity profile. Scale by
% initial velocity to add units. See equation 9 in Fargie
        if (r/(d/2) >= 0 && r/(d/2) <= n)
            u(m_counter, n_counter) = phi * v_0;
        elseif (r/(d/2) > n && r/(d/2) <= 1)
            u(m_counter, n_counter) = phi*(1-((r/(d/2) - n)/(1- n))^2) * v_0;
        end
        m_counter = m_counter + 1;        
    end
    n_counter = n_counter + 1;
end

%% Calculate positions across time steps

t_num = floor(t_end / t_step); % Calculate number of time steps

% Start time one step after 0
time = t_step;

% Position matrix - columns contain position down the length of the tube
% across a range of radii. Each column represents a different time step.
% First row is at r=0 and is the fastest part of the flow. First column is
% always zero and doesn't contribute to calculations, so matrix includes
% one extra column.
p = zeros(m, t_num + 1);

% use this to check where we are in p
% Start at 2 to skip first
counter = 2; 

while time < t_end
    
% p(1, counter-1) is the furthest along point. This determines which
% velocities to use
    dist = abs(X - p(1, counter-1)); 
    minDist = min(dist);
    n_x = find(dist == minDist);

% Get velocity for every radial position corresponding to the current
% position. Use it to calculate change in position at this step.
    speeds = u(:, n_x);
    xdiff = t_step * speeds;
    
% Define current positions using previous positions and xdiff
    p(:,counter) = p(:, counter-1) + xdiff;

    counter = counter + 1;
    time = time + t_step;
end



%% Animate shape
% This can take a while to run depending on the size of p

for num = 1:size(p,2)-1
    clf;
    sample = p(:, num);

    for el = 1:length(rads)
        hold on
        axis([0 .3 -.02 .02])
        axis equal
        plot(sample(el), rads(el), 'k.')
        plot(sample(el), -rads(el), 'k.')
    end
    pause(.01)
end


%% Plot velocity profile at a single position 
target_x = .15;

% These next lines make the plot- uncomment them to see it

% figure
% axis equal
% axis([0 0.05 -d/2 d/2])
% pluto(target_x, X, u, rads)

% Visualize velocity field
function pluto (target, X, u, rads)
% target is the position at which you want to plot velocity
% X is the vector containing every position with a solution
% u is a matrix containing a column of velocities at every position
% rads is a vector with every radial position to plot

% Find the index in X of the position closest to the one you want to
% investigate
    dist = abs(X - target);
    minDist = min(dist);
    n_x = find(dist == minDist);


    x_position = X(n_x); 
    speeds = u(:, n_x);
    
    
    hold on
    for index = 1:length(speeds)
        vector = speeds(index)*x_position;
        y = rads(index);
%         quiver(nearest, y, vector, 0, 'AutoScale', 'off', 'MaxHeadSize', 0)
%         quiver(nearest, -y, vector, 0, 'AutoScale', 'off', 'MaxHeadSize', 0)
        quiver(0, y, vector, 0, 'AutoScale', 'off', 'MaxHeadSize', 0)
        quiver(0, -y, vector, 0, 'AutoScale', 'off', 'MaxHeadSize', 0)

    end
    
    
end
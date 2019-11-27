function [linepar, acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)                    

acc = zeros(nrho, ntheta);
thetas = linspace (-pi/2, pi/2, ntheta);

[x_dim, y_dim] = size(magnitude);
D = sqrt(x_dim^2 + y_dim^2);
rhos = linspace(-D, D, nrho);

% Loop over all the input curves (cf. pixelplotcurves)
insize = size(curves, 2);
trypointer = 1;
while trypointer <= insize
    polylength = curves(2, trypointer);    
    trypointer = trypointer + 1;
    
    % For each point on each curve
    for polyidx = 1:polylength
        x = curves(2, trypointer);
        y = curves(1, trypointer);
        
        % Check if valid point with respect to threshold
        if (magnitude(round(x), round(y)) - threshold) > 0
            for theta_index = 1 : ntheta
                rho = x*cos(thetas(theta_index)) + y*sin(thetas(theta_index));
                rho_index = find(rhos < rho, 1, 'last');
                
%                 acc(rho_index, theta_index) = acc(rho_index, theta_index) + 1;
                % Question 10
                acc(rho_index, theta_index) = acc(rho_index, theta_index) + magnitude(round(x), round(y));
            end
        end
        trypointer = trypointer + 1;
    end
end

% Extract local maxima from the accumulator
[pos, value] = locmax8(acc) ;
[dummy, indexvector] = sort(value);
nmaxima = size(value, 1);
% Delimit the number of responses if necessary
% Compute a line for each one of the strongest responses in the accumulator
% Overlay these curves on the posgradient magnitude image
% Return the output data

linepar = [];

if ~(nlines > 0) 
    nlines = length(value);
end

for index = 1 : nlines
    rho_index = pos(indexvector(nmaxima - index + 1), 1);
    theta_index = pos(indexvector(nmaxima - index + 1), 2);
    
    rho = rhos(rho_index);
    theta = thetas(theta_index);
    
    linepar = [linepar [rho, theta]'];
    
    % Conversion from polar to cartesian coordinates
    x0 = rho*cos(theta);
    y0 = rho*sin(theta);
    
    % Lines are draw from (x0-dx, y0-dy) to (x0+dx, y0+dy), by multiplying
    % with D the line length is equal to the diagonal of the image
    dx = D*sin(theta);
    dy = D*(-cos(theta));
    
    outcurves(1, 4*(index-1) + 1) = 0; % level, not significant
    outcurves(2, 4*(index-1) + 1) = 3; % number of points in the curve
    outcurves(2, 4*(index-1) + 2) = x0-dx;
    outcurves(1, 4*(index-1) + 2) = y0-dy;
    outcurves(2, 4*(index-1) + 3) = x0;
    outcurves(1, 4*(index-1) + 3) = y0;
    outcurves(2, 4*(index-1) + 4) = x0+dx;
    outcurves(1, 4*(index-1) + 4) = y0+dy;
end

figure(3)
subplot(121)
overlaycurves(magnitude, outcurves);
axis([1 size(magnitude, 2) 1 size(magnitude, 1)]);
subplot(122)
showgrey(acc)

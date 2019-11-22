function [linepar acc] = houghline(curves, magnitude, nrho, ntheta, ...
                                   threshold, nlines, verbose)
% Check if input appear to be valid
% Allocate accumulator space
% Define a coordinate system in the accumulator space
% Loop over all the input curves (cf. pixelplotcurves)
% For each point on each curve
% Check if valid point with respect to threshold
% Optionally, keep value from magnitude image
% Loop over a set of theta values
% Compute rho for each theta value
% Compute index values in the accumulator space
% Update the accumulator
% Extract local maxima from the accumulator
% Delimit the number of responses if necessary
% Compute a line for each one of the strongest responses in the accumulator
% Overlay these curves on the gradient magnitude image
% Return the output data                      

acc = zeros(nrho, ntheta);

thetas = linspace(0, pi, ntheta);

% for curve in curves:
for x = 1 : size(curves, 1)
    curve = curves(x, :);
    
    % for ptn in curve:
    for y = 1 : length(curve)
        ptn = curve(y);
        
        if (ptn - threshold) > 0:
            
            % for theta in thetas:
            for theta = thetas
                rho = x*cos(theta) + y*sin(theta);
                
                acc(rho, theta) = acc(rho, theta) + 1;
                
            end
        end
    end
end
    
acc
        
        
            
            

            
% [pos, value] = locmax8(acctmp);
% [dummy, indexvector] = sort(value);
% nmaxima = size(value, 1);



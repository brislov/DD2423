function pixels = gaussfft(pic,t)
 
% Discretization of the Gaussian function in the spatial domain
[xsize, ysize] = size(pic);
[x, y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);

G = 1/(2*pi*t)*exp(-(x.^2+y.^2)/(2*t));

% Apply Fourier transform on both G and F(=pic) to perform pointwise
% multiplication in the Fourier domain to apply the Gaussian filter
Fhat = fft2(pic);
Ghat = fft2(G);

Hhat = Fhat.*Ghat; 

pixels = fftshift(ifft2(Hhat));

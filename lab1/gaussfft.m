function re = gaussfft(pic,t)
   
% t - variance

f = pic;

[usize, vsize] = size(pic);

umax = usize/2;
vmax = vsize/2;
[u, v] = meshgrid(umax-usize:umax-1,vmax-vsize:vmax-1);

for x = 1:usize
    for y = 1:vsize
        u(x,y) = 1/(2*pi*t)*exp(-(x^2+y^2)/(2*t));
        v(x,y) = 1/(2*pi*t)*exp(-(x^2+y^2)/(2*t));
    end
end

g = u+v;

fhat = fft2(f);
ghat = fft2(g);

hhat = fhat.*ghat;

re = ifft2(hhat);
end 



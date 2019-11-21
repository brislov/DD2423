function pixels = Lv(inpic, shape)
if nargin < 2
    shape = 'same';
end

% Sobel operator
dxmask = [-1 0 1; -2 0 2; -1 0 1];
dymask = [-1 -2 -1; 0 0 0; 1 2 1];

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);

pixels = Lx.^2 + Ly.^2;

function answ = Lvvtilde(inpic, shape)

Dx = [-1/2 0 1/2];
Dy = [-1/2; 0; 1/2];

Lx = filter2(Dx, inpic, shape);
Ly = filter2(Dy, inpic, shape);

Lxx = filter2(Dx, Lx, shape);
Lxy = filter2(Dy, Lx, shape);
Lyy = filter2(Dy, Ly, shape);

answ = Lx.^2.*Lxx + 2.*Lx.*Ly.*Lxy + Ly.^2.*Lyy;

% a = zeros(5);
% a(3, 2:4) = Dx;
% a(2:4, 3) = Dy;

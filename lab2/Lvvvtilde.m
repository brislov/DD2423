function answ = Lvvvtilde(inpic, shape)

Dx = zeros(5);
Dy = zeros(5);

Dx(3, 2:4) = [-1/2 0 1/2];
Dy(2:4, 3) = [-1/2; 0; 1/2];

Lx = filter2(Dx, inpic, shape);
Ly = filter2(Dy, inpic, shape);

Lxx = filter2(Dx, Lx, shape);
Lyy = filter2(Dy, Ly, shape);

Lxxx = filter2(Dx, Lxx, shape);
Lxxy = filter2(Dy, Lxx, shape);
Lyyx = filter2(Dx, Lyy, shape);
Lyyy = filter2(Dy, Lyy, shape);

answ = Lx.^3.*Lxxx + 3.*Lx.^2.*Ly.*Lxxy + 3.*Lx.*Ly.^2.*Lyyx + Ly.^3.*Lyyy; 

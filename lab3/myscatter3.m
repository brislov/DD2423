function myscatter3(I, RS)
if RS
    [nrows, ncols] = size(I, 1, 2);
    I = double(reshape(I, [nrows*ncols 3]));
end

X = I(:, 1);
Y = I(:, 2);
Z = I(:, 3);

S = 100;
C = I/255;

scatter3(X, Y, Z, S, C)
end
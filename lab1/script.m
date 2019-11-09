clear

% Questions 1-6
% pValues = [5 9 17 17 5 125];
% qValues = [9 5 9 121 1 1];
% 
% if size(pValues, 2) ~= size(qValues, 2)
%     error('pValues & qValues are not the same length')
% end
% 
% for i = 1:length(pValues)
%     fftwave(pValues(i), qValues(i), 128)
%     waitforbuttonpress
% end


% Questions 7-
sz = 128;

F = [zeros(56, sz); ones(16, sz); zeros(56, sz)];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

% subplot(331)
% showgrey(F)
% subplot(334)
% showgrey(log(1 + abs(Fhat)))
% 
% subplot(332)
% showgrey(G)
% subplot(335)
% showgrey(log(1 + abs(Ghat)))
% 
% subplot(333)
% showgrey(H)
% subplot(336)
% showgrey(log(1 + abs(Hhat)))
% 
% subplot(339)
% showgrey(log(1 + abs(fftshift(Hhat))))

subplot(221)
showgrey(F.*G)
subplot(223)
showfs(fft2(F.*G))
subplot(222)
% showgrey(ifft2(conv2(Fhat,Ghat)))
subplot(224)
showfs(fftshift(conv2(Fhat,Ghat)/sz))


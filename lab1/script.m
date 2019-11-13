clear

% 1 Properties of the discrete Fourier transform

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


% Questions 7-9
% sz = 128;
% 
% F = [zeros(56, sz); ones(16, sz); zeros(56, sz)];
% G = F';
% H = F + 2 * G;
% 
% Fhat = fft2(F);
% Ghat = fft2(G);
% Hhat = fft2(H);

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


% Question 10 
% figure(1)
% subplot(121)
% showgrey(F.*G)
% title('F.*G')
% subplot(122)
% showfs(fft2(F.*G))
% title('fft2(F.*G)')
% 
% figure(2)
% subplot(121)
% c = conv2(Fhat, Ghat)/sz.^2;
% showfs(c(1:sz, 1:sz));
% title('conv2(Fhat, Ghat)/sz.^2')


% Question 11
% F2 = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
%      [zeros(128, 48) ones(128, 32) zeros(128, 48)];
% 
% subplot(221)
% showgrey(F.*G)
% subplot(222)
% showfs(fft2(F.*G))
% subplot(223)
% showgrey(F2)
% subplot(224)
% showfs(fft2(F2))


% Question 12
% i = 0;
% alphas = [0 30 45 60 90];
% for alpha = alphas
%     G = rot(F,alpha);
%     
%     i = i+1;
%     subplot(length(alphas),3,i)
%     showgrey(G)
%     axis on
%     title(sprintf('G, %i deg', alpha))
%     
%     i = i+1;
%     subplot(length(alphas),3,i)
%     Ghat = fft2(G);
%     showfs(fft2(G))
%     title(sprintf('Ghat, %i deg', alpha))
%     
%     i = i+1;
%     subplot(length(alphas),3,i)
%     Hhat = rot(fftshift(Ghat),-alpha);
%     showgrey(log(1+abs(Hhat)))
%     title(sprintf('Hhat, 0 deg'))
% end 


% Question 13
% a = 10^-10;
% 
% i = 0;
% titles = {'phonelcalc128' 'few128' 'nallo128'};
% images = {phonecalc128 few128 nallo128};
% for m = 1:length(images)
%     i = i+1;
%     subplot(length(images),3,i)
%     showgrey(images{m})
%     title(titles{m})
%     
%     i = i+1;
%     subplot(length(images),3,i)
%     showgrey(pow2image(images{m},a))
%     title('pow2image()')
%     
%     i = i+1;
%     subplot(length(images),3,i)
%     showgrey(randphaseimage(images{m}))
%     title('randphaseimage()')
% end



% 2 Gaussian convolution implemented via FFT

% Questions 14-15
% i = 0;
% for t = [0.1 0.3 1.0 10.0 100.0]
%     i = i+1;
%     subplot(3,3,i)
%     psf = gaussfft(deltafcn(128,128),t);
%     showgrey(psf)
%     title(sprintf('t = %.1f',t))
%     
%     covariance = variance(psf)
% end

% Question 16
% i = 0;
% for t = [1.0 4.0 16.0 64.0 256]
%     i = i+1;
%     subplot(5,3,i);
%     showgray(gaussfft(phonecalc256,t))
%     
%     i = i+1;
%     subplot(5,3,i);
%     showgray(gaussfft(office256,t))
%     title(sprintf('t = %.1f',t))
%     
%     i = i+1;
%     subplot(5,3,i);
%     showgray(gaussfft(suburb256,t))
% end



% 3 Smoothing

% Questions 17-18
% office = office256;
% 
% add = gaussnoise(office,16);
% sap = sapnoise(office,0.1,255);

% subplot(131)
% showgrey(office)
% title('no added noise')
% subplot(132)
% showgrey(add)
% title('gaussnoise(office,16)')
% subplot(133)
% showgrey(sap)
% title('sapnoise(office,0.1,255)')

% ncol = 4;
% nrow = 1;
% 
% img = add;
% subplot(nrow,ncol,1)
% showgrey(img)
% 
% subplot(nrow,ncol,2)
% showgrey(gaussfft(img,1))
% 
% subplot(nrow,ncol,3)
% showgrey(medfilt(img,4))
% 
% subplot(nrow,ncol,4)
% showgrey(ideal(img,0.5,'l'))

% Gaussian smoothing
% img = add;
% 
% i = 1;
% ncol = 3;
% nrow = 2;
% 
% subplot(nrow,ncol,i)
% showgrey(img)
% title('add')
% 
% for t = [1.0 4.0 16.0 64.0 256]
%     i = i+1;
%     subplot(nrow,ncol,i)
%     showgray(gaussfft(img,t))
%     title(sprintf('t = %.1f',t))
% end

% Median filtering
% img = sap;
% 
% i = 1;
% ncol = 3;
% nrow = 2;
% 
% subplot(nrow,ncol,i)
% showgrey(img)
% title('sap')
% 
% for m = [2 4 6 12 24]
%     i = i+1;
%     subplot(nrow,ncol,i)
%     showgray(medfilt(img,m))
%     title(sprintf('m = %i',m))
% end

% Ideal low-pass filter
% img = add;
% 
% i = 1;
% ncol = 3;
% nrow = 2;
% 
% subplot(nrow,ncol,i)
% showgrey(img)
% title('add')
% 
% for cutoffFreq = [0.05 0.15 0.2 0.25 0.35]
%     i = i+1;
%     subplot(nrow,ncol,i)
%     showgrey(ideal(img,cutoffFreq,'l'))
%     title(sprintf('%.2f',cutoffFreq))
% end
    

% Questions 19-20
% img = phonecalc256;
% smoothimggauss = img;
% smoothimgideal = img;
% N=5;
% for i=1:N
%     figure(1)
%     if i>1 % generate subsampled versions
%         img = rawsubsample(img);
%         smoothimggauss = gaussfft(smoothimggauss, 1);% <call_your_filter_here>(smoothimg, <params>);
%         smoothimgideal = ideal(smoothimgideal, 0.3);% <call_your_filter_here>(smoothimg, <params>);
%         smoothimggauss = rawsubsample(smoothimggauss);
%         smoothimgideal = rawsubsample(smoothimgideal);
%     end
%     subplot(3, N, i)
%     showgrey(img)
%     subplot(3, N, i+N)
%     showgrey(smoothimggauss)
%     subplot(3, N, i+N+N)
%     showgrey(smoothimgideal)
%     
%     if i==4
%         figure(2)
%         subplot(131)
%         showgrey(img)
%         subplot(132)
%         showgrey(smoothimggauss)
%         subplot(133)
%         showgrey(smoothimgideal)
%     end
% end

function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)

curves = extractedge(pic, scale, gradmagnthreshold, 'same');
magnitude = Lv(pic);

if verbose >= 1
    figure(1)
    subplot(131)
    showgrey(pic)
    subplot(132)
    histogram(magnitude)
    subplot(133)
    showgrey(Lv(pic))
end

if verbose >= 2
    figure(2)
    overlaycurves(pic, curves)
end

[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);



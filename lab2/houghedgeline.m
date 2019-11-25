function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
                                       nrho, ntheta, nlines, verbose)

curves = extractedge(pic, scale, gradmagnthreshold, 'same');
magnitude = Lv(pic);

if verbose >= 1
    overlaycurves(pic, curves)
end

[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);

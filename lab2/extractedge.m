function edgecurves = extractedge(inpic, scale, threshold, shape)

Lv1 = Lv(discgaussfft(inpic, scale), shape);
Lvv = Lvvtilde(discgaussfft(inpic, scale), shape);
Lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);

Lv_mask = (Lv1 > threshold) - 0.5;
Lvvv_mask = (Lvvv < 0) - 0.5;

edgecurves = zerocrosscurves(Lvv, Lvvv_mask);
edgecurves = thresholdcurves(edgecurves, Lv_mask);

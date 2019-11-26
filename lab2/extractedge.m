function edgecurves = extractedge(inpic, scale, threshold, shape)

pic = discgaussfft(inpic, scale);

Lv1 = Lv(pic, shape);
Lvv = Lvvtilde(pic, shape);
Lvvv = Lvvvtilde(pic, shape);
 
Lv_mask = (Lv1 > threshold) - 0.5;
Lvvv_mask = (Lvvv < 0) - 0.5;

edgecurves = zerocrosscurves(Lvv, Lvvv_mask);
edgecurves = thresholdcurves(edgecurves, Lv_mask);

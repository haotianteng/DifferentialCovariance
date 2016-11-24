V = 1:0.1:40;
a_rep = 10^3;
b_rep = 10^1;
G_rep = 1*a_rep./sqrt(pi)*exp(-(V-30).^2);
f_rep = 120./(1+exp(-b_rep*(G_rep-0.1)));

figure;
subplot(211),plot(V,G_rep);
subplot(212),plot(V,f_rep);
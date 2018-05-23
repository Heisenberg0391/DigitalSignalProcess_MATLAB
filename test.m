N = 500;
n=(2*pi/N):(2*pi/N):2*pi;
x = cos(n);
y = -cos(n);
[rxx,lagxx] = xcorr(x,y,'biased');
rxx = rxx(N:end);
plot(rxx);
hold on 
plot(x);
hold on 
plot(y);
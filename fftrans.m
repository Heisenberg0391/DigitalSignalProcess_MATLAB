close all
clc
N=32;                         %原离散信号有8点
n=[0:1:N-1];                  %原信号是1行8列的矩阵
xn=0.5.^n;                   %构建原始信号，为指数信号

Xk=fft(xn,N);         %求fft变换
Xks=fftshift(Xk);

subplot(3,1,1);
stem(n,xn);
title('原始信号(指数信号)');

subplot(3,1,2);
stem(n,abs(Xk))
title('FFT变换')

subplot(3,1,3);
stem(n,abs(Xks))
title('FFTShift变换')


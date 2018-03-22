close all
clc
N=32;                         %ԭ��ɢ�ź���8��
n=[0:1:N-1];                  %ԭ�ź���1��8�еľ���
xn=0.5.^n;                   %����ԭʼ�źţ�Ϊָ���ź�

Xk=fft(xn,N);         %��fft�任
Xks=fftshift(Xk);

subplot(3,1,1);
stem(n,xn);
title('ԭʼ�ź�(ָ���ź�)');

subplot(3,1,2);
stem(n,abs(Xk))
title('FFT�任')

subplot(3,1,3);
stem(n,abs(Xks))
title('FFTShift�任')


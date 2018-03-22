close all
clc
N=8;                         %原离散信号有8点
n=[0:1:N-1];                 %原信号是1行8列的矩阵
xn=0.5.^n;                   %构建原始信号，为指数信号
 
w=[-8:1:8]*2*pi/8;     %频域共-2π----+2π 的长度（本应是无穷，高频分量很少，故省去）    
X=xn*exp(-1i*(n'*w));         %求dft变换，采用原始定义的方法，对复指数分量求和而得
subplot(3,1,1)
stem(n,xn);
w1=[-4:1:4]*4*pi/4;
X1=xn*exp(-1i*(n'*w1));
title('原始信号(指数信号)');
subplot(3,1,2);
stem(w/pi,abs(X));
title('原信号的16点DFT变换')
subplot(3,1,3)
stem(w1/pi,abs(X1));
title('原信号的8点DFT变换')
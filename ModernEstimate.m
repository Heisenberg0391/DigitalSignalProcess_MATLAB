% 现代谱估计  
clear
clc
close all
%1. 生成信号
fs = 1000;
N = 1000;
T = N/fs;
n=1/fs:1/fs:T;
% 高斯白噪声w(n)
var = 1;
noise = normrnd(0,sqrt(var),1,N);% 均值，标准差，start, end
% 正弦信号
A = 1*var;
w1 = 2*pi*100;
sig1 = A*sin(w1*n);
B = 1000*var;
w2 = 2*pi*110;
sig2 = B*sin(w2*n);
x = sig1+sig2+noise;
plot(x)

%2. 谱估计
p = 500;
%（1）自相关法
Pxx = pyulear(x,p,N);%pyulear(X,ORDER,NFFT) 
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure;
plot(Pxx);
title('自相关法');
grid on
%（2）burg法
Pxx = pburg(x,p);%pyulear(X,ORDER) 
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure;
plot(Pxx);
title('burg法');
grid on
%(3)协方差法
Pxx = pcov(x,p);
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure
plot(Pxx);
title('协方差法');
grid on
%(4)修正协方差法
Pxx = pmcov(x,p);
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure
plot(Pxx);
title('修正协方差法');
grid on


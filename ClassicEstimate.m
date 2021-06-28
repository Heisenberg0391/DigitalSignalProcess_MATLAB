%经典谱估计           
clear
clc
close all

% 1.生成观测信号
N = 256;   %样本点数

% 高斯白噪声w(n)
var = 1;
noise = normrnd(0,sqrt(var),1,N);% 均值，标准差，start, end

% 观测信号x(n)
x = [];
for n=1:N
    x = [x sample(n, noise)];
end


% 2. 求x(n)的理想功率谱
syms z
Hz = z/(z-0.8);
b=[1 0];
a=[1 -0.8];%输入系统的系数矩阵
[X,w]=freqz(b,a);
% plot(w/pi,abs(X));
Sxx = abs(X).^2*var;

 % 3. 周期图法
% 功率谱
Pxx = fft(x, N);
Pxx = (abs(Pxx).^2)/N;
Pxx = fftshift(Pxx);
% 4. Bartlett平均周期图法
L = 8;
M = N/L;
P = 0;
for i = 1:L
    Pesti = fft(x, N);
    I = (abs(Pesti).^2)/M;
    P = P + I;
end
P = P/L;
P = fftshift(P);
%5. 绘图
figure;
plot(x)
title('观测信号');
figure;
plot(Sxx);
title('理想功率谱');
figure;
plot(Pxx(N/2+1:end));
title('周期图谱');
figure;
plot(P(N/2+1:end));
title('Bartlett');


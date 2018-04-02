% 1.生成观测信号
N = 500; %样本点数
% 变量
r=1;
n=0.004*pi:0.004*pi:2*pi;
% 噪声
noise_x = normrnd(0,sqrt(0.05),1,N);
noise_y = normrnd(0,sqrt(0.06),1,N);
% 绘制噪声信号
figure;
subplot(1,2,1);
plot(noise_x);
title('x方向噪声');
subplot(1,2,2);
plot(noise_y);
title('y方向噪声');
% 观测信号
x = r*cos(n) + noise_x;
y = r*sin(n) + noise_y;
% 绘制观测信号
figure;
subplot(1,2,1);
plot(x);
title('x方向观测');
subplot(1,2,2);
plot(y);
title('y方向观测');
% 期望信号
xd = r*cos(n);
yd = r*sin(n);
% 绘制期望信号
figure;
subplot(1,2,1);
plot(xd);
title('x方向期望');
subplot(1,2,2);
plot(yd);
title('y方向期望');

%2. 明确期望信号和观测信号
% 求观测信号自相关
[rxx,lagxx] = xcorr(x,'biased');
rxx = rxx(N:end)'; %取正半轴
[ryy,lagyy] = xcorr(y,'biased');
ryy = ryy(N:end)';
% 求相关矩阵
M = 400;
Rxx = ones(M,M);
Rxx(:,1) = rxx(1:M);
Ryy = ones(M,M);
Ryy(:,1) = ryy(1:M);
for i=2:M
    %rxx(i)
    %Rxx(1:M-i,i-1)
    Rxx(:,i) = [rxx(i);Rxx(1:M-1,i-1)];
    Ryy(:,i) = [ryy(i);Ryy(1:M-1,i-1)];
end
%求互相关
[rxd,lagxd] = xcorr(x,xd,'biased');
rxd = rxd(N:end)';
[ryd,lagyd] = xcorr(y,yd,'biased');
ryd = ryd(N:end)';

Rxd = rxd(1:M,1);
Ryd = ryd(1:M,1);
%得到维纳滤波器
hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
hopt_y=(Ryy)\Ryd;
%滤波
filt_x = conv(x,hopt_x);
sigx = filt_x(1:N);
filt_y = conv(y,hopt_y);
sigy = filt_y(1:N);
% 绘制滤波信号
figure;
subplot(1,2,1);
plot(sigx);
title('x方向滤波');
subplot(1,2,2);
plot(sigy);
title('y方向滤波');

%3.绘制结果
figure;
title('观测、期望和滤波信号')
plot(x, y, '*b')
hold on
plot(xd, yd, 'og')
hold on
plot(sigx,sigy,'xr');
axis equal
% 求均方误差

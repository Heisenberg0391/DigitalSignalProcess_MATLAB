% 20180402张磊
% 现代数字信号处理第一次上机作业
% 请将experiment.m、findM.m和MyPlot.m
% 放在同一路径，然后运行experiment.m                        
clear
clc
close all

% 1.生成观测信号
N = 500; %样本点数
% 变量
r=1;
n=(2*pi/N):(2*pi/N):2*pi;
% 高斯白噪声
noise_x = normrnd(0,sqrt(0.05),1,N);
noise_y = normrnd(0,sqrt(0.06),1,N);

% 观测信号
x = r*cos(n) + noise_x;
y = r*sin(n) + noise_y;
% 期望信号
xd = r*cos(n);
yd = r*sin(n);

% 2. 求观测信号自相关
[rxx,lagxx] = xcorr(x,'biased');
rxx = rxx(N:end)'; %取正半轴
[ryy,lagyy] = xcorr(y,'biased');
ryy = ryy(N:end)';

% 求相关矩阵
[Mopt,MSElist] = findM(rxx,ryy,x,xd,y,yd,N);% 找到最优序列长度
Rxx = ones(Mopt,Mopt);
Rxx(:,1) = rxx(1:Mopt);
Ryy = ones(Mopt,Mopt);
Ryy(:,1) = ryy(1:Mopt);
for i=2:Mopt
    Rxx(:,i) = [rxx(i);Rxx(1:Mopt-1,i-1)];
    Ryy(:,i) = [ryy(i);Ryy(1:Mopt-1,i-1)];
end
%3. 求观测信号和期望信号的互相关
[rxd,lagxd] = xcorr(x,xd,'biased');
rxd = rxd(N:end)';
[ryd,lagyd] = xcorr(y,yd,'biased');
ryd = ryd(N:end)';

Rxd = rxd(1:Mopt,1);
Ryd = ryd(1:Mopt,1);
%4. 得到维纳滤波器最优解
hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
hopt_y=(Ryy)\Ryd;
%5. 滤波
filt_x = conv(x,hopt_x);
sigx = filt_x(1:N);
filt_y = conv(y,hopt_y);
sigy = filt_y(1:N);

%6. 求误差
errx = sigx-xd;
erry = sigy-yd;
% 求均方误差
MSEx = sum(errx.^2);
MSEy = sum(erry.^2);
MSEmin = 0.5*(MSEx+MSEy)
Mopt
%7. 绘图
MyPlot(noise_x,noise_y,x,y,xd,yd,sigx,sigy,errx,erry,MSElist,Mopt,MSEmin);

clear
clc
% 1.生成观测信号
N = 500; %样本点数
% 变量
r=1;
n=0.004*pi:0.004*pi:2*pi;
% 噪声
noise_x = normrnd(0,sqrt(0.05),1,N);
noise_y = normrnd(0,sqrt(0.06),1,N);

% 观测信号
x = r*cos(n) + noise_x;
y = r*sin(n) + noise_y;
% 期望信号
xd = r*cos(n);
yd = r*sin(n);

%2. 明确期望信号和观测信号
% 求观测信号自相关
[rxx,lagxx] = xcorr(x,'biased');
rxx = rxx(N:end)'; %取正半轴
[ryy,lagyy] = xcorr(y,'biased');
ryy = ryy(N:end)';
% 求相关矩阵
[Mopt,MSElist] = findM(rxx,ryy,x,xd,y,yd,N);
Rxx = ones(Mopt,Mopt);
Rxx(:,1) = rxx(1:Mopt);
Ryy = ones(Mopt,Mopt);
Ryy(:,1) = ryy(1:Mopt);
for i=2:Mopt
    %rxx(i)
    %Rxx(1:M-i,i-1)
    Rxx(:,i) = [rxx(i);Rxx(1:Mopt-1,i-1)];
    Ryy(:,i) = [ryy(i);Ryy(1:Mopt-1,i-1)];
end
%求互相关
[rxd,lagxd] = xcorr(x,xd,'biased');
rxd = rxd(N:end)';
[ryd,lagyd] = xcorr(y,yd,'biased');
ryd = ryd(N:end)';

Rxd = rxd(1:Mopt,1);
Ryd = ryd(1:Mopt,1);
%得到维纳滤波器
hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
hopt_y=(Ryy)\Ryd;
%滤波
filt_x = conv(x,hopt_x);
sigx = filt_x(1:N);
filt_y = conv(y,hopt_y);
sigy = filt_y(1:N);

%3求误差
errx = sigx-xd;
erry = sigy-yd;

% 求均方误差
MSEx = sum(errx.^2);
MSEy = sum(erry.^2);
MSEmin = 0.5*(MSEx+MSEy)
Mopt
%绘图
MyPlot(noise_x,noise_y,x,y,xd,yd,sigx,sigy,errx,erry,MSElist);
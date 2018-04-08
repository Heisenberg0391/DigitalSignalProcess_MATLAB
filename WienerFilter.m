% 20180402����
% �ִ������źŴ����һ���ϻ���ҵ
% �뽫experiment.m��findM.m��MyPlot.m
% ����ͬһ·����Ȼ������experiment.m                        
clear
clc
close all

% 1.���ɹ۲��ź�
N = 500; %��������
% ����
r=1;
n=(2*pi/N):(2*pi/N):2*pi;
% ��˹������
noise_x = normrnd(0,sqrt(0.05),1,N);
noise_y = normrnd(0,sqrt(0.06),1,N);

% �۲��ź�
x = r*cos(n) + noise_x;
y = r*sin(n) + noise_y;
% �����ź�
xd = r*cos(n);
yd = r*sin(n);

% 2. ��۲��ź������
[rxx,lagxx] = xcorr(x,'biased');
rxx = rxx(N:end)'; %ȡ������
[ryy,lagyy] = xcorr(y,'biased');
ryy = ryy(N:end)';

% ����ؾ���
[Mopt,MSElist] = findM(rxx,ryy,x,xd,y,yd,N);% �ҵ��������г���
Rxx = ones(Mopt,Mopt);
Rxx(:,1) = rxx(1:Mopt);
Ryy = ones(Mopt,Mopt);
Ryy(:,1) = ryy(1:Mopt);
for i=2:Mopt
    Rxx(:,i) = [rxx(i);Rxx(1:Mopt-1,i-1)];
    Ryy(:,i) = [ryy(i);Ryy(1:Mopt-1,i-1)];
end
%3. ��۲��źź������źŵĻ����
[rxd,lagxd] = xcorr(x,xd,'biased');
rxd = rxd(N:end)';
[ryd,lagyd] = xcorr(y,yd,'biased');
ryd = ryd(N:end)';

Rxd = rxd(1:Mopt,1);
Ryd = ryd(1:Mopt,1);
%4. �õ�ά���˲������Ž�
hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
hopt_y=(Ryy)\Ryd;
%5. �˲�
filt_x = conv(x,hopt_x);
sigx = filt_x(1:N);
filt_y = conv(y,hopt_y);
sigy = filt_y(1:N);

%6. �����
errx = sigx-xd;
erry = sigy-yd;
% ��������
MSEx = sum(errx.^2);
MSEy = sum(erry.^2);
MSEmin = 0.5*(MSEx+MSEy)
Mopt
%7. ��ͼ
MyPlot(noise_x,noise_y,x,y,xd,yd,sigx,sigy,errx,erry,MSElist,Mopt,MSEmin);

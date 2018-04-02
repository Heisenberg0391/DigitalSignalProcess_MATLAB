% 1.���ɹ۲��ź�
N = 500; %��������
% ����
r=1;
n=0.004*pi:0.004*pi:2*pi;
% ����
noise_x = normrnd(0,sqrt(0.05),1,N);
noise_y = normrnd(0,sqrt(0.06),1,N);
% ���������ź�
figure;
subplot(1,2,1);
plot(noise_x);
title('x��������');
subplot(1,2,2);
plot(noise_y);
title('y��������');
% �۲��ź�
x = r*cos(n) + noise_x;
y = r*sin(n) + noise_y;
% ���ƹ۲��ź�
figure;
subplot(1,2,1);
plot(x);
title('x����۲�');
subplot(1,2,2);
plot(y);
title('y����۲�');
% �����ź�
xd = r*cos(n);
yd = r*sin(n);
% ���������ź�
figure;
subplot(1,2,1);
plot(xd);
title('x��������');
subplot(1,2,2);
plot(yd);
title('y��������');

%2. ��ȷ�����źź͹۲��ź�
% ��۲��ź������
[rxx,lagxx] = xcorr(x,'biased');
rxx = rxx(N:end)'; %ȡ������
[ryy,lagyy] = xcorr(y,'biased');
ryy = ryy(N:end)';
% ����ؾ���
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
%�����
[rxd,lagxd] = xcorr(x,xd,'biased');
rxd = rxd(N:end)';
[ryd,lagyd] = xcorr(y,yd,'biased');
ryd = ryd(N:end)';

Rxd = rxd(1:M,1);
Ryd = ryd(1:M,1);
%�õ�ά���˲���
hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
hopt_y=(Ryy)\Ryd;
%�˲�
filt_x = conv(x,hopt_x);
sigx = filt_x(1:N);
filt_y = conv(y,hopt_y);
sigy = filt_y(1:N);
% �����˲��ź�
figure;
subplot(1,2,1);
plot(sigx);
title('x�����˲�');
subplot(1,2,2);
plot(sigy);
title('y�����˲�');

%3.���ƽ��
figure;
title('�۲⡢�������˲��ź�')
plot(x, y, '*b')
hold on
plot(xd, yd, 'og')
hold on
plot(sigx,sigy,'xr');
axis equal
% ��������

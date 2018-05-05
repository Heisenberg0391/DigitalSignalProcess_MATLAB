% 20180505����
% �ִ������źŴ���������ϻ���ҵ2
% �ִ��׹���  
clear
clc
close all
%1. �����ź�
fs = 1000;
N = 1000;
T = N/fs;
n=1/fs:1/fs:T;
% ��˹������w(n)
var = 1;
noise = normrnd(0,sqrt(var),1,N);% ��ֵ����׼�start, end
% �����ź�
A = 1*var;
w1 = 2*pi*100;
sig1 = A*sin(w1*n);
B = 1000*var;
w2 = 2*pi*110;
sig2 = B*sin(w2*n);
x = sig1+sig2+noise;
plot(x)

%2. �׹���
p = 500;
%��1������ط�
Pxx = pyulear(x,p,N);%pyulear(X,ORDER,NFFT) 
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure;
plot(Pxx);
title('����ط�');
grid on
%��2��burg��
Pxx = pburg(x,p);%pyulear(X,ORDER) 
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure;
plot(Pxx);
title('burg��');
grid on
%(3)Э���
Pxx = pcov(x,p);
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure
plot(Pxx);
title('Э���');
grid on
%(4)����Э���
Pxx = pmcov(x,p);
Pxx = 10*log10(Pxx);
Pmax = max(Pxx);
Pxx = Pxx-Pmax;
figure
plot(Pxx);
title('����Э���');
grid on


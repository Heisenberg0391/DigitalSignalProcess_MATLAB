% 20180505����
% �ִ������źŴ���������ϻ���ҵ1
% �����׹���           
clear
clc
close all

% 1.���ɹ۲��ź�
N = 256;   %��������

% ��˹������w(n)
var = 1;
noise = normrnd(0,sqrt(var),1,N);% ��ֵ����׼�start, end

% �۲��ź�x(n)
x = [];
for n=1:N
    x = [x sample(n, noise)];
end


% 2. ��x(n)�����빦����
syms z
Hz = z/(z-0.8);
b=[1 0];
a=[1 -0.8];%����ϵͳ��ϵ������
[X,w]=freqz(b,a);
% plot(w/pi,abs(X));
Sxx = abs(X).^2*var;

 % 3. ����ͼ��
% ������
Pxx = fft(x, N);
Pxx = (abs(Pxx).^2)/N;
Pxx = fftshift(Pxx);
% 4. Bartlettƽ������ͼ��
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
%5. ��ͼ
figure;
plot(x)
title('�۲��ź�');
figure;
plot(Sxx);
title('���빦����');
figure;
plot(Pxx(N/2+1:end));
title('����ͼ��');
figure;
plot(P(N/2+1:end));
title('Bartlett');


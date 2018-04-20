% 20180420����
% �ִ������źŴ���ڶ����ϻ���ҵ
% ����Ӧ�˲���                 
clear
clc
close all

% 1.���ɹ۲��ź�
T = (8*pi)/0.05;% �ź�����
N = double(int16(T)); %��������

% ����
A=5;
n=(T/N):(T/N):T;

% ��˹������
noise = normrnd(0,sqrt(5),int8(T/N),N);% ��ֵ����׼�start, end

% �۲��ź�
x = A*sin(0.05*n) + noise;
% �����ź�
d = A*sin(0.05*n);

% 2.����˲���
% ��ʼ���˲���
M = 50; % �˲����״�
W = randn(M,1);
% ������
alpha = 0.00001; % ѧϰ��
epoch = 1000; % ѧϰ����
% ��ʧ����
losses = [];
% ѵ����
trainX = [];
for n=1:N-M+1
    trainX(n,:) = x(n:n+M-1);
end

% ��ʼѵ��
for i = 1:epoch
    % �����
    pred = trainX*W;
    err = pred - d(1:N-M+1)';
    % ����ʧ
    loss = sum(err.^2)/(N-M+1);
    losses = [losses loss];
    % ���ݶ�
    gradient = trainX'*err;
    % ����Ȩ��
    W =  W - alpha*gradient;
end
plot(losses);
% 3.�˲�
y = conv(x, W);
y = y(1:N);
% 4.���ƽ��
figure;
title('�˲����');
legend
plot(y, 'r');
hold on
plot(x, 'b');
legend('�˲����', '�۲��ź�');

% plot(MSElist)
% 
% plot(MSElist)
% hold on
% plot(Mopt,MSE,'ro')
% 
% xlabel('�˲����״�')
% ylabel('�������')



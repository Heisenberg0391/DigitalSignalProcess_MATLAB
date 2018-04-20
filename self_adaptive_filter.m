% 20180420张磊
% 现代数字信号处理第二次上机作业
% 自适应滤波器                 
clear
clc
close all

% 1.生成观测信号
T = (8*pi)/0.05;% 信号周期
N = double(int16(T)); %样本点数

% 变量
A=5;
n=(T/N):(T/N):T;

% 高斯白噪声
noise = normrnd(0,sqrt(5),int8(T/N),N);% 均值，标准差，start, end

% 观测信号
x = A*sin(0.05*n) + noise;
% 期望信号
d = A*sin(0.05*n);

% 2.设计滤波器
% 初始化滤波器
M = 50; % 滤波器阶次
W = randn(M,1);
% 超参数
alpha = 0.00001; % 学习率
epoch = 1000; % 学习次数
% 损失函数
losses = [];
% 训练集
trainX = [];
for n=1:N-M+1
    trainX(n,:) = x(n:n+M-1);
end

% 开始训练
for i = 1:epoch
    % 求误差
    pred = trainX*W;
    err = pred - d(1:N-M+1)';
    % 求损失
    loss = sum(err.^2)/(N-M+1);
    losses = [losses loss];
    % 求梯度
    gradient = trainX'*err;
    % 更新权重
    W =  W - alpha*gradient;
end
plot(losses);
% 3.滤波
y = conv(x, W);
y = y(1:N);
% 4.绘制结果
figure;
title('滤波结果');
legend
plot(y, 'r');
hold on
plot(x, 'b');
legend('滤波结果', '观测信号');

% plot(MSElist)
% 
% plot(MSElist)
% hold on
% plot(Mopt,MSE,'ro')
% 
% xlabel('滤波器阶次')
% ylabel('均方误差')



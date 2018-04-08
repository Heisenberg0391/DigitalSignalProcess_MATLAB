function [Mopt,MSElist] = findM(rxx,x,xd,N)
%寻找最优序列长度
MSElist = zeros(N-1);%初始化
for M = 1:N-1
    Rxx = ones(M,M);
    Rxx(:,1) = rxx(1:M);
    for i=2:M
        Rxx(:,i) = [rxx(i);Rxx(1:M-1,i-1)];
    end
    %求互相关
    [rxd,~] = xcorr(x,xd,'biased');
    rxd = rxd(N:end)';
    Rxd = rxd(1:M,1);
    %得到维纳滤波器
    hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
    %滤波
    filt_x = conv(x,hopt_x);
    sigx = filt_x(1:N);

    %求误差
    errx = sigx-xd;

    % 求均方误差
    MSE = sum(errx.^2);
    MSElist(M) = MSE;
    
    if(M==1)%第一次的MSE作为初始值
        MSEmin = MSE;
        Mopt=2;
    end
    %判断最优
    if(MSE<MSEmin)
        MSEmin=MSE;
        Mopt=M;
    end
end
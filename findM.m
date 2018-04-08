function [Mopt,MSElist] = findM(rxx,x,xd,N)
%Ѱ���������г���
MSElist = zeros(N-1);%��ʼ��
for M = 1:N-1
    Rxx = ones(M,M);
    Rxx(:,1) = rxx(1:M);
    for i=2:M
        Rxx(:,i) = [rxx(i);Rxx(1:M-1,i-1)];
    end
    %�����
    [rxd,~] = xcorr(x,xd,'biased');
    rxd = rxd(N:end)';
    Rxd = rxd(1:M,1);
    %�õ�ά���˲���
    hopt_x=(Rxx)\Rxd;   %inv(Rxx)*Rxd
    %�˲�
    filt_x = conv(x,hopt_x);
    sigx = filt_x(1:N);

    %�����
    errx = sigx-xd;

    % ��������
    MSE = sum(errx.^2);
    MSElist(M) = MSE;
    
    if(M==1)%��һ�ε�MSE��Ϊ��ʼֵ
        MSEmin = MSE;
        Mopt=2;
    end
    %�ж�����
    if(MSE<MSEmin)
        MSEmin=MSE;
        Mopt=M;
    end
end
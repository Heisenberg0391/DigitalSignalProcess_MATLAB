function [Mopt,MSElist] = findM(rxx,ryy,x,xd,y,yd,N)
%Ѱ���������г���
MSElist = zeros(N-1);%��ʼ��
for M = 1:N-1
    Rxx = ones(M,M);
    Rxx(:,1) = rxx(1:M);
    Ryy = ones(M,M);
    Ryy(:,1) = ryy(1:M);
    for i=2:M
        Rxx(:,i) = [rxx(i);Rxx(1:M-1,i-1)];
        Ryy(:,i) = [ryy(i);Ryy(1:M-1,i-1)];
    end
    %�����
    [rxd,~] = xcorr(x,xd,'biased');
    rxd = rxd(N:end)';
    [ryd,~] = xcorr(y,yd,'biased');
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

    %�����
    errx = sigx-xd;
    erry = sigy-yd;

    % ��������
    MSEx = sum(errx.^2);
    MSEy = sum(erry.^2);
    MSE=0.5*(MSEx+MSEy);
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
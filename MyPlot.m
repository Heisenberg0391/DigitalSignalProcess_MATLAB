function MyPlot(noise_x,noise_y,x,y,xd,yd,sigx,sigy,errx,erry,MSElistx,Moptx,MSElisty,Mopty,MSEx,MSEy)
% ���������ź�
figure;
subplot(1,2,1);
plot(noise_x);
title('x��������');
subplot(1,2,2);
plot(noise_y);
title('y��������');
% ���ƹ۲��ź�
figure;
subplot(1,2,1);
plot(x);
title('x����۲�');
subplot(1,2,2);
plot(y);
title('y����۲�');
% ���������ź�
figure;
subplot(1,2,1);
plot(xd);
title('x��������');
subplot(1,2,2);
plot(yd);
title('y��������');
% �����˲��ź�
figure;
subplot(1,2,1);
plot(sigx);
title('x�����˲�');
subplot(1,2,2);
plot(sigy);
title('y�����˲�');
% ��������ź�
figure;
subplot(1,2,1);
plot(errx);
title('x�������');
subplot(1,2,2);
plot(erry);
title('y�������');
%���ƾ������
figure;
subplot(1,2,1);
plot(MSElistx)
hold on
plot(Moptx,MSEx,'ro')
title('x����');
xlabel('�˲����״�')
ylabel('�������')
subplot(1,2,2);
plot(MSElisty)
hold on
plot(Mopty,MSEy,'ro')
title('y����');
xlabel('�˲����״�')
ylabel('�������')
%���ƽ��
figure;
subplot(1,2,1);
plot(x, y, '*b')
hold on
plot(xd, yd, 'og')
hold on
plot(sigx,sigy,'xr');
axis equal
title('�۲⡢�������˲��ź�')
subplot(1,2,2);
plot(x, y, 'b')
hold on
plot(xd, yd, 'g')
hold on
plot(sigx,sigy,'r');
axis equal
title('�۲⡢�������˲��ź�')
end
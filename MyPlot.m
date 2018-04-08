function MyPlot(noise_x,noise_y,x,y,xd,yd,sigx,sigy,errx,erry,MSElistx,Moptx,MSElisty,Mopty,MSEx,MSEy)
% 绘制噪声信号
figure;
subplot(1,2,1);
plot(noise_x);
title('x方向噪声');
subplot(1,2,2);
plot(noise_y);
title('y方向噪声');
% 绘制观测信号
figure;
subplot(1,2,1);
plot(x);
title('x方向观测');
subplot(1,2,2);
plot(y);
title('y方向观测');
% 绘制期望信号
figure;
subplot(1,2,1);
plot(xd);
title('x方向期望');
subplot(1,2,2);
plot(yd);
title('y方向期望');
% 绘制滤波信号
figure;
subplot(1,2,1);
plot(sigx);
title('x方向滤波');
subplot(1,2,2);
plot(sigy);
title('y方向滤波');
% 绘制误差信号
figure;
subplot(1,2,1);
plot(errx);
title('x方向误差');
subplot(1,2,2);
plot(erry);
title('y方向误差');
%绘制均方误差
figure;
subplot(1,2,1);
plot(MSElistx)
hold on
plot(Moptx,MSEx,'ro')
title('x方向');
xlabel('滤波器阶次')
ylabel('均方误差')
subplot(1,2,2);
plot(MSElisty)
hold on
plot(Mopty,MSEy,'ro')
title('y方向');
xlabel('滤波器阶次')
ylabel('均方误差')
%绘制结果
figure;
subplot(1,2,1);
plot(x, y, '*b')
hold on
plot(xd, yd, 'og')
hold on
plot(sigx,sigy,'xr');
axis equal
title('观测、期望和滤波信号')
subplot(1,2,2);
plot(x, y, 'b')
hold on
plot(xd, yd, 'g')
hold on
plot(sigx,sigy,'r');
axis equal
title('观测、期望和滤波信号')
end
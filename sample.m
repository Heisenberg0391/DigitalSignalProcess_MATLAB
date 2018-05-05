% 递归生成随机信号
% n为当前时刻，noise为白噪声
function x = sample(n, noise)
    if n == 1
       x = noise(1);
    else
        x = 0.8*sample(n-1, noise)+noise(n);
    end
end
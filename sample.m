% �ݹ���������ź�
% nΪ��ǰʱ�̣�noiseΪ������
function x = sample(n, noise)
    if n == 1
       x = noise(1);
    else
        x = 0.8*sample(n-1, noise)+noise(n);
    end
end
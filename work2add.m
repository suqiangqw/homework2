clear;
close;
clc;
%��չ��Ŀ
fid=fopen('work2.m');
Z=textscan(fid,'%s','delimiter','\n');%��������Ϊ�����
num=length(Z{1});  %������
z=Z{1}
fclose(fid);
str2='';%ȡ����Ϊ�ַ����Ƚ϶���
k=0;
for j=1:num
    if strcmp(z{j,1},str2)  %�ַ����ȽϺ���������ȷ���1
        k=k+1;    %kΪ������
    end
end
h=num-k;      %������-������=��������

disp('������')
disp(num)
disp('��������')
disp(h)
disp('������')
disp(k)
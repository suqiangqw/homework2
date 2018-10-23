clear;
close;
clc;
%扩展项目
fid=fopen('work2.m');
Z=textscan(fid,'%s','delimiter','\n');%将换行作为定界符
num=length(Z{1});  %总行数
z=Z{1}
fclose(fid);
str2='';%取空作为字符串比较对象
k=0;
for j=1:num
    if strcmp(z{j,1},str2)  %字符串比较函数，若相等返回1
        k=k+1;    %k为空行数
    end
end
h=num-k;      %总行数-空行数=代码行数

disp('总行数')
disp(num)
disp('代码行数')
disp(h)
disp('空行数')
disp(k)
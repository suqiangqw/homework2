clear;
close;
clc;

tt=fopen('text.txt');
B=textscan(tt,'%s','delimiter','.');%��.��Ϊ�����
B{1};
num_s=length(B{1});  %ͳ�ƾ��Ӹ���
fclose(tt);

mm=fopen('text.txt');
A=textscan(mm,'%s');%Ĭ�Ͻ��ո���Ϊ�����
a=A{1}
[n,~]=size(a); %ȡ����,��ʱ������Ϊ���ʸ���
m=0;
for i=1:n      %��ÿ�����ʵ��ַ���
    [~,temp]=size(a{i,1});
    m=m+temp;   %��ÿ�����ʵ��ַ����ۼ�
end
fclose(mm);

disp('������')
disp(n)
disp('������')
disp(num_s)
disp('�ַ���')
disp(m)
clear;
close;
clc;

tt=fopen('text.txt');
B=textscan(tt,'%s','delimiter','.');%将.作为定界符
B{1};
num_s=length(B{1});  %统计句子个数
fclose(tt);

mm=fopen('text.txt');
A=textscan(mm,'%s');%默认将空格作为定界符
a=A{1}
[n,~]=size(a); %取行数,此时的行数为单词个数
m=0;
for i=1:n      %求每个单词的字符数
    [~,temp]=size(a{i,1});
    m=m+temp;   %将每个单词的字符数累加
end
fclose(mm);

disp('单词数')
disp(n)
disp('句子数')
disp(num_s)
disp('字符数')
disp(m)
clear
clc
load('xiaoma.mat');
inputt=(ZF(:,1))';%第一行是H，第二行是B
outputt=(ZF(:,2))';
inputt=950*inputt;
outputt=800*outputt;
m=100;
%m=148;
n=4600;

% for k=m:1:(m+n)%估计是在查找是正数还是负数方便后面去查找极点
%     aa(k)=abs(inputt(k)-inputt(k-1));
% end

%确定输入输出
v=inputt(m:m+n);
y=outputt(m:m+n);
% ff=aa(m:m+n);%确定正数还是负数


voff=0;

loff=0;
t=0.01;
%lm=zeros(800,10);
%l=zeros(800,1);
  %for i=1:1:10
 F0=0;
u1(1)=0;
for k=2:1:n
   %{
 if((v(k)-v(k-1))*(v(k)-v(k+1))>=0&&v(k)>=v(k-1))
        l(k)=(1-exp(-(v(k)-voff)))*(v(k)-voff)*(1+exp(-0*ff(k)))+loff;
        voff=v(k);
        loff=l(k);
        lm(k)=l(k);
        elseif ((v(k)-v(k-1))*(v(k)-v(k+1))>=0&& v(k)<=v(k-1))
            l(k)=(1-exp(v(k)-voff))*(v(k)-voff)*(1+exp(-0*ff(k)))+loff;
            voff=v(k);
            loff=l(k);
            lm(k)=l(k);
        elseif(v(k)>=v(k-1))
           lm(k)=(1-exp(-(v(k)-voff)))*(v(k)-voff)*(1+exp(-0*ff(k)))+loff;
        elseif(v(k)<=v(k-1))
          lm(k)=(1-exp(v(k)-voff))*(v(k)-voff)*(1+exp(-0*ff(k)))+loff;
end
%}
  
%     ki=0.11541;gain=0.08;L=1;x0=0.1;
     ki=0.1;gain=100;L=1.1;x0=0.1;
%      ki=6.4045;gain=40;L=0.1752;x0=0.1;
     u1(k)=(v(k)-F0)*ki*t+u1(k-1);
    if (abs(u1(k))<x0)
        F(k)=0;
    elseif (u1(k)>x0)
        F(k)=gain*(u1(k)-x0);
    else
        F(k)=gain*(u1(k)+x0);
    end
    F0=F(k);
    l(k)=L*u1(k)+1/gain*v(k);
  
    end
  lm=l;





%nn data
  %  lm(1)=lm(2);
 %   disp(lm);
    
input1=v(2:2:n);                   % hysteresis input
input2=lm(2:2:n);                 % hysteresis factor output
input3=lm(1:2:n-1);  %h(k-1)


input=[input1;input2;input3];%
output=y(2:2:n);


%nn train
p=input;
t=output;
[pn,minp,maxp,tn,mint,maxt]=premnmx(p,t);
% net=newff(minmax(pn),[10,1],{'logsig','purelin'},'trainlm');
net=newelm(minmax(pn),[18,1],{'logsig','purelin'},'trainlm');
net.trainparam.show=5;
net.trainparam.lr=0.00001;
net.trainparam.epochs=6000;
%6000
net.trainparam.goal=1e-5;
net=init(net);
[net,tr]=train(net,p,t);
nntrainout=sim(net,p);

figure
plot(p(1,:),nntrainout,p(1,:),t)




% nn test
qq=n;

input1test=v(3:2: qq); 
input2test=lm(3:2:qq);  
input3test=lm(2:2:qq-1);

testreal=y(3:2:qq);

inputtest=[input1test; input2test ;input3test];
outtest=sim(net,inputtest);

figure
plot(input1test,outtest,'k:',input1test,testreal,'k')
xlabel('迟滞输入 v /V ');
ylabel('迟滞输出 H /\mum');
legend('模型曲线','实际曲线')
box off
set(gcf,'Position',[100 100 260 220]);
figure_FontSize=6;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);



figure
ttt=1:1:qq/2-1;
plot(ttt,outtest-testreal,'k')
xlabel('采样个数')
ylabel('建模误差 e /\mum')
box off
set(gcf,'Position',[100 100 260 220]);
figure_FontSize=6;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);



errormax=max(abs(outtest-testreal))

figure
plot(v(2:n),lm(2:n),'k')
xlabel('v(t)');
ylabel('f[v(t)]');


%MSE
s=0;
for k=1:2:qq/2-1
       s=s+(outtest(k)-testreal(k))*(outtest(k)-testreal(k));
end
mse=sqrt(s/599);
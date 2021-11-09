function[recsig]=PSK_Demod(s_NEW,M,fc,n)


T = 1/fc;%time
    fs = 500*fc;%FS
t=0:1/fs:499/fs;
recsig=zeros(1,n);
Eavr=(max(s_NEW).^2*T)/2;
 D1=2*pi/M:2*pi/M:2*pi;
  base_func=[];
  %%   
  t1=[];

for i=1:n
        t=(i-1)*T:1/fs:i*T-1/fs;%time vector
       
   t1=[t1,t];
end
  subplot(1,1,1),plot(t1,s_NEW)%plot the symbol on time
xlim([0,4])
xlabel('t[sec]')
ylabel('s(t)[Volt]')
%%
for i=1:M
    base_func(i,:)=sqrt(2/T)*cos(2*pi*(fc)*t+D1(i));
end
for index=1:n
    for i=1:M
        r(i,:)=s_NEW(1+(index-1)*length(t):index*length(t)).*base_func(i,:);
        sum_r(i)=sum(r(i,:));
    end
    [~,max_index]=max(sum_r);
    recsig(index)=max_index;
    if recsig(index)==M
        recsig(index)=0;
    end
end
a=1;

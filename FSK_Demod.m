function[ReceiveData]=FSK_Demod(s,M,fc,df,n)
Tsym=1/df;
fs=500*(fc+M*df);
t=0:1/fs:Tsym;
ReceiveData=zeros(1,n);
for i=0:M-1
    base_func(i+1,:)=sqrt(2/Tsym)*cos(2*pi*(fc+i*df)*t);
end
for index=1:n
    for i=1:M
        r(i,:)=s(1+(index-1)*length(t):index*length(t)).*base_func(i,:);
        sum_r(i)=sum(r(i,:));
    end
    [~,max_index]=max(sum_r);
    ReceiveData(index)=max_index-1;
end

        
end

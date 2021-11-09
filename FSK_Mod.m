%  function[m,s]=FSK_Mod(M,fc,df,n,E)
n=100;
 M=4;
 fc=40;
 E=0.1;
df=60;
Tsym=1/df;
fs=50*(fc+M*df);
s=[];
t1=[];
m=randi(M,1,n)-1;
for i=1:n
    t=(i-1)*Tsym:1/fs:i*Tsym;
    S_T=sqrt(2*E/Tsym)*cos(2*pi*(fc+m(i)*df)*t);
    s=[s,S_T];
    t1=[t1,t];
end


% figure('Name','MFSK in Time')
% % subplot(2,1,1)
% plot(t1,s)
% xlim([0,20*Tsym])
% xlabel('t[msec]')
% ylabel('s(t)[volt]')
% title([num2str(M),'-FSK modulation in Time']);
% grid
% S_F=abs(fftshift(fft(s)))/length(t1);
% F=-fs/2:fs/(length(t1)-1):fs/2;
subplot(2,1,1),plot(t1,s,'LineWidth' ,2)%plot the symbol on time
xlim([0,10*Tsym])
xlabel('t[msec]')
ylabel('s(t)[Volt]')
title('2-FSK modulation in Time','Fontsize',14)

tt=[];
for k=1:100
 for i=1:234
 
    bits(i+(k-1)*234)=m(k);
 end 
 
end
    
% subplot(2,1,2),plot(t1,bits,'LineWidth' ,2);
% xlim([0,10*Tsym])
% ylim([0,5])
% xlabel('t[msec]')
% ylabel('s(t)[Volt]')
% title('bits in Time','Fontsize',14)
% subplot(2,1,2)
% plot(F,S_F)
% xlabel('f[KHz]')
% 
% ylabel('s(f)[volt]');
% title([num2str(M),'-FSK modulation in Freq']);
% xlim([-80 80]);
% 
% grid

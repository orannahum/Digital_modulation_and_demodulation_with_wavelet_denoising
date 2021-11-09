
function [m,s] =PSK_Mod(M,fc,n,E) 
n=90;
 M=8;
 fc=10;
 E=1;
 %------ Constant Assignment
    % --------- Constant Assignment
    T= 1/fc;%time
    fs = 500*fc;%freq
    s=[];
    t1=[];
      m=randi([0,M-1],1,n);
    deg=2*m*pi/M;
%     --------- Data Generator
    m_complex = E*exp(1i*deg);
  
  % --------- Modulate the data vector
 
    for i=1:n
        t=(i-1)*T:1/fs:i*T-1/fs;%time vector
        s_t=sqrt(2*E/T)*(cos(2*pi*fc*t+deg(i)));%make symbol
   s=[s,s_t];
   t1=[t1,t];
    end
% plot(real(m_complex),imag(m_complex),'k*')%plot constelation
% xlim([-1.2,1.2])
% ylim([-1.2,1.2])
% xlabel('I')
% ylabel('Q')
% title('Constellation of 8-PSK modulation','Fontsize',14)
% grid
% s_f=abs(fftshift(fft(s)))/length(t1);
% f=-fs/2:(fs/(length(t1)-1)):fs/2;
figure('name','M-PSK in Time')
plot(t1,s,'LineWidth' ,2)%plot the symbol on time
xlim([0,10*T])
xlabel('t[msec]')
ylabel('s(t)[Volt]')
title('8-PSK modulation in Time','Fontsize',14)
grid
% subplot(2,1,2),plot(f,s_f)%plot the freq of our symbol
% xlabel('f[KHz]')
% ylabel('s(f)[Volt]')
% title('4-PSK modulation in Freq')
% xlim([-200 200]);
% grid

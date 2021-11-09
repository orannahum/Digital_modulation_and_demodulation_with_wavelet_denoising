
% function [m,s] =QAM_Mod(M,fc,n,E)
n=20;
 M=16;
 fc=10;
 E=0.1;
    % --------- Constant Assignment
    Tsym = 1/fc;%time
    fs = 50*fc;%freq
    s=[];
    t1=[];
    % --------- Data Generator
    M_x = 2*randi(sqrt(M),1,n)-(sqrt(M)+1); %2m-Mpam-1 where m=sqrt(Mpam)
    M_y = 2*randi(sqrt(M),1,n)-(sqrt(M)+1);
    m = complex(M_x,M_y);%vector of symbols that we send on the constelation
    
    % --------- Modulate the data vector
  
    for i=1:n
        t=(i-1)*Tsym:1/fs:i*Tsym-1/fs;%time vector
        s_t=sqrt(2*E/Tsym)*( M_x(i)*cos(2*pi*fc*t)-M_y(i)*sin(2*pi*fc*t) );%make symbol
   s=[s,s_t];
   t1=[t1,t];
    end
%                      s1=wdenoise(s);

% scatterplot(m)%plot constelation
% plot(real(m),imag(m),'k*')%plot constelation
% xlim([-4,4])
% ylim([-4,4])
% xlabel('I')
% ylabel('Q')
% title('Constellation of 16-QAM modulation','Fontsize',14)
% grid
grid
s_f=abs(fftshift(fft(s)))/length(t1);
f=-fs/2:(fs/(length(t1)-1)):fs/2;
% figure('name','M-QAM in Time')
figure;
plot(t1,s,'LineWidth' ,2)%plot the symbol on time
xlim([0,10*Tsym])
xlabel('t[msec]')
ylabel('s(t)[Volt]')
title('16-QAM modulation in Time','Fontsize',14)
grid
% %                      s=awgn(s,30);%add noise to our S(t)
% %                      figure;
plot(t1,s,'LineWidth' ,2)%plot the symbol on time
xlim([0,10*Tsym])
xlabel('t[msec]')
ylabel('s(t)[Volt]')
title('Same signal with noise(SNR = 0 dB)','Fontsize',14)
grid
% %                   s=wdenoise(s);
% %                                        figure;
% % plot(t1,s,'LineWidth' ,2)%plot the symbol on time
% % xlim([0,10*Tsym])
% % xlabel('t[msec]')
% % ylabel('s(t)[Volt]')
% % title('Denoised signal','Fontsize',14)
% % grid
% % 
% % 
% % % subplot(2,1,2),plot(t1,s1)%plot the symbol on time
% % % xlim([0,20*Tsym])
% % % xlabel('t[msec]')
% % % ylabel('s(t)[Volt]')
% % % title('16-QAM modulation in Time with SNR=0dB with wavelet denoising')
% % % grid
% % subplot(2,1,2),plot(f,s_f)%plot the freq of our symbol 
% % xlabel('f[Hz]') 
% % ylabel('s(f)[Volt]')
% % title('16-QAM modulation in Freq') % grid

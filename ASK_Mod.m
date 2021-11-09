%   function[m,s]=ASK_Mod(M,fc,n,E)
 n=2000;
 M=2;
 fc=10;
 E=0.1;
%     % --------- Constant Assignment
    Tsym = 1/fc;
    fs = 50*fc;
    dT = 1/fs;
    t = 0:dT:(Tsym-dT);
    T = 0:dT:(n*Tsym-dT);
    S_t = zeros(1,length(T));

    
    % --------- Data Generator
    
    m = randi([0,M-1],1,n); %2m-Mpam-1 where m=sqrt(Mpam)
   
    
    % --------- Modulate the data vector
   for i=1:n
        symbol =sqrt(2*E/Tsym)*( m(i)*cos(2*pi*fc*t));
        S_t(((i-1)*length(t)+1):i*length(t)) = symbol;

   end
   s=S_t;
           t1 = 0:dT:(n*Tsym-dT);

    mAVR=sum(m)/length(m);
             scatterplot(m)
%                s=awgn(s,-10);%add noise to our S(t)

grid
s_f=abs(fftshift(fft(s)))/length(t1);
f=-fs/2:(fs/(length(t1)-1)):fs/2;
subplot(2,1,1),plot(t1,s,'LineWidth' ,2)%plot the symbol on time
xlim([0,10*Tsym])
xlabel('t[msec]')
ylabel('s(t)[Volt]')
title('2-ASK modulation in Time with noise','Fontsize',14)

% tt=[];
% for k=1:100
%  for i=1:50
%  
%     bits(i+(k-1)*50)=m(k);
%  end 
%  
% end
%     s=wdenoise(s,1,'Wavelet','db7');
%     figure;
% plot(t1,s,'LineWidth' ,2);
% xlim([0,10*Tsym])
% xlabel('t[msec]')
% ylabel('s(t)[Volt]')
% title('denoised signal','Fontsize',14)

grid
subplot(2,1,2),plot(f,s_f)%plot the freq of our symbol
xlabel('f[KHz]')
ylabel('s(f)[Volt]')
title('4-ASK modulation in Freq')
xlim([-40 40]);
grid

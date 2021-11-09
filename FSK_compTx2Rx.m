% function FSK_compTx2Rx(M,fc,df,n,E)
n=1000;
M=2;
fc=20;
E=0.0001;
df=10;
[m,s]=FSK_Mod(M,fc,df,n,E);

 for snr=0:18%SNR VECTOR 
     % --------- calling for Mod function and create modulataion data.
    s_withnoise=awgn(s,snr);%add noise to our S(t)
    % --------- calling for deMod function for demodulate the noisy signal.
     [recsig]=FSK_Demod(s_withnoise,M,fc,df,n);
    [~,sernowavelet(snr+1)]=symerr(m,recsig);
    s_NEW = wdenoise(s_withnoise);%wavelet denoising
    [recsig]=FSK_Demod(s_NEW,M,fc,df,n);
    [~,serwithwavelet(snr+1)]=symerr(m,recsig);
 end


figure('name','string(M)SER of FSK');
snr=0:18;
semilogy(snr,serwithwavelet,snr,sernowavelet)
xlabel('snr[dB]')
ylabel('ser')
grid minor
title([string(M),'-FSK SER'])
legend('SER with wavelet denoising(FSK)','SER without wavelet denoising(FSK)','Location','SouthWest')

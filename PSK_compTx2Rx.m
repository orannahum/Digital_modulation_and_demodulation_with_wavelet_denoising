% function PSK_compTx2Rx(M,fc,df,n,E)
clear all
n=10;
M=8;
fc=20;
E=0.001;

[m,s]=PSK_Mod(M,fc,n,E);
 for snr=0:18%SNR VECTOR 
     % --------- calling for Mod function and create modulataion data.
    s_withnoise=awgn(s,snr);%add noise to our S(t)
    % --------- calling for deMod function for demodulate the noisy signal.
     [recsig]=PSK_Demod(s_withnoise,M,fc,n);
    [~,sernowavelet(snr+1)]=symerr(m,recsig);
    s_NEW = wdenoise(s_withnoise);%wavelet denoising

    [recsig]=PSK_Demod(s_NEW,M,fc,n);
    [~,serwithwavelet(snr+1)]=symerr(m,recsig);
 end


figure('name','string(M)SER of PSK');
snr=0:18;
semilogy(snr,serwithwavelet,snr,sernowavelet)
xlabel('snr[dB]')
ylabel('ser')
grid minor
title([string(M),'-PSK SER'])
legend('SER with wavelet denoising(PSK)','SER without wavelet denoising(PSK)','Location','SouthWest')
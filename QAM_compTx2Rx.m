% function QAM_compTx2Rx(M,Fc,n,E)
M=4;
fc=20;
n=300;
E=0.001;
 [m,s]=QAM_Mod(M,fc,n,E) ;
 for snr=0:18%SNR VECTOR 
     % --------- calling for Mod function and create modulataion data.
    s_withnoise=awgn(s,snr);%add noise to our S(t)
       % --------- calling for deMod function for demodulate the noisy signal.
     [recsig]=QAM_Demod(s_withnoise,M,fc,n);
    [~,sernowavelet(snr+1)]=symerr(m,recsig);
    s_NEW = wdenoise(s_withnoise);%wavelet denoising

    [recsig]=QAM_Demod(s_NEW,M,fc,n);
    [~,serwithwavelet(snr+1)]=symerr(m,recsig);
 end


figure('name','string(M)SER of QAM');
snr=0:18;
semilogy(snr,serwithwavelet,snr,sernowavelet)
xlabel('snr[dB]')
ylabel('ser')
grid minor
title([string(M),'-QAM SER'])
legend('SER with wavelet denoising(QAM)','SER without wavelet denoising(QAM)','Location','SouthWest')

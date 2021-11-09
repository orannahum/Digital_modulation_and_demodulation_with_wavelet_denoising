%  function ASK_compTx2Rx(M,fc,n,E)
 n=1000;
 M=4;
 fc=30;
 E=0.0001;
 [m,s]=ASK_Mod(M,fc,n,E) ;
 for snr=0:18%SNR VECTOR 
     % --------- calling for Mod function and create modulataion data.
    s_withnoise=awgn(s,snr);%add noise to our S(t)
    % --------- calling for deMod function for demodulate the noisy signal.
     [recsig]=ASK_Demod(s_withnoise,M,fc,n);
    [~,sernowavelet(snr+1)]=symerr(m,recsig);
    s_NEW = wdenoise(s_withnoise,5);%wavelet denoising

    [recsig]=ASK_Demod(s_NEW,M,fc,n);
    [~,serwithwavelet(snr+1)]=symerr(m,recsig);
 end


figure('name','string(M)SER of ASK');
snr=0:18;
semilogy(snr,serwithwavelet,snr,sernowavelet)
xlabel('snr[dB]')
ylabel('ser')
grid minor
title([string(M),'-ASK SER'])
legend('SER with wavelet denoising(ASK)','SER without wavelet denoising(ASK)','Location','SouthWest')

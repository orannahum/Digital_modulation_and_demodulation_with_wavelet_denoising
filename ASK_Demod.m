function [ReceiveData] = ASK_Demod(s_NEW,M,fc,n)
   %  n=100;
%  M=16;
%  fc=20;
%  E=1;
%     % --------- Constant Assignment
    Tsym = 1/fc;
    fs = 1000*fc;
    dT = 1/fs;
     t = 0:dT:(Tsym-dT);
     T = 0:dT:(n*Tsym-dT);

      map=[];
       for i=1:M
        map(i)=i-1;
       end
       
    ReceiveData = zeros(1,n);%definite vector of zeros
    % --------- Base Function Generator
    base_I =  sqrt(2/Tsym)*cos(2*pi*fc*t);
    % --------- Extracting -m- 
   
    
E_sqrt=abs((s_NEW)*sqrt(Tsym)/sqrt(2));
Eavr=(mean(E_sqrt)/(pi*(M-1))).^2*100;

 lengthS_t=length(E_sqrt)*dT;

  for i=1:n
        indx_I = sum(s_NEW(((i-1)*length(t)+1):i*length(t)).*base_I)*((1/fs));
        ReceiveData(i) =indx_I;
  end
%      P_index=real(ReceiveData)>0&imag(ReceiveData)>0;
     %-----------averge energy of our system
        ReceiveData=ReceiveData/sqrt(Eavr);%Receive Data
    for i=1:n
                distance=(map-ReceiveData(i));  %distance of recevie symbol and all the symbols that we have in constaltion 
          
               [M,I] = min(abs(distance)) ;
              ReceiveData(i)=map(I);
        
    end
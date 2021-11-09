
function [ReceiveData] = QAM_Demod(s_NEW,M,Fc,n)
    % --------- Constant Assignment
    Tsym = 1/Fc;%time
    fs = 500*Fc;%FS
    t=0:1/fs:Tsym-1/fs;%vector of time 
    %-------------make our map constellation
    for i=1:sqrt(M)
        for k=1:sqrt(M)
         map(i,k)= complex(-sqrt(M)-1+k*2,-sqrt(M)-1+i*2) ;
        end 
    end
        map=map(:);%matrix to vector
%     g_t = sqrt(2*Esym/Tsym);
    ReceiveData = zeros(1,n);%definite vector of zeros
    % --------- Base Function Generator
    base_I =  sqrt(2/Tsym)*cos(2*pi*Fc*t);
    base_Q = -sqrt(2/Tsym)*sin(2*pi*Fc*t);
    % --------- Extracting -m- 
    for i=1:n
        indx_I = sum(s_NEW(((i-1)*length(t)+1):i*length(t)).*base_I)*((1/fs));
        indx_Q = sum(s_NEW(((i-1)*length(t)+1):i*length(t)).*base_Q)*((1/fs));
        ReceiveData(i) =complex(indx_I,indx_Q);
    end
     P_index=real(ReceiveData)>0&imag(ReceiveData)>0;
     %-----------averge energy of our system
    Esym=(sum(real(ReceiveData(P_index)).^2+imag(ReceiveData(P_index)).^2)/sum(P_index))/(sum((real(map).^2+imag(map).^2)/M));
    
    ReceiveData=ReceiveData/sqrt(Esym);%Receive Data
    for i=1:n
    distance=(real(map-ReceiveData(i)).^2+imag(map-ReceiveData(i)).^2);  %distance of recevie symbol and all the symbols that we have in constaltion 
    [val,index]=min(distance);%find the min distance(the nearest symbol)
    ReceiveData(i)=map(index);
    end



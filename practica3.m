
%
Practica 3 - Regalado Felipe
%


[sig,fs]=audioread('OSR_us_000_0016_8k.wav');

DPCMP = [0];
dpcm_1 = [];
dpcm_A = [];
qn = [];
S = [0];
Q = [0];

hold on
 q=1/128;
 for n=2:length(sig)
    if (0<sig(n))
        dpcm_1(n) = sig(n) - DPCMP(n-1);
        dpcm_A(n) = round(dpcm_1(n)/128,1,'significant');
        DPCMP(n) = dpcm_A(n) * -q/2;
    elseif (sig(n)<0)
        dpcm_1(n) = sig(n) - DPCMP(n-1);
        dpcm_A(n) = round(dpcm_1(n)/q,1,'significant');
        DPCMP(n) = dpcm_A(n)*q+q/2;
    else
        dpcm_A(n) = sig(n);
        DPCMP(n) = dpcm_A(n);
    end

    qn(n) = DPCMP(n) - dpcm_A(n);
    S = (DPCMP(n)^2) + S;
    Q = (qn(n)^2) + Q;
    SP = (1/length(sig)) * S;
    QP = (1/length(sig)) * Q;
    SQR = SP / QP;
    SQRdb = 10 * log10(SQR) * -1;
 end

 SQRdb
 figure(1)
 plot(dpcm_1,'DisplayName','Señal recuperada')
 plot(sig,'DisplayName','Señal original')
 hold off
 title('DPCM')
 ylabel('Amp')
 xlabel('Tiempo')
 legend show
 grid on
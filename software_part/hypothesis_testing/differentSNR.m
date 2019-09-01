L=500;
d=round(rand(1,L)); % rand data sequence
b=2*d-1; % Convert unipolar to bipolar
T=1; % Bit duration
Eb=T/2; % This will result in unit amplitude waveforms
fc=3/T; % Carrier frequency
t=linspace(0,5,500); % discrete time sequence between 0 and 5*T (500 samples)
N=length(t); % Number of samples
Nsb=N/length(d); % Number of samples per bit
dd=repmat(d',1,Nsb); % replicate each bit Nsb times (replication used in Bit manupli)
bb=repmat(b',1,Nsb); dw=dd'; % Transpose the rows and columns
dw=dw(:)'; 
% Convert dw to a column vector (colum by column) and convert to a row vector
bw=bb';
bw=bw(:)'; % Data sequence samples
w=sqrt(2*Eb/T)*cos(2*pi*fc*t); % carrier waveform
wwww=bw.*w; % total waveform



snr_dB = -10;
snr_dB2 = -15;
snr_dB3 = -20;% SNR in DB
snr = 10.^(snr_dB./10);
snr2 = 10.^(snr_dB2./10);
snr3 = 10.^(snr_dB3./10);% Linear Value of SNR
Pf = 0.01:0.01:1; % Pf = Probability of False Alarm
%% montCarlo 
for m = 1:length(Pf)
    
    i = 0;i2=0;i3=0;
for kk=1:10000 % Number of Monte Carlo Sim
 n = randn(1,L); %AWGN noise with mean 0 and variance 1
  % Real valued Gaussin pu Signal 
 s = sqrt(snr)*wwww; s2 = sqrt(snr2)*wwww;s3 = sqrt(snr3)*wwww;
 y = s + n;y2 = s2 + n;y3=s3+n; % Received signal at SU
 energy = abs(y).^2;  energy2 = abs(y2).^2;energy3 = abs(y3).^2;% Energy of received signal over N samples
 energy_fin =(1/L).*sum(energy);energy_fin2 =(1/L).*sum(energy2);energy_fin3 =(1/L).*sum(energy3); % Test for the energy detection
 thresh(m) = (qfuncinv(Pf(m))./sqrt(L/2))+ 1; % Theoretical value of Threshold due to baysian theory
 if(energy_fin >= thresh(m))  % Check if the received energy is greater than threshold then increment Pd (Probability of detection) inc 1
     i = i+1;
 end
  if(energy_fin2 >= thresh(m))  % Check if the received energy is greater than threshold then increment Pd (Probability of detection) inc 1
     i2 = i2+1;
  end
  if(energy_fin3 >= thresh(m))  % Check if the received energy is greater than threshold then increment Pd (Probability of detection) inc 1
     i3 = i3+1;
 end
end
Pd(m) = i/kk; 
Pd2(m) = i2/kk;
Pd3(m) = i3/kk;
end

figure 
plot(Pf, Pd,Pf,Pd2,Pf,Pd3)

hold on

thresh = (qfuncinv(Pf)./sqrt(L))+ 1;
Pd_the = qfunc(((thresh - (snr + 1)).*sqrt(L))./(sqrt(2).*(snr + 1)));
plot(Pf, Pd_the,'g')
title(' different SNR with N=500')
ylabel('P_D')
xlabel('P_{FA}')
legend('SNR=-10dB','SNR=-15dB','SNR=-20dB','SNR=-10dB','Location','southeast')




clear all;  

% Experiment Assignment
run_MSBL  = 1;           % Run MSBL
iterNum   = 50;          % Trial number 
                         % For statistical result, iterNum should not less than 50

% Problem dimension
N = 40;                  % Row number of the dictionary matrix 
M = N * 5;               % Column number of the dictionary matrix
L = 4;                   % Number of measurement vectors
K = 7;                   % Number of nonzero rows 
beta = ones(K,1)*1;      % The source vectors are identical
                         
SNR = 10;             
                         
                         
for it = 1 : iterNum
    fprintf('\n\nTrial #%d:\n',it);

    % Generate dictionary matrix with columns draw uniformly from the surface of a unit hypersphere
    Phi = randn(N,M);
    Phi = Phi./(ones(N,1)*sqrt(sum(Phi.^2)));
   
    % Generate the K nonzero rows, each row being an AR(1) process. All the AR(1) 
    % processes have different AR coefficients, which are randomly chosen from [0.7,1)     
    nonzeroW(:,1) = randn(K,1);
    for i = 2 : L*100
        nonzeroW(:,i) = beta .* nonzeroW(:,i-1) + sqrt(1-beta.^2).*(ones(K,1).*randn(K,1));
    end
    nonzeroW = nonzeroW(:,end-L+1:end);   % Ensure the AR processes are stable

    % Normalize each row
    nonzeroW = nonzeroW./( sqrt(sum(nonzeroW.^2,2)) * ones(1,L) );
    
    % Rescale each row such that the squared row-norm distributes in [1,scalefactor]
    scalefactor = 3; 
    mag = rand(1,K); mag = mag - min(mag);
    mag = mag/(max(mag))*(scalefactor-1) + 1;
    nonzeroW = diag(sqrt(mag)) * nonzeroW;

    % Locations of nonzero rows are randomly chosen
    ind = randperm(M);
    indice = ind(1:K);
    Wgen = zeros(M,L);
    Wgen(indice,:) = nonzeroW;

    % Noiseless signal
    signal = Phi * Wgen;

    % Observation noise   
    stdnoise = std(reshape(signal,N*L,1))*10^(-SNR/20);
    noise = randn(N,L) * stdnoise;

    % Noisy signal
    Y = signal + noise;


  
    

    
    %============================ MSBL ========================== 
    lambda = 1e-3;           % Initial value for the regularization parameter. 
    Learn_Lambda = 1;        % Using its lambda learning rule

    if run_MSBL == 1,
    tic;
    [Weight3,gamma_est3,gamma_used3,count3] = MSBL(Phi,Y, lambda, Learn_Lambda);
    time3 = toc;
    TIME3(it) = time3;
    
    
    % Failure rate
    F3 = perfSupp(Weight3,indice,'firstlargest', K);      
    fail_MSBL(it) = (F3~=1);      
    
    % MSE
    perf_MSBL(it) = (norm(Wgen - Weight3,'fro')/norm(Wgen,'fro'))^2;  
    
    fprintf('   MSBL: time = %5.2f; Findex = %3.2f, Ave-MSE = %3.2f%%; Ave-Fail_Rate = %4.3f%%; Ave-Time = %4.3f\n',...
        time3,F3,mean(perf_MSBL)*100,mean(fail_MSBL)*100,mean(TIME3));
    end
    
    
  
end





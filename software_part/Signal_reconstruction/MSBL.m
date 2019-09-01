function [X,gamma_ind,gamma_est,count] = MSBL(Phi, Y, lambda, Learn_Lambda, varargin)
% Dimension of the Problem
[N M] = size(Phi); 
[N L] = size(Y);  

% Default Control Parameters 
PRUNE_GAMMA = 1e-3;       % threshold for prunning small hyperparameters gamma_i
EPSILON     = 1e-8;       % threshold for stopping iteration. 
MAX_ITERS   = 2000;       % maximum iterations
PRINT       = 0;          % don't show progress information


if(mod(length(varargin),2)==1)
    error('Optional parameters should always go by pairs\n');
else
    for i=1:2:(length(varargin)-1)
        switch lower(varargin{i})
            case 'prune_gamma'
                PRUNE_GAMMA = varargin{i+1}; 
            case 'epsilon'   
                EPSILON = varargin{i+1}; 
            case 'print'    
                PRINT = varargin{i+1}; 
            case 'max_iters'
                MAX_ITERS = varargin{i+1};  
            otherwise
                error(['Unrecognized parameter: ''' varargin{i} '''']);
        end
    end
end

if (PRINT) fprintf('\nRunning MSBL ...\n'); end


% Initializations 
gamma = ones(M,1); 
keep_list = [1:M]';
m = length(keep_list);
mu = zeros(M,L);
count = 0;                        % iteration count


% *** Learning loop ***
while (1)

    % *** Prune weights as their hyperparameters go to zero ***
    if (min(gamma) < PRUNE_GAMMA )
        index = find(gamma > PRUNE_GAMMA);
        gamma = gamma(index);  % use all the elements larger than MIN_GAMMA to form new 'gamma'
        Phi = Phi(:,index);    % corresponding columns in Phi
        keep_list = keep_list(index);
        m = length(gamma);
    end;


    mu_old =mu;
    Gamma = diag(gamma);
    G = diag(sqrt(gamma));
        
    % ****** estimate the solution matrix *****
    [U,S,V] = svd(Phi*G,'econ');
   
    [d1,d2] = size(S);
    if (d1 > 1)     diag_S = diag(S);
    else            diag_S = S(1);      end;
       
    Xi = G * V * diag((diag_S./(diag_S.^2 + lambda + 1e-16))) * U';
    mu = Xi * Y;
    
    gamma_old = gamma;
    mu2_bar = sum(abs(mu).^2,2)/L;

    Sigma_w_diag = real( gamma - (sum(Xi'.*(Phi*Gamma)))');
    gamma = mu2_bar + Sigma_w_diag;

    if Learn_Lambda == 1
        lambda = (norm(Y - Phi * mu,'fro')^2/L)/(N-m + sum(Sigma_w_diag./gamma_old)); 
    end;
    
    
    % *** Check stopping conditions, etc. ***
    count = count + 1;
    if (PRINT) disp(['iters: ',num2str(count),'   num coeffs: ',num2str(m), ...
            '   gamma change: ',num2str(max(abs(gamma - gamma_old)))]); end;
    if (count >= MAX_ITERS) break;  end;

    if (size(mu) == size(mu_old))
        dmu = max(max(abs(mu_old - mu)));
        if (dmu < EPSILON)  break;  end;
    end;

end;


% Expand hyperparameters 
gamma_ind = sort(keep_list);
gamma_est = zeros(M,1);
gamma_est(keep_list,1) = gamma;  

% expand the final solution
X = zeros(M,L);
X(keep_list,:) = mu; 

if (PRINT) fprintf('\nFinish running ...\n'); end
return;




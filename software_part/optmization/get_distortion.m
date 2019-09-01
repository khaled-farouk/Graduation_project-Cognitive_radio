%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = get_distortion(beta,beta_set, D_at_beta_br,p)
%     idx_r = find(bitrate_set==r);
%     if(idx_r == 0)
%        disp('incorrect index'); 
%     end
    
    idx_beta = find(beta_set==beta);
    if(idx_beta == 0)
       disp('incorrect index'); 
    end
    
    D = D_at_beta_br(1,idx_beta,p+1);
end
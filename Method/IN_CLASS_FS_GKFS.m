function feature_slcted=IN_CLASS_FS_GKFS(X,Y,delta,feature_lft,n_FeaSelec,threshold,tree)
fprintf('���е��ļ�IN_CLASS_FS_GKFS.m--�������ƶ�\n');
n_feature_lft=length(feature_lft);
parfor i=1:n_feature_lft   
   array_tmp=[X(:,feature_lft(i)),Y];
   efc_tmp(i)=mean_dependency_s_gs(array_tmp,delta);
end
[va,in]=max(efc_tmp);
feature_slct=in;
sig_fea_sel=va;


for i=1:n_feature_lft
    %����
    if(mod(i,1000)==0)
        fprintf('++++++++++++++++++++ѭ������ǰ���㵽%d��������ʣ��%d������++++++++++++++++++++++\n',i,length(feature_lft)-i);
    end
        
   array_tmp=[X(:,feature_slct),X(:,feature_lft(i)),Y];
   efc_tmp(i)=mean_dependency_s_gs(array_tmp,delta);
   if (i==1 && efc_tmp(i)-va>threshold) || (i>=2 && efc_tmp(i)-efc_tmp(i-1)>threshold)
       feature_slct=[feature_slct,feature_lft(i)];
       if i==1
            sig_fea_sel=[sig_fea_sel,efc_tmp(i)-va>threshold];
       else
           sig_fea_sel=[sig_fea_sel,efc_tmp(i)-efc_tmp(i-1)];
       end
   end
end

[~,ind]=sort(sig_fea_sel);
if length(ind)>=n_FeaSelec
    feature_slcted=feature_slct(ind(1:n_FeaSelec));
else
    feature_slcted=feature_slct;
end



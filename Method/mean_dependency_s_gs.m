% compute the generalized dependency with S-T fuzzy rough sets
% Some mistakes are revised by Hong Zhao in 2015-12-15
function r=dependency_s_gs(data_array,delta)
ss=delta;
[m,n]=size(data_array);
class=unique(data_array(:,end));
r=0;
rowrank=randperm(m);
C=data_array(rowrank,:);
dist=[];
for k=1:length(class)
    x=C(:,end)==class(k);
    label_same=find(x);%找到同类样本的索引
    label_same=label_same';
    array_same=C(label_same,:); %同类样本集合
    array_same_mean=mean(array_same,1);
    P=array_same_mean(:,1:n-1);
    x=C(:,end)~=class(k);
    label_diff=find(x);%找到异类样本的索引
    label_diff=label_diff';
    array_diff=C(label_diff,:); %异类样本集合
    array_diff_mean=mean(array_diff,1);
    Q=array_diff(:,1:n-1);
    d=hausdorff(P,Q); 
    dist=[dist,d];
    
end
r=mean(dist);
end

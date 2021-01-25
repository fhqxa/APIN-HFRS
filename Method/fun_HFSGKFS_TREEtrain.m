function [Fea_S] = fun_HFSGKFS_TREEtrain( X, Y,tree,delta,num_FeaSelec,n,threshold)
 
    fprintf('运行到文件fun_HFS_GKFS_TREEtrain.m\n');
    indexRoot = tree_Root(tree);
    internalNodes = tree_InternalNodes(tree);
    noLeafNode =[indexRoot;internalNodes];
    n_noLeafNode=length(noLeafNode);
    
%     parfor i = 1:n_noLeafNode
%         feature_lft=(1:n); 
%         i_node = noLeafNode(i);
%         if(isempty(Y{i_node})==0)
%             fprintf('-----------------------------------------对第%d个内部节点做特征选择-------------------------------------\n',i);
% %             fprintf('---------------------------------------------当前内部节点编号为%d--------------------------------------\n',i_node);
%             t{i} = IN_CLASS_FS_GKFS(X{i_node},Y{i_node},delta,feature_lft,num_FeaSelec,threshold,tree);
%         end
%     end 
    for i=1:n_noLeafNode
        i_node = noLeafNode(i);
        Fea_S{i_node}=(1:n);%t{i}
    end
end
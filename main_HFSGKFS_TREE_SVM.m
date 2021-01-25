
%%

 clear;
 clc;

 format long g;
 DataName='VOC';
 
A=[5,25,50,75,100,125,150];
B=[10,50,100,150,200,250,300];
C=[50,200,400,620,820,1024,1230];

for i=1:1
num_FeaSelec=200;%B (i);
threshold=2*10^(-2);
datafileTrain = [DataName 'Train.mat'];
datafileTest = [DataName 'Test.mat'];
%  datafileTrain = [DataName '.mat'];    
%  datafileTest = [DataName '.mat'];
 delta=0.9;
 load(datafileTrain);
 [m,z]=size(data_array);
 n=z-1;
%  X=data_array(:,1:n);
%  for i=1:n
%      A(1,i)=norm(X(:,i));
%  end
%  A=repmat(A,m,1);
%  Y=X./A;
%  data_array(:,1:n)=Y;
%% ��γ��� �����ݵ�ÿһ���У���һ��������ȡ���ݣ�����ѵ������ʣ�µ���Ϊ���Լ�
labels=data_array(:,end);
data=[];
% for label=1:length(unique(labels))
%     cate = find(labels==label);
%     index=floor(1+(length(cate)-1)*rand(floor(30),1))'; 
%     data=[data;data_array(index,:)];
% end
 
 index=floor(1+(m-1)*rand(floor(1*m),1))'; 
 [XX,YY]=creatSubTable_Train(data_array(index,:),tree);
 clear data_array;
 

K_fold = 10;

%% SVM classifier
K_Relief = 5;                % the parameter of Relief function
    % ����ѵ�����ӱ�X��Y��tree
    %datafile = [DataName 'TrainSubTable.mat'];
    %datafile = [DataName '.mat'];
    load (datafileTest);
    
    % ѵ�����ϣ�����ѡ��,�õ���Fea_Sel_id
    internalNodes = tree_InternalNodes(tree);
    n_internalNodes  = length(internalNodes);
    N_feature = size(XX{tree(:,2)==0},2);
    
    tic;
    [Fea_Sel_id] = fun_HFSGKFS_TREEtrain( XX,YY,tree,delta,num_FeaSelec,n,threshold);
    TimeTrain = toc;
    save Fea_Sel_id;
    
    % ������Լ�
    load (datafileTest);
    
    % ���Լ���90%�ϣ�ѵ��SVM,�õ�model_svm; 10%�Ĳ��Լ����в��ԡ��������н�� 
    svm_opt = '-s 0 -c 1 -t 0 -q';
    [Model_HierSVM,TimeTest,RealLabel,OutLabel,Acc,AccStd,F_LCA,FH,TIE] = HFSGKFS_TREE_K_fold_SVMclassifier(data_array,tree,K_fold,Fea_Sel_id,svm_opt);
    clear data_array;
     %save
    FilePathFull =[ 'F:\MatlabSpace\QiuZY\FRS\Result']; %
    if (~exist(FilePathFull))
        mkdir(FilePathFull);
    end
        filename = ['HFRS_',DataName,'_',num2str(num_FeaSelec),'.mat'];
        fullFileName = fullfile(FilePathFull, filename);
    save(fullFileName,'threshold','num_FeaSelec','Acc', 'F_LCA', 'FH', 'TIE', 'Fea_Sel_id', 'TimeTrain', 'TimeTest');
    
    filename = [DataName '_HFRS_SVM_Results']
disp('..... HFRS ... Finshed! ....')

%% KNN classifier
% K_KNN = 5;
% for i_dataset = 1:n_datasets
%     datafile = [str{i_dataset} 'train_HRelief_model'];
%     load (datafile);    % Fea_id, Fea_Sel_id
%     
%     % �����׼����Ĳ��Լ�
%     datafile = [str{i_dataset} 'Test_norm.mat'];
%     load (datafile);
% 
%     % ���Լ���90%�ϣ�ѵ��KNN,�õ�model_KNN; 10%�Ĳ��Լ����в��ԡ��������н�� 
%     [Model_KNN,TimeTest,RealLabel,OutLabel,Acc,AccStd,F_LCA,FH,TIE] = FeatureSelected_K_fold_KNNclassifier(data_array,tree,K_fold,Fea_Sel_id,K_KNN);
%     filename = [str{i_dataset} 'HRelief_' int2str(K_fold) '_fold_KNN_' int2str(K_KNN) '_classifier'];
%     save(filename,'Fea_id','Fea_Sel_id','grcModel_KNN','TimeTest','RealLabel','OutLabel','Acc','AccStd','F_LCA','FH','TIE','K_KNN');
% end
%%
% RealLabel 10�ۣ�����ʱ10����ʵ��ǩ��
% OutLabel  10�ۣ�����ʱ10��Ԥ��õ��ı�ǩ��
      end

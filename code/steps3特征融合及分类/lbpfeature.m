%% ����HOG + LBP����
function [hogfeature,hoglabel]=lbpfeature(scr,imageSize,hsize)
%% 1 ���ݼ�������ѵ���ĺͲ��Ե� 
% currentPath = pwd;  % ��õ�ǰ�Ĺ���Ŀ¼
filename=char(scr);
trianhog = imageDatastore(fullfile(pwd,filename),... 
    'IncludeSubfolders',true,... 
    'LabelSource','foldernames');   % ����ͼƬ����
 
% testhog = imageDatastore(fullfile(pwd,'Test21'),... 
%     'IncludeSubfolders',true,... 
%     'LabelSource','foldernames');
 
% imdsTrain = imageDatastore('C:\Program Files\MATLAB\R2017a\bin\proj_xiangbin\train_images',... 
%     'IncludeSubfolders',true,... 
%     'LabelSource','foldernames'); 
% imdsTest = imageDatastore('C:\Program Files\MATLAB\R2017a\bin\proj_xiangbin\test_image'); 
   
%%   2 ��ѵ�����е�ÿ��ͼ�����hog������ȡ������ͼ��һ�� 
% Ԥ����ͼ��,��Ҫ�ǵõ�features������С���˴�С��ͼ���С��Hog����������� 
 
% %% LBP����
imageSize = [imageSize,imageSize];% ������ͼ����д˳ߴ������ 
% I = readimage(trianhog,1);
% I = imresize(I,imageSize); 
% I = rgb2gray(I);
% lbpFeatures = extractLBPFeatures(I,'CellSize',[32 32],'Normalization','None');
% numNeighbors = 8;
% % Upright = false;
% numBins = numNeighbors*(numNeighbors-1)+3; % numNeighbors+2;
% lbpCellHists = reshape(lbpFeatures,numBins,[]);
% lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
% lbpFeatures = reshape(lbpCellHists,1,[]);
% % ������ѵ��ͼ�����������ȡ 
numImages = length(trianhog.Files); 
% featuresTrain1 = zeros(numImages,size(lbpFeatures,2),'single'); % featuresTrainΪ������
% % featuresTest1 = zeros(numImages,size(lbpFeatures,2),'single'); 
   
% scaleImage = imresize(I,imageSize); 
% [features, visualization] = extractHOGFeatures(scaleImage,'CellSize',[8,8]);
% featuresTrain2 = zeros(numImages,size(features,2),'single'); % featuresTrainΪ������
% featuresTrain1 = zeros(numImages,size(features,2),'single'); % featuresTrainΪ������
for i = 1:numImages 
    imageTrain = readimage(trianhog,i); 
    imageTrain = imresize(imageTrain,imageSize); 
    % LBP
    I = rgb2gray(imageTrain);
    lbpFeatures = extractLBPFeatures(I,'CellSize',[hsize hsize],'Normalization','None');
%     numNeighbors = 8;
%     numBins = numNeighbors*(numNeighbors-1)+3;
%     lbpCellHists = reshape(lbpFeatures,numBins,[]);
%     lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
%     lbpFeatures = reshape(lbpCellHists,1,[]);
    
    featuresTrain1(i,:) = lbpFeatures; 
     
    % HOG
%     featuresTrain2(i,:) = extractHOGFeatures(imageTrain,'CellSize',[hsize,hsize]);   
     
end 
 
% �����ϲ�
featuresTrain = featuresTrain1;
% featuresTrain = featuresTrain2;
% featuresTrain = featuresTrain1;
% ����ѵ��ͼ���ǩ 

trainLabels = trianhog.Labels; 
% for ihog=1:numClasses
%     for jhog=1:(numImages/numClasses)
%         hog{1,i}=featuresTrain(jhog+((numImages/numClasses)*ihog),:);
%         hog{2,i}=cellstr(trainLabels(jhog((numImages/numClasses)*ihog),1));
%     end
% end
for ihog=1:numImages
    hog{1,ihog}=featuresTrain(ihog,:);
    hog{2,ihog}=cellstr(trainLabels(ihog,1));
end
for ijsq=1:numImages
    kp=hog{1,ijsq};
    hogfeature(ijsq,:)=kp;
    hoglabel(1,ijsq)=hog{2,ijsq};
end

% save('hog.mat',hog)
clear lbpfeature
end

        
% ��ʼsvm�����ѵ����ע�⣺fitcsvm���ڶ����࣬fitcecoc���ڶ����,1 VS 1���� 
% classifer = fitcecoc(featuresTrain,trainLabels); 
% %    
% correctCount = 0;
% % Ԥ�Ⲣ��ʾԤ��Ч��ͼ 
% numTest = length(testhog.Files); 
% for i = 1:numTest 
%     testImage = readimage(testhog,i);  %  imdsTest.readimage(1)
%     scaleTestImage = imresize(testImage,imageSize); 
%     % LBP
%     I = rgb2gray(scaleTestImage);
%     lbpFeatures = extractLBPFeatures(I,'CellSize',[16 16],'Normalization','None');
%     numNeighbors = 8;
%     numBins = numNeighbors*(numNeighbors-1)+3;
%     lbpCellHists = reshape(lbpFeatures,numBins,[]);
%     lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
%     featureTest1 = reshape(lbpCellHists,1,[]);
%      
%     % HOG
%     featureTest2 = extractHOGFeatures(scaleTestImage,'CellSize',[8,8]);
%     %�ϲ�
%     featureTest = featureTest2;
%     
%     [predictIndex,score] = predict(classifer,featureTest); 
%    % figure;imshow(imresize(testImage,[256 256]));
%      
%     imgName = testhog.Files(i);
%     tt = regexp(imgName,'\','split');
%     cellLength =  cellfun('length',tt);
%     tt2 = char(tt{1}(1,cellLength));
%         % ͳ����ȷ��
%     if strfind(tt2,char(predictIndex))==1
%         correctCount = correctCount+1;
%     end
%     title(['predictImage: ',tt2,'--',char(predictIndex)]); 
%     fprintf('%s == %s\n',tt2,char(predictIndex));
% end
%  
% % ��ʾ��ȷ��
% fprintf('�����������ȷ��Ϊ��%.3f%%\n',correctCount * 100.0 / numTest);
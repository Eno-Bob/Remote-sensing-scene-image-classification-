

%%��ȡ��������
scrtrain=* %·��
imageSize = 256;
hsize=50;
[featuretrain_hog,~]=hogfeature(scrtrain,imageSize,hsize);
[featuretest_hog,~]=hogfeature(scrtest,imageSize,hsize);  %��ȡ����������·��Ϊ���ֵ�ѵ������Ϊ��ȡѵ����������ע�����ǩһ��

%%���������������ں�
feature_train=[mapminmax(features_train_juanji,0,1),mapminmax(features_train_lbp,0,1)];
feature_test=[mapminmax(features_test_juanji,0,1),mapminmax(features_test_lbp,0,1)];

%%���ںϵ���������
[label_lbp,score_lbp,accuracy_lbp]= svmfenlei(featuretrain_lbp,labeltrainnum,featuretest_lbp,labeltestnum);
[label_train,score_test,accuracy_all]= svmfenlei(feature_train,labeltrainnum,feature_test,labeltestnum);
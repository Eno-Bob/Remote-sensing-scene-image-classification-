function [label,score,accuracy]=svmfenlei(trainfeature,labeltrainnum,testfeature,labeltestnum)
aqishi =fitcecoc(trainfeature,labeltrainnum,'Learners','svm');
[label,score] = predict(aqishi,testfeature);
accuracy = mean(label ==labeltestnum);
clear svmfenlei
end


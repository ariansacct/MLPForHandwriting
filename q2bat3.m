clc
clear
% fid = fopen('iris.data');
% temp = textscan(fid, '%f32 %f32 %f32 %f32 %s', 'delimiter', ',');
% 
% in = [temp{1} temp{2} temp{3} temp{4} strcmp(temp{5}, 'Iris-setosa')];
% in(1,1) = 5.1;
% andis = find(in(:,5)==0);
% in(andis,5) = 2;
% 
% inds1 = find(in(:,5) == 1);
% class1data = in(inds1,:);
% 
% inds2 = find(in(:,5) == 2);
% class2data = in(inds2,:);
% 
% % scatter(class1data(:,1), class1data(:,2));
% % hold on
% % scatter(class2data(:,1), class2data(:,2));
% 
% train_inds = randsample(1:150, 127);
% test_inds = setdiff(1:150, train_inds);
% 
% features_train = in(train_inds,1:4);
% features_test = in(test_inds,1:4);
% 
% targets_train = in(train_inds,5);
% targets_test = in(test_inds,5);
% 
% save q2data.mat
% pause

load q2data.mat

scatter3(class1data(:,1), class1data(:,2), class1data(:,3), 'filled')
hold on
scatter3(class2data(:,1), class2data(:,2), class2data(:,3), 'filled')
hold off

figure
scatter3(class1data(:,1), class1data(:,2), class1data(:,4), 'filled')
hold on
scatter3(class2data(:,1), class2data(:,2), class2data(:,4), 'filled')
hold off

figure
scatter3(class1data(:,1), class1data(:,3), class1data(:,4), 'filled')
hold on
scatter3(class2data(:,1), class2data(:,3), class2data(:,4), 'filled')
hold off

figure
scatter3(class1data(:,2), class1data(:,3), class1data(:,4), 'filled')
hold on
scatter3(class2data(:,2), class2data(:,3), class2data(:,4), 'filled')
hold off

train_errmat = zeros(1,50);   % neshandahandeye khataye tabaghebandie dadehaye train dar har epoch
test_errmat = zeros(1,50);    % neshandahandeye khataye tabaghebandie dadehaye test dar har epoch


w = rand(1,5);   % w0 ham tooshe
w
output_mat = zeros(size(features_train,1), 1);
for d = 1:size(features_train,1)
    output_mat(d,1) = perceptron(features_train(d,:), w);
end



% batch

msearr_train = zeros(1,50);
msearr_test = zeros(1,50);

gradient_E = zeros(1, 5);

for iter = 1:50

    
    for i=0:4

        result = 0;
        for d = 1:size(features_train,1)
            if i==0
                result = result + ( (targets_train(d,1)-output_mat(d,1)) * 1  );
            else
                result = result + ( (targets_train(d,1)-output_mat(d,1)) * features_train(d,i)  );
            end
        end

        gradient_E(i+1) = result;   % shifte andis bekhatere bias
%         result
    end
    
    % alan hameye dadeha barresi shodan va gradiane average error function
    % hesab shod


    delta_w =  0.0002 * gradient_E;
    w = w + delta_w;
    
    delta_w
    w
    
    for d = 1:size(features_train,1)
        output_mat(d,1) = perceptron(features_train(d,:), w);
    end

    train_errcount = 0;
    for j = 1:size(features_train,1)
        if perceptron(features_train(j,:), w) ~= targets_train(j,1)
            train_errcount = train_errcount + 1;
        end
    end
    
    test_errcount = 0;
    for j = 1:size(features_test,1)
        if perceptron(features_test(j,:), w) ~= targets_test(j,1)
            test_errcount = test_errcount + 1;
        end
    end
    
    
    
    
    train_errmat(1, iter) = (train_errcount / size(features_train,1)) * 100;
    test_errmat(1, iter) = (test_errcount / size(features_test,1)) * 100;
    
    disp('Epoche shomareye: ')
    iter
    train_errmat
    test_errmat
    
    
    % MSE
    sum = 0;
    for ctr = 1:size(features_train,1)
        sum = sum + (output_mat(ctr,1) - targets_train(ctr,1))^2;
    end
    msearr_train(1,iter) = sum / size(features_train,1);
    
    
    sum = 0;
    for ctr = 1:size(features_test,1)
        sum = sum + (perceptron(features_test(ctr,:), w) - targets_test(ctr,1))^2;
    end
    msearr_test(1,iter) = sum / size(features_test,1);
    % MSE
end

figure
plot(msearr_train)
figure
plot(msearr_test)
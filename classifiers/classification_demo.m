function class_out = classification_demo(hsi_img, train_data, mask, wavelength)
%
%function class_out = classification_demo(hsi_img, train_data, mask, wavelength)
% 
% Demo that runs all classifiers in the hsi_toolkit
% 
% How to run using example sub MUUFL Gulfport data:
%   (1) load an_hsi_img_for_class_demo.mat
%   (2) run `class_out = classification_demo(hsi_sub, train_data, [], wavlength)`
% 
% inputs:
%  hsi_img - n_row x n_col x n_band hyperspectral image
%  train_data - structure containing training data, train_data(i).Spectra
%       is matrix containing spectra from class i, train_data(i).name is the
%       name of the ith class label
%  mask - binary image limiting detector operation to pixels where mask is true
%         if not present or empty, no mask restrictions are used
%  wavelength - 1 x n_band vector listing wavelength values for hsi_img in nm
% 
% outputs:
%   class_out - cell array of classifier outputs
% 
% 6/3/2018 - Alina Zare
%

addpath(fullfile('..','util'));


%% Classifiers

% knn
i = 1;
class_out{i}.params.k = 3;
class_out{i}.result = knn_classifier(hsi_img,train_data,[],class_out{i}.params.k);
class_out{i}.method = 'KNN';

%% Visualize
figure;
numR = 1;
numC = ceil((i+1)/numR); 
subplot(numR,numC,1); imagesc(get_RGB(hsi_img, wavelength)); title('RGB image');
for i = 1:length(train_data)
    TickLabels{i} = train_data(i).name;
end
for i = 1:length(class_out)
	subplot(numR, numC, i+1); imagesc(class_out{i}.result); title(class_out{i}.method);
    colorbar('Ticks',[1:length(train_data)],'TickLabels',TickLabels)
end

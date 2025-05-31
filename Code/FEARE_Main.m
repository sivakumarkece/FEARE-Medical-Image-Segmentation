%% FEARE_Main.m
%%% Fuzzy Entropy Adaptive Region Energy (FEARE) Segmentation

clc; clear all; close all;

% Add Paths
currentFolder = fileparts(mfilename('fullpath'));
addpath(genpath(currentFolder));

% Dataset path
base_path = 'E:\RESEARCH\MISCD_V2\DATASET_FOR_EXP_1';
folders = {
    '1. Heart failure with infarction (HF-I)', 'HF-I_results';
    '2. Heart failure without infarction (HF)', 'HF-NI_results';
    '3. LV hypertrophy (HYP)', 'HYP_results';
    '4. Healthy (N)', 'Healthy_results'
};

% Parameters
params.gamma = 9;
params.alpha = 0.6;
params.mu = 0.6;
params.nu = 0.0005 * 255^2;
params.lambda1 = 0.4;
params.lambda2 = 0.5;
params.eps = 1;
params.eta = 0.09;
params.iterNum = 300;
params.sigma = 9;
params.search_radius = 21;

for folder_idx = 1:size(folders, 1)
    folder_name = folders{folder_idx, 1};
    output_filename = folders{folder_idx, 2};
    dicom_path = fullfile(base_path, folder_name, 'DICOM');
    gt_path = fullfile(base_path, folder_name, 'GROUND TRUTH');

    dicom_folders = dir(dicom_path);
    gt_folders = dir(gt_path);
    dicom_folders = dicom_folders([dicom_folders.isdir] & ~startsWith({dicom_folders.name}, '.'));
    gt_folders = gt_folders([gt_folders.isdir] & ~startsWith({gt_folders.name}, '.'));

    metricsTable = table('Size', [0, 12], 'VariableTypes', ...
        {'string','double','double','double','double','double','double','double','double','double','double','double'}, ...
        'VariableNames', {'ImageName','DSC','IoU','Precision','Recall','APD','MAD','HD','FD','ExecutionTime','MemoryUsage','GeometricShapeMetrics'});

    for sub_idx = 1:length(dicom_folders)
        dicom_sub = dicom_folders(sub_idx).name;
        gt_sub = gt_folders(sub_idx).name;
        dicom_files = dir(fullfile(dicom_path, dicom_sub, '*.dcm'));
        gt_files = dir(fullfile(gt_path, gt_sub, '*-icontour-manual.txt'));

        for j = 1:min(length(dicom_files), length(gt_files))
            gt_name = gt_files(j).name;
            [~, base_name, ~] = fileparts(gt_name);
            base_name = regexprep(base_name, '-icontour-manual$', '');
            dicom_file = fullfile(dicom_path, dicom_sub, [base_name '.dcm']);
            gt_file = fullfile(gt_path, gt_sub, gt_name);

            if isfile(dicom_file)
                I = double(dicomread(dicom_file));
                gt_data = load(gt_file);
                [rows, cols] = size(I);

                % Region of interest
                centroid = round(mean(gt_data, 1));
                xR = max(1, centroid(1)-params.search_radius):min(cols, centroid(1)+params.search_radius);
                yR = max(1, centroid(2)-params.search_radius):min(rows, centroid(2)+params.search_radius);
                region = I(yR, xR);

                entropyMap = mat2gray(entropyfilt(region));
                confidence = 1 ./ (1 + params.alpha * entropyMap);
                K = fspecial('gaussian', 1 + 4 * params.sigma, params.sigma);

                phi = -2*ones(size(region));
                phi(round(end/2)-2:round(end/2)+2, round(end/2)-2:round(end/2)+2) = 2;
                lv_mask = zeros(size(region));
                lv_mask(round(end/2), round(end/2)) = 1;
                lv_mask = imdilate(lv_mask, strel('disk', params.search_radius));

                tic;
                for iter = 1:params.iterNum
                    M1 = 1 ./ (1 + exp(-params.gamma * phi));
                    M2 = 1 - M1;
                    D = (1/pi) * (params.eps ./ (params.eps^2 + phi.^2));

                    f1 = conv2(region .* M1, K, 'same') ./ (conv2(M1, K, 'same') + eps);
                    f2 = conv2(region .* M2, K, 'same') ./ (conv2(M2, K, 'same') + eps);
                    e1 = (region - f1).^2;
                    e2 = (region - f2).^2;

                    dataForce = -D .* confidence .* (params.lambda1 * M1 .* e1 - params.lambda2 * M2 .* e2);
                    curv = kappa(phi);
                    regTerm = params.nu * D .* curv + params.mu * (del2(phi) - curv);
                    phi = phi + params.eta * (dataForce + regTerm) .* lv_mask;
                end
                t = toc;

                seg = phi > 0;
                seg = bwareafilt(seg,1);
                seg = smoothconvhull(seg);

                full_seg = false(size(I));
                full_seg(yR, xR) = seg;
                gt_mask = poly2mask(gt_data(:,1), gt_data(:,2), rows, cols);

                DSC = dice(full_seg, gt_mask);
                IoU = jaccard(full_seg, gt_mask);
                P = precision(full_seg, gt_mask);
                R = recall(full_seg, gt_mask);
                APD = average_perpendicular_distance(full_seg, gt_mask);
                MAD = mean_absolute_distance(full_seg, gt_mask);
                HD = hausdorff_distance(full_seg, gt_mask);
                FD = frechet_distance(full_seg, gt_mask);
                memory_usage = memory; memory_usage = memory_usage.MemUsedMATLAB / 1e6;
                GSM = geometric_shape_consistency(full_seg, gt_mask);

                metricsTable = [metricsTable; {base_name, DSC, IoU, P, R, APD, MAD, HD, FD, t, memory_usage, GSM}];
            end
        end
    end
    writetable(metricsTable, [output_filename '.xlsx']);
end

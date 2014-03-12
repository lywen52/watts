function extract_features(opts)
disp('* Extracting FV features *');
% Extracts the FV representation for every image in the dataset

if  ~exist(opts.fileFeatures,'file')
      
    if ~exist(opts.fileGMM,'file')
        toc = readImagesToc(opts.fileImages);
        % Computes GMM and PCA models
        idxTrainGMM = sort(randperm(length(toc),opts.numWordsTrainGMM));
        [fid,msg] = fopen(opts.fileImages, 'r');
        getImage = @(x) readImage(fid,toc,x);
        images = arrayfun(getImage, idxTrainGMM', 'uniformoutput', false);
        fclose(fid);
        [GMM,PCA] = compute_GMM_PCA_models(opts,images);
        writeGMM(GMM,opts.fileGMM);
        writePCA(PCA, opts.filePCA); 
        clear images;
    end
    
    % Extracts FV representation from dataset images using the GMM and PCA
    % models
    
    %GMM = readGMM(opts.fileGMM);
    %PCA = readGMM(opts.filePCA);
    %images = readImages(opts.fileImages);
    %tic;feats = extract_FV_features(opts,images,GMM,PCA);disp(toc);
    
    extract_FV_features_fast(opts);
    
    %save(opts.fileFeatures,'features','-v7.3');
end

end
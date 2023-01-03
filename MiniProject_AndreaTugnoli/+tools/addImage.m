function stageData = addImage(stageData)
    % addImages: adding one or more Images to the stageData
    
    multiImages = iscell(stageData.image);
    if ~multiImages
        stageData.image = {stageData.image};
    end
    
    for currentImage = 1:numel(stageData.image)
        % read image and add fields to stageData
        stageData.originData{currentImage} = imread(stageData.image{currentImage});
        stageData.scaledData{currentImage} = ...
            imresize(stageData.originData{currentImage}, stageData.scale{currentImage});
    end
    
    if ~multiImages
        stageData.originData = stageData.originData{:};
        stageData.scaledData = stageData.scaledData{:};
    end

    % add ptrIdx for visualizing
    stageData.ptrIdx     = nan;

end
function array = randDrawSingleRep(nrOptions, nrDraws)
% About and copyright
% Author: Adrian Etter
% E-Mail: adrian.etter@econ.uzh.ch
% ? SNS-Lab,
% University of Zurich
% Version 1.0 2012/Sept/28
% Last revision: 2012/Sept/28
% -finished

    if nrOptions < 2
        error('randDrawSingleRep:nrOptions', 'You cannot choose from a single option');
    end
    
    %% Shuffle Random Generator
    rng('shuffle');
    
    %% Calculate Number of Ellements
    nrElements = nrOptions * nrDraws;
    
    %% Allocate Arrays
    array       = nan(nrElements, 1);   % The array where we store the output
    drawCount   = zeros(nrOptions, 1);  % Here we store how many times we draw a specific option
    options     = (1:nrOptions)';       % The array with the available options
    % Here we store which option is blocked and can't be redrawed. We add
    % one Element. In the last element we will store the last element
    % drawed.
    blockedOptions = zeros(nrOptions + 1, 1);   
    %% Now, for the nr of elements we want, let's draw
    for i = 1 : nrElements
        %% Let's figure out the available options for this draw
        availableOptions = setdiff(options, blockedOptions);
        %% Let's draw from the available options
        if isempty(availableOptions)
            array = [];
            return;
        end
        array(i) = availableOptions(randi(size(availableOptions, 1), 1, 1));
        %% We overwrite the last element from our blocked options with the just drawed number
        blockedOptions(end) = array(i);
        %% Now we increase the number of counts of draws for the drawed option.
        drawCount(blockedOptions(end)) =  drawCount(blockedOptions(end)) + 1;
        %% We have to check, if a drawed number already reached the maximum of allowed drawings
        idxToBlock = find(drawCount == nrDraws);
        %% If a option reached the number of allowed drawings, we add it to the array of blocked options.
        blockedOptions(idxToBlock) = idxToBlock;
    end
end
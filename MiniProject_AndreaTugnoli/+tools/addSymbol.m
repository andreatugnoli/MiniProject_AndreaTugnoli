function stageData = addSymbol(stageData, symbol)

    % check if exist
    if ~exist('symbol', 'var')
        symbol = '+';
    end
    
    % add symbol to stageData
    if isempty(stageData)
        stageData = struct( ...
                            'symbol', symbol ...
                            );
    else
        stageData.symbol = symbol;
    end
end
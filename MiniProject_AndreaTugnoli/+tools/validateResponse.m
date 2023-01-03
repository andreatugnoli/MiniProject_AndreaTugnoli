function isCorrect = validateResponse(key1, key2)
    % validateResponse: compares the string key1 and key2
    %
    % SYNTAX:   isCorrect = tools.validateResponse(key1, key2)
    %
    % INPUTS:
    %           key1            string of the first key
    %           key2            string of the second key
    %
    % OUTPUTS:
    %           isCorrect       are the keys corresponding
    %
    % EXAMPLE:
    %           isCorrect = tools.validateResponse('k', 'k');
    %           the output will be true
    %

    isCorrect = strcmp(key1, key2);

end

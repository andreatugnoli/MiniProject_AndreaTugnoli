function stageData = instruction()
    % instruction: creates the instruction type specific stage
    % data
    %
    % SYNTAX:   stageData = types.instruction()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for instruction
    %
    % EXAMPLE:
    %           stageData = types.instruction();
    %

    % type specific variables
    title      = 'Instructions';
    textTop    = ...
        ['In this experiment you will pictures and you have to guess if' ...
        '\nthey are paintings.'];
    textButtom = ['The picture appears in the centre of the screen.\n' ...
        '- You have 3 seconds to answer! -'];
    textLeft   = ['If the picture is a painting,\n' ...
        'press the left button %s'];
    textRight  = ['If the picture is not a painting,\n' ...
        'press the right button %s'];
    text2invert = {'(j)\n- right index finger', '(k)\n- right middle finger'};

    % initial BaseStruct of type task
    stageData = struct( ...
        'text2invert', '' ...
        );

    % defining parameters for type task
    stageData = tools.addText(stageData, 'textTitle',  title);
    stageData = tools.addText(stageData, 'textTop',    textTop);
    stageData = tools.addText(stageData, 'textButtom', textButtom);
    stageData = tools.addText(stageData, 'textLeft',   textLeft);
    stageData = tools.addText(stageData, 'textRight',  textRight);
    
    stageData = tools.addSymbol(stageData);
    stageData.text2invert = text2invert;
end

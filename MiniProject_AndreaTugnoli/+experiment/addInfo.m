function experimentInfo = addInfo(varargin)
    % addInfo: creates the experimental information for the whole experiment,
    % inclusively the default parameters. If some variables should be changed,
    % add them as key, value pair.
    %
    % SYNTAX:   experimentInfo = ...
    %               experiment.addInfo('nrTrials',   nrTrials, ...
    %                                  'screenRect', screenRect, ...
    %                                  'expToolbox', expToolbox, ...
    %                                  'fontSize',   fontSize, ...
    %                                  'fontName',   fontName, ...
    %                                  'allowedOffset', allowedOffset)
    %
    % INPUTS e.g.:
    %           nrTrials       	number of Trials of the individual tasks
    %           screenRect      rectangular of the screen window
    %                           (default: [0, 0, 800, 600])
    %           expToolbox      used toolbox for visualization
    %                           (default: 'psychtoolbox')
    %           fontSize        default font size for the experiment
    %                           (default: 26)
    %           fontName        default font name for the experiment
    %                           (default: 'Arial')
    %           allowedOffset   allowed offset for the whole experiment timeline
    %                           (default: 0.001)
    %
    %           Further options: title, experimenter, nrRuns, nrTasks, screenNumber
    %
    % OUTPUTS:
    %           experimentInfo  structure of the experiment information
    %                           inclusively default parameters
    %
    % EXAMPLE:
    %           nrTrials  = 3;
    %           taskOrder = readtable('taskOrder.txt');
    %           trials    = experiment.createTasks(taskOrder, nrTrials);
    %           stages    = experiment.randomize(trials);
    %           stages    = experiment.calculateAbsoluteTimeline(stages);
    %           result    = experiment.run(stages);
    %
    % Other Classes required:
    %           Working Psychtoolbox installation
    %
    % Other files required:
    %           See README.md
    %
    % See also:
    %           experiment.run();
    %           experiment.createTrials()
    %           experiment.createStage()
    %           experiment.createIntro()
    %           experiment.randomize()
    %           experiment.calculateAbsoluteTimeline()
    %           experiment.eventListener()
    %           experiment.nextStage()
    %           tools.calculateJitter()
    %           tools.validateResponse()
    %           tools.initialize()
    %           tools.colorPars()
    %           types
    %           eventHandle
    %           view.psychtoolbox
    %           eventListener.psychtoolbox
    %

    % screen info
    experimentInfo = struct( ...
        'title',              '', ...
        'experimenter',       '', ...
        'subject',            '', ...
        'date',               nan, ...
        'expToolbox',         '', ...
        'nrRuns',             nan, ...
        'nrTasks',            nan, ...
        'nrTrials',           nan, ...
        'trialBlockSize',     nan, ...
        'windowIdx',          nan, ...
        'screenRect',         nan, ...
        'screenNumber',       nan, ...
        'backgroundColor',    '', ...
        'currentStage',       nan, ...
        'nrIntroStages',      nan, ...
        'positionTaskStages', nan, ...
        'nrFinalStages',      nan, ...
        'timerIdx',           nan, ...
        'totalTime',          0, ...
        'viewParam',          struct([]), ...
        'defaultParam',       struct([]) ...
        );

    % default parameters of substruct
    experimentInfo.viewParam = struct( ...
        'fontName',          '', ...
        'fontSize',          nan, ...
        'fixationSize',      nan, ...
        'fontColor',         '', ...
        'fixationColor',     '' ...
        );
    
    experimentInfo.defaultParam = struct( ...
        'FONTSIZE',           nan, ...
        'FONTNAME',           '', ...
        'SCREENRECT',         nan, ...
        'ALLOWED_OFFSET',     nan ...
        );
    
    % default values
    defaultTitle         = 'Default Title';
    defaultExperimenter  = 'Unknown';
    defaultSubject       = 'Unknown';
    defaultToolbox       = 'psychtoolbox';
    defaultNrRuns        = 1;
    defaultNrTasks       = 1;
    defaultNrTrials      = 3;
    defaultScreenRect    = [0, 0, 1024, 768];
    defaultScreenNumber  = max(Screen('Screens'));
    defaultBGcolor       = 'black';
    
    defaultFontSize      = 26;
    defaultFontName      = 'Arial';
    defaultFontColor     = 'white';
    defaultAllowedOffset = 0.001;

    % initialize input parser
    inPars = inputParser;    
    
    % optional parameter inputs
    inPars.addParameter('title', defaultTitle, @ischar);
    inPars.addParameter('experimenter', defaultExperimenter, @ischar);
    inPars.addParameter('subject',      defaultSubject,      @ischar);
    inPars.addParameter('expToolbox',   defaultToolbox,      @ischar);
    inPars.addParameter('nrRuns',       defaultNrRuns,       @(x) isnumeric(x) && all(x) > 0);
    inPars.addParameter('nrTrials',     defaultNrTrials,     @(x) isnumeric(x) && all(x) > 0);
    inPars.addParameter('screenRect',   defaultScreenRect,   @(x) isnumeric(x) && numel(x) == numel(defaultScreenRect));
    inPars.addParameter('screenNumber', defaultScreenNumber, ...
        @(x) isnumeric(x) && x >= 0 && x <= max(Screen('Screens')));
    inPars.addParameter('backgroundColor', defaultBGcolor,   @ischar);
    inPars.addParameter('FONTSIZE',     defaultFontSize,     @(x) isnumeric(x) && x > 0);
    inPars.addParameter('FONTNAME',     defaultFontName,     @ischar);
    inPars.addParameter('ALLOWED_OFFSET', defaultAllowedOffset, @(x) isnumeric(x) && x > 0);
    
    inPars.parse(varargin{:});
    
    % fill parsed input to experimentInfo
    experimentInfo.title           = inPars.Results.title;
    experimentInfo.experimenter    = inPars.Results.experimenter;
    experimentInfo.subject         = inPars.Results.subject;
    experimentInfo.expToolbox      = inPars.Results.expToolbox;
    experimentInfo.nrRuns          = inPars.Results.nrRuns;
    experimentInfo.nrTrials        = inPars.Results.nrTrials;
    experimentInfo.screenRect      = inPars.Results.screenRect;
    experimentInfo.screenNumber    = inPars.Results.screenNumber;
    experimentInfo.backgroundColor = inPars.Results.backgroundColor;
    
    experimentInfo.defaultParam.FONTSIZE       = inPars.Results.FONTSIZE;
    experimentInfo.defaultParam.FONTNAME       = inPars.Results.FONTNAME;
    experimentInfo.defaultParam.ALLOWED_OFFSET = inPars.Results.ALLOWED_OFFSET;
    
    % fill experimentInfo.viewParam
    experimentInfo.viewParam.fontName      = defaultFontName;
    experimentInfo.viewParam.fontSize      = defaultFontSize;
    experimentInfo.viewParam.fontColor     = defaultFontColor;
    experimentInfo.viewParam.fixationSize  = defaultFontSize;
    experimentInfo.viewParam.fixationColor = defaultFontColor;
end

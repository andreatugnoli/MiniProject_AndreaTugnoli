function stageData = allTasks()
  % yieldTask: creates the allTasks type specific stage data
  %
  % SYNTAX:   stageData = types.allTasks()
  %
  % INPUTS:
  %           None
  %
  % OUTPUTS:
  %           stageData       stage specific struct for allTasks
  %
  % EXAMPLE:
  %           stageData = types.allTasks();
  %

    % type specific variables
    information    = 'This stage will be replaced by a set of Trials';

    % BaseStruct of type task
    stageData = struct([]);

    % defining parameters for type task
    stageData = tools.addText(stageData, 'textInfo', information);
end

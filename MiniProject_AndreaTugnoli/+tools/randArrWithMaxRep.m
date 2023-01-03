function [randArray, nrOfReshuffles] = randArrWithMaxRep(nrOfOptions, nrOfReps, maxContReps, verbose)
%randArrWithMaxRep creates a random array with a given nr of Options, a
%   given number of requierd repetions per option and a limit of maximal
%   allowed continous repetions 
%
% Syntax: randArrWithMaxRep(nrOfOptions, nrOfRepetitions, maxContinouseRepetitions, verbose)
%
% Inputs:
%   nrOfOptions:  The number of given options, e.g. 4
%   nrOfReps:     The number of repetions of each option, e.g. 10
%   maxContReps:  The maximal allowed continouse repetion, e.g. 2
%   verbose:      true/false, prints out if was reshuffled and plots the
%                 created array to have a visual feedback (default = false)
%
% Outputs:
%	randArray:      The created array
%   nrOfReshuffles: How many time it was reshuffled to get the requierd
%                   result
%
% Example:
%   [randArray, reshuff] = randArrWithMaxRep(4, 10, 2)
%   verbose
%   [randArray, reshuff] = randArrWithMaxRep(4, 10, 2, true)
%
% Other m-files required:
%   no
%
% Other Classes required:
%   no
% About and copyright
% Author: Adrian Etter
% E-Mail: adrian.etter@econ.uzh.ch
% ? SNS-Lab,
% University of Zurich
% Version 1.0 2012/Sept/28
% Last revision: 2012/Sept/28
% -finished

    % Input Error check:
    if ~exist('verbose', 'var')
        verbose = false;
    end
    
    if nrOfOptions < 2
        error('randArrWithMaxRep:nrOfOptions', 'You can''t choose from only one option!');
    end
    
    if maxContReps < 2 || maxContReps == (nrOfOptions * nrOfReps)
        randArray = tools.randDrawSingleRep(nrOfOptions, nrOfReps);
        nrOfReshuffles = 1;
        return;
    end
    
    if maxContReps >= (nrOfOptions * nrOfReps)
        error('randArrWithMaxRep:maxContReps', 'There can''t be more repetitions than options!');
    end
    
    % create order
    randArray = repmat((1:nrOfOptions)', nrOfReps, 1);
    
    % shuffle
    rng('shuffle'); % Better than rand('seed',sum(100*clock)); (depricated)
    randArray = randArray(randperm(size(randArray, 1)));
    
    % test that shuffled correctly
    shuffledCorrectly = false; % we assume it's not correct
    
    nrOfReshuffles = 0;
    while ~shuffledCorrectly
        % check if okay
        for i=(maxContReps+1):size(randArray, 1)
            % check if the last maxContReps numbers are the same, if so, 
            % lets re-shuffle
            if length(unique(randArray(i-maxContReps:i))) == 1
                nrOfReshuffles = nrOfReshuffles + 1;
                randArray = randArray(randperm(size(randArray, 1)));
                if verbose
                    disp('reshuffle');
                end
                break; % we have to start over again
            end
            
            if i==size(randArray, 1)
                % if we made it so far, we're lucky and it worked so we end it
                shuffledCorrectly = true;
            end
        end
    end
    
    if verbose
        % plot to make sure:
        pcolor([randArray'; repmat(1:nrOfOptions, 1, nrOfReps)]);
    end
end
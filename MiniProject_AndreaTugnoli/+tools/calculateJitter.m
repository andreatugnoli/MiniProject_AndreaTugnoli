function jitter = calculateJitter(jitterMean, samples, distribution, allowExtrem)
    % calculateJitter: calculates the jitter by the given distribution and samples
    %
    % SYNTAX:   jitter = tools.calculateJitter(jitterMean, samples, distribution)
    %
    % INPUTS:
    %           jitterMean      mean of the jitter distribution e.g. when linear
    %                           0.5 means +/- 0.5
    %           samples         how many samples/values
    %           distribution    which distribution do you wanna use
    %                           (default: 'gamma')
    %
    % OUTPUTS:
    %           jitter          the plus minus values with mean of zero
    %
    % EXAMPLE:
    %           jitter = tools.calculateJitter(1, 5, 'linear');
    %           jitter is then [-1, -0.5, 0, 0.5, 1]
    %
    % AUTHOR: Marc Biedermann
    % DATE:   15.11.17
    
    % check if distribution is an input
    if ~exist('distribution', 'var')
        distribution = 'gamma';
    end
    if ~exist('allowExtrem', 'var') || ~islogical(allowExtrem)
        allowExtrem = true;
    end

    % switch for cases of different distributions
    switch distribution
        case 'linear'
            jitter = linspace(0, 2 * jitterMean, samples);
        case 'gamma'
            jitter = gamrnd(2, jitterMean / 2, samples, 1);
        case 'gauss'
            jitter = normrnd(0, jitterMean / 2, samples, 1);
        otherwise
            error('invalid:jitter:naming', ...
                'The distribution for "%s" is not implemented. Use e.g. linear or gamma (default).', distribution)
    end
    
    jitter = jitter - mean(jitter);
    
    if ~allowExtrem
        while mean(jitter) ~= 0 && (any((jitter > abs(jitterMean))) || any((jitter < -abs(jitterMean))))
            jitter(jitter >  abs(jitterMean)) =  abs(jitterMean);
            jitter(jitter < -abs(jitterMean)) = -abs(jitterMean);
            jitter = jitter - mean(jitter);
        end
    end
end

function barplotResponsePortrait(avgCorrectPortrait, ...
    nrCorrectResponsesPortrait, ...
    nrIncorrectResponsesPortrait, ...
    nrNoResponsesSPortrait)

    bar([nrCorrectResponsesPortrait, nrIncorrectResponsesPortrait, nrNoResponsesSPortrait], 'stacked');
    axis tight;
    axis square;

    
    ylabel('Trial number');
    title(sprintf(...
        'Bar plot of responses after a portrait\navg. correct: %.1f %%', ...
        round(avgCorrectPortrait, 1)));

    legend('correct', 'incorrect', 'no response', 'Location','bestoutside');
end
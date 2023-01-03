function barplotResponseLandscape(avgCorrectLandscape, ...
    nrCorrectResponsesLandscape, ...
    nrIncorrectResponsesLandscape, ...
    nrNoResponsesLandscape)

    bar([nrCorrectResponsesLandscape, nrIncorrectResponsesLandscape, nrNoResponsesLandscape], 'stacked');
    axis tight;
    axis square;

   
    ylabel('Trial number');
    title(sprintf(...
        'Bar plot of responses after a Landscape\navg. correct: %.1f %%', ...
        round(avgCorrectLandscape, 1)));

    legend('correct', 'incorrect', 'no response', 'Location','bestoutside');

end
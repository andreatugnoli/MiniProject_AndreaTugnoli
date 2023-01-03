function barplotResponseColor(avgCorrectColor, ...
    nrCorrectResponsesColor, ...
    nrIncorrectResponsesColor, ...
    nrNoResponsesColor)

    bar([nrCorrectResponsesColor, nrIncorrectResponsesColor, nrNoResponsesColor], 'stacked');
    axis tight;
    axis square;

   
    ylabel('Trial number');
    title(sprintf(...
        'Bar plot of responses after a Color Painting\navg. correct: %.1f %%', ...
        round(avgCorrectColor, 1)));

    legend('correct', 'incorrect', 'no response', 'Location','bestoutside');

end
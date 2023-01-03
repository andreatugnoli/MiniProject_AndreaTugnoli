function barplotResponseBlack(avgCorrectBlack, ...
    nrCorrectResponsesBlack, ...
    nrIncorrectResponsesBlack, ...
    nrNoResponsesSBlack)

    bar([nrCorrectResponsesBlack, nrIncorrectResponsesBlack, nrNoResponsesSBlack], 'stacked');
    axis tight;
    axis square;

    
    ylabel('Trial number');
    title(sprintf(...
        'Bar plot of responses after a Black\navg. correct: %.1f %%', ...
        round(avgCorrectBlack, 1)));

    legend('correct', 'incorrect', 'no response', 'Location','bestoutside');
end
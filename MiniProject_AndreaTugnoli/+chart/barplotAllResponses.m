function barplotAllResponses(avgCorrectAll, ...
    nrCorrectResponses, nrIncorrectResponses, nrNoResponses)

bar([nrCorrectResponses, nrIncorrectResponses, nrNoResponses], 'stacked');
axis tight;
axis square;

xlabel('Subject number');
ylabel('Trial number');
title(sprintf('Bar plot of response\navg. correct: %.1f %%', round(avgCorrectAll, 1)));

legend('correct', 'incorrect', 'no response', 'Location','bestoutside');

end
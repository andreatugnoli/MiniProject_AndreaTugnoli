function plotResponseTimes(allResponseTimes)

    nrSubjects = size(allResponseTimes, 1);
    nrTrials = size(allResponseTimes, 2);
    meanResponseTime = nanmean(allResponseTimes);

    hold on
    plot(allResponseTimes.');
    plot(meanResponseTime, 'LineWidth', 3);

    axis([1 nrTrials 0 10]);

    xlabel('Number of Trials');
    ylabel('seconds');

    title(sprintf('Response Times with mean from %d Subjects', nrSubjects));
    hold off;

end
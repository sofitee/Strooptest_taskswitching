% analysis of model performance on switching blocks
% corresponds to Shallice & Gilbert 2002 p.311
% stimuli presented in pairs as per Woodward and colleagues (2002)
% measuring task-switching in Parkinson's subjects (N = 30)
% main empirical effect: Stroop interference and facilitation
% on congruent, incongruent and neutral trials

close all;
clear all;
initglobals_woodwardstudy
%initstimuli

BLOCKLENGTH = 70;
RUNS = 35;
SUBJECTS = 30; % 307;

switchingblock_wici = [];

% identical stimuli
for trial = 1:BLOCKLENGTH
    switchingblock_wici = [switchingblock_wici; 1 2 1 2   +mod(floor((trial-1)/RUNS), 2)];
end

% run simulations

STIM_THIS_BLOCK = switchingblock_wici;

for subject = 1:SUBJECTS
    fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
    run_stroopblock;
    allsubjects_RTS(subject,:) = output(:,3)';
    allsubjects_errors(subject,:) = output(:,2)';
end

fprintf('\n\n');

% Don't need these anymore
mean_RT = mean(allsubjects_RTS);
sd_RT = std(allsubjects_RTS);
sem_RT = std(allsubjects_RTS./sqrt(allsubjects_RTS));  % need to find standard error for all subject results - not just one

error_rate = allsubjects_errors;


% plot graph

figure(1);
plot(mean(allsubjects_RTS));
% Error bars are one standard error from the mean:
errorbar(mean(allsubjects_RTS), std(allsubjects_RTS)/sqrt(SUBJECTS)); 
%Probably good to label the horizontal axis with tiral type
% hold on
%set(gca, 'XTick', [5 10 15 20 25 30 35])
%set(gca,  'XTickLabel', switchingblock_wici(:,4)');
title ('Mean Reaction Times by Trial');

% Figure 2: The mean error rate across trials, with error bars for one
% standard error
figure(2);
plot(mean(error_rate));
% Error bars are one standard error from the mean:
errorbar(mean(error_rate), std(error_rate)/sqrt(SUBJECTS)); 
%Probably good to label the horizontal axis with tiral type
%hold on
%set(gca, 'XTick', [5 10 15 20 25 30 35])
%set(gca, 'XTickLabel', switchingblock_wici(:,4)');
title('Mean Errors by Trial');

% Switch costs - FIXME! These need to take account of the different trial types
fprintf('sd_RT');
fprintf ('\n switch cost: word->colour: %f cycles', ...
     (mean_RT(5) - sum(mean_RT(2:3)) / 2));
fprintf ('\n switch cost: colour->word: %f cycles', ...
     (mean_RT(9) - sum(mean_RT(3:4))/2));
fprintf ('\n');

% Figure 3: This appears to plot the standard error of the mean RT ...
% Not sure why we would want this, or why the graph has the given title
% figure(3);
% plot([1:1:BLOCKLENGTH], sem_RT);
% set(gca, 'XTick', [1 2 3 4 5])
% set(gca,  'XTickLabel', switchingblock_wici(:,4)');
% title ('All Subjects Error Rates');;




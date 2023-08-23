%   Adapt stimulus in G&S model
%   8 switching blocks of 70 trials
%   [35 colour naming 35 word reading]
%   Structured according to pg. 1951 (block of Wi Ci pairs, block of Wn, Cn pairs etc)
%   For each block, then need to collect mean RT in cycles for comparison with table 1 of Woodward et al
%   Also include total errors


close all;
clear all;
initglobals
% initstimuli 

BLOCKLENGTH = 8;
SUBJECTS = 30;

stimblock_pdsubjects_create = [];

%identical stimuli (?)
for trial = 1:BLOCKLENGTH
  stimblock_pdsubjects_create = [stimblock_pdsubjects_create; 1 2 2 1+mod(floor((trial-1)/RUNS), 2)]; 
end

% run simulations

STIM_THIS_BLOCK = stimblock_pdsubjects_create;

for subject = 1:SUBJECTS

  fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
  run_block;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

fprintf ('\n');

mean_RT = mean(allsubjects_RTs);
sd_RT = std(allsubjects_RTs);

error_rate = mean(allsubjects_errors);






   % plot graph

  figure (1);
  plot ([1:1:BLOCKLENGTH], mean_RT);
  errorbar([1:1:BLOCKLENGTH], mean_RT, sd_RT);
  % hold on;
  set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
  set (gca, 'XTickLabel', stimblock_pdsubjects_create(:,4)');
  title ('Mean Reaction Times');
  

  figure (2);
  plot ([1:1:BLOCKLENGTH], 1-error_rate);
  title ('Error Rate');
				% hold on;
  set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
  set (gca, 'XTickLabel', stimblock_pdsubjects_create(:,4)');  
  hold on;

  fprintf ('\n switch cost: word->colour: %f cycles', ...
	  (mean_RT(5) - sum(mean_RT(6:8)) / 3));
  fprintf ('\n switch cost: colour->word: %f cycles', ...
	  (mean_RT(9) - sum(mean_RT(10:12)) / 3));
  fprintf ('\n');



 


function stimuli = stimblock_pdsubjects_create (blocklength, blocktype, runs)

				% Creates block of Stroop stimuli for
				% G&S task switching model among PD subjects

                % USAGE:
				%   stimblock_create (length, type, runs)
				% returns a switching stroop stimuli
				% block of [length] trials, [type] may
				% be (1) fixedword (2) fixedcolour or
				% (3) mixed. 
                %   runs gives the length of
				% consecutive trials of same task. 
                % 
                % Note:
				% blocklength should be a multiple of
				% runs otherwise things might be messy.

				% ALSO - function will generate 1/3
				% cong, 1/3 incong and 1/3 neutral
				% trials FORMAT: [WORD COLOUR TYPE TASK]

				% STIMULI TYPE: neutral = 0, congruent =
				% 1, incongruent = 2 
                % 
                % TASK: word reading
				% = 1, colour naming = 2 COLOURS: R = 1,
				% G = 2, B = 3, Y = 4, P = 5, N(one) = 0

stim_type = randi ([0 2], blocklength, 1);
stimuli = [];

for trial = 1:blocklength

				% work out task based on current trial
				% blocktype  
  if (blocktype == 1)
    task = 1;
  elseif (blocktype == 2)
    task = 2;
  elseif (blocktype == 3)
    task = 1 + mod (idivide((trial-1), runs, 'floor'), 2);
  else fprintf (['blocktype not recognised, options are 1 (fixedword), ' ...
          '2 (fixedcolour) or 3 (mixed)\n']);
  end


  stim_word = randi ([1 5], 1, 1); % R = 1, G = 2, B = 3, Y = 4, P = 5 N(one) = 0

  if (stim_type(trial) == 0)    
    stim_colour = 0;
  elseif (stim_type(trial) == 1)
    stim_colour = stim_word;

  elseif (stim_type(trial) == 2)
    incongruent_colour = randi ([0 1], 1, 1); % remaining four colours

    % contingency if word = red
    if (stim_word == 1)
      if (incongruent_colour == 0)
	stim_colour = 2; % green
      else
	stim_colour = 3; % blue
      elseif
          stim_colour = 4; % yellow
      elseif
          stim_colour = 5; % purple
      end

      % contingency if word = green
    elseif (stim_word == 2)
      if (incongruent_colour == 0)
	stim_colour = 3; % blue
      else
	stim_colour = 1; % red
      elseif
          stim_colour = 4; % yellow
      elseif
          stim_colour = 5; % purple
      end

      % contingency if word = blue
    elseif (stim_word == 3)
      if (incongruent_colour == 0)
	stim_colour = 1; % red
      else
	stim_colour = 2; % green
      elseif
          stim_colour = 4; %yellow
      elseif
          stim_colour = 5; %purple
      end

        % contingency if word = yellow
    elseif (stim_word == 4)
      if (incongruent_colour == 0)
	stim_colour = 1; % red
      else
	stim_colour = 2; % green
      elseif
          stim_colour = 3; % blue
      elseif
          stim_colour = 4; % yellow
      elseif
          stim_colour = 5; % purple
      end

       % contingency if word = purple
    elseif (stim_word == 5)
      if (incongruent_colour == 0)
	stim_colour = 1; % red
      else
	stim_colour = 2; % green
      elseif
          stim_colour = 3; % blue
      elseif
          stim_colour = 4; % yellow
      end
      
    else fprintf ('\nuh oh\n');

    end

    else fprintf ('\nuh oh outer loop\n');
  end


  % to handle neutral trials for the colournaming task;
  % simply switch stim_colour and stim_word!
  if (task == 2)
    temp = stim_colour;
    stim_colour = stim_word;
    stim_word = temp;
  end

stimuli = [stimuli; ...
	   stim_word stim_colour stim_type(trial) task];

end

end
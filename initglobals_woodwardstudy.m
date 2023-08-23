%% Global parameters

ACTIVATION_MAX = 1.0
ACTIVATION_MIN = -1.0
RESPONSE_THRESHOLD = 0.15
STEP_SIZE = 0.0015
SQUASHING_PARAM = 0.0063 % task demand unit activation scaling between
                          % trials
NOISE = 0.006          % SD of gaussian noise
OUTPUTUNIT_BIAS = -4
TASKDEMAND_BIAS = -2
TOPDOWN_CONTROL_STRENGTH = [8 19]
LEARNING_RATE = 1.0

%% Initialises model and global variables for task switching model

units_wordout = [0 0 0 0 0];
units_colourout = [0 0 0 0 0];

units_wordin = [0 0 0 0 0];
units_colourin = [0 0 0 0 0];
units_taskdemand = [0 1]; % [word colour]


% module feed-forward weights
weights_wordin_wordout     = [2.5 0.0 0.0 0.0 0.0; 0.0 2.5 0.0 0.0 0.0;...
    0.0 0.0 2.5 0.0 0.0; 0.0 0.0 0.0 2.5 0.0; 0.0 0.0 0.0 0.0 2.5];
weights_colourin_colourout = [1.5 0.0 0.0 0.0 0.0; 0.0 1.5 0.0 0.0 0.0;...
    0.0 0.0 1.5 0.0 0.0; 0.0 0.0 0.0 1.5 0.0; 0.0 0.0 0.0 0.0 1.5];

% word/colour cross connections
weights_wordout_colourout = [+2 -2 -2 -2 -2; -2 +2 -2 -2 -2;...
    -2 -2 +2 -2 -2; -2 -2 -2 +2 -2; -2 -2 -2 -2 +2];
weights_colourout_wordout = [+2 -2 -2 -2 -2; -2 +2 -2 -2 -2;...
    -2 -2 +2 -2 -2; -2 -2 -2 +2 -2; -2 -2 -2 -2 +2];

% within-module lateral connections
weights_wordout_wordout     = [ 0 -2 -2 -2 -2; -2  0 -2 -2 -2;...
    -2 -2  0 -2 -2; -2 -2 -2 0 -2; -2 -2 -2 -2 0];
weights_colourout_colourout = [ 0 -2 -2 -2 -2; -2  0 -2 -2 -2;...
    -2 -2 0 -2 -2; -2 -2 -2 0 -2; -2 -2 -2 -2 0];

% ouput module -> task demand unit feed forward connections
weights_wordout_taskdemand   = [1 0; 1 0; 1 0; 1 0; 1 0];
weights_colourout_taskdemand = [0 1; 0 1; 0 1; 0 1; 0 1];

% task demand unit -> output module feed back connections
weights_taskdemand_wordout   = [+2.5 +2.5 +2.5 +2.5 +2.5; -2.5 -2.5 -2.5 ...
    -2.5 -2.5];
weights_taskdemand_colourout = [-2.5 -2.5 -2.5 -2.5 -2.5; +2.5 +2.5 +2.5...
    +2.5 +2.5];

% task demand units lateral connections
weights_taskdemand_taskdemand = [0 -2; -2 0];

% input module -> task demand units feed forward connections
% is there a base weight value or are these connections purely driven by
% hebbian learning?
weights_wordin_taskdemand  = [0 0; 0 0; 0 0; 0 0; 0 0]
weights_colourin_taskdemand = [0 0; 0 1; 0 0; 0 1; 0 0]



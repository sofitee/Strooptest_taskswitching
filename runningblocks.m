clear all;
close all;

initglobals_woodwardstudy;



units_wordin = [0 0 1 1 0]; % [R G B Y P]
units_colourin = [0 1 1 1 0]; % [R G B Y P]
 units_wordout  = [0 0 0 1 0]; % [R G B Y P]
  units_colourout = [0 0 1 0 0]; % [R G B Y P]
topdown_input = [0 1] % top down control is either 1 (on) or 0 (off)


run simulation_switchingblocks.m


figure (1);
plot ([units_wordout units_colourout]);
legend ('word out R', 'word out G', 'word out B', 'word out Y', ...
    'word out P', 'colour out R', ...
	'colour out G', 'colour out B', ' colour out Y', 'colour out P');
title ('Trials by Stimuli Type');
hold on;
 
figure (2);
plot (units_taskdemand);
legend ('word', 'colour');
title ('Activation of Task Demand Units');
hold on;
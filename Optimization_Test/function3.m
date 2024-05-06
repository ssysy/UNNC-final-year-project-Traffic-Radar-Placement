function [f3] = function3(B,L1,Lr)

% Preset parameters--------------------

%Road:(Meter)
d = 50; % width of the road
L = 11000; % length of the road
ref = d*L; %the road area as the reference

%Radar:(Meter)
%B = 14; %Horizontal Beam in Degree
r = -240.35*log(B)+1164.2; % radar range
B1 = (B/180)*pi; % Horizontal Beam. range: 0-120
C1 = (5/180)*pi; % radar placement angle
% L1 = 0; %uncovered length between two radars
% Lr = 0; %length between two radar pairs

%---------------------------------------------------


%Calculations---------------------------------------
%Variables:
L0_C1 = d/tan(C1+B1/2); %partial covered aera length
L0_C2 = (d/2)/tan(B1/2);
L0_C3 = d/tan(C1+B1/2);
r0_C1 = d/sin(C1+B1/2);
r0_C2 = (d/2)/sin(B1/2);
r0_C3 = d/sin(C1+B1/2);

% Objective functions-------------------

% L1 = -L0_C1; %select a vlaue for L1
L2_C1 = 2*r + L1; %MAX length between the two radars

f3 = L/(L2_C1+Lr); %calculate total number of radar for C1




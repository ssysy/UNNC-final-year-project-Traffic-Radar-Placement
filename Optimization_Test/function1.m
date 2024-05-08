function [f1] = function1(B,L1,Lr)

% Preset parameters--------------------

%Road:(Meter)
d = 50; % width of the road
L = 11000; % length of the road
ref = d*L; %the road area as the reference

%Radar:(Meter)
%B = 16; %Horizontal Beam in Degree
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

radar_area = (1/2)*r*r*sin(B1)*2;

f1 = (L2_C1-L1-L0_C1)*d; %calculate covered area of C1



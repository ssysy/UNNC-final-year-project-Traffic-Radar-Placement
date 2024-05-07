%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA120
% Project Title: Non-dominated Sorting Genetic Algorithm II (NSGA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, NSGA-II in MATLAB (URL: https://yarpiz.com/56/ypea120-nsga2), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function z = MOP2(x,d,L)

B = x;

% Preset parameters--------------------


%Road:(Meter)
% d = 50; % width of the road
% L = 11000; % length of the road
ref = d*L; %the road area as the reference

%Radar:(Meter)
%B = 16; %Horizontal Beam in Degree
r = -240.35*log(B)+1164.2; % radar range
B1 = (B/180)*pi; % Horizontal Beam. range: 0-120
C1 = (5/180)*pi; % radar placement angle
L1 = 100; %uncovered length between two radars
Lr = 100; %length between two radar pairs

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
L2_C2 = 2*r + L1; %MAX length between the two radars
radar_area = (1/2)*r*r*sin(B1)*2;

f1 = (L2_C2-L1-L0_C2)*d; %calculate covered area of C1


f2 = (L1 + L0_C2 + Lr)*d; %calculate blindspot area of C1


f3 = L/(L2_C2+Lr); %calculate total number of radar for C1

%calculate for the total areas
f1 = f1*f3;
f2 = f2*f3;

    z = [f1,  f2, f3]';


end
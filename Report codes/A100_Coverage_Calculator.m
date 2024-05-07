%This script will demostrate the minimum number of 
%radar pairs needed to achieve certain coverage

%assumption: r > d; L1 > -r

%Adjustable Parameters-----------------------------
%Road:(Meter)
d = 50; % width of the road
L = 11000; % length of the road
n = 12; %number of radar pairs (two radars per pair)

%Radar:(Meter)
B = 40; %Horizontal Beam in Degree
r = 600; % radar range  % -240.35*log(B)+1164.2
B1 = (B/180)*pi; % Horizontal Beam. range: 0-120
C1 = (10/180)*pi; % radar placement angle
L1 = 0; %uncovered length between two radars
Lr = 0; %length between two radar pairs
%---------------------------------------------------


%Calculations---------------------------------------
%Variables:
L0_C1 = d/tan(C1+B1/2); %partial covered aera length
L0_C2 = (d/2)/tan(B1/2);
L0_C3 = d/tan(C1+B1/2);
r0_C1 = d/sin(C1+B1/2);
r0_C2 = (d/2)/sin(B1/2);
r0_C3 = d/sin(C1+B1/2);
legend_labels = cell(3, 1); 
legend_labels{1} = 'C1';
legend_labels{2} = 'C2';
legend_labels{3} = 'C3';

%Draw Figures
% Initialize vectors to store data
n_values = 1:n;
coverage_values_1 = zeros(size(n_values));
coverage_values_2 = zeros(size(n_values));
coverage_values_3 = zeros(size(n_values));
j1=1; j2=1; j3 = 1;
    

for i = 1:length(n_values)
    n = n_values(i);

    %----------------------calcualtions for C1--------------------------------------------
        L1 = -L0_C1; %select a vlaue for L1
        L2_C1 = 2*r + L1; %MAX length between the two radars

        if (r >= r0_C1) && (B1 >= C1+B1/2) && (C1+B1/2 >= 0)%--------------caseC
            Acovered_C1 = (L2_C1-L1-L0_C1)*d * n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseC';
        elseif (r < r0_C1) && (B1 >= (C1+B1/2)) && ((C1+B1/2) >= 0)%-------caseD
            Acovered_C1 = r*sin(C1+B1/2)*r*cos(C1+B1/2) * n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseD';
        elseif C1+B1/2 <= 0 %----------------------------------------------caseE
            coverage_values_1(i) = 0;
            str1 = 'caseE';
        elseif (r >= r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) > d)%----caseA
            Auncovered = r0_C1*sin(C1-B1/2) * r0_C1*cos(C1-B1/2)*n + L1*d;
            Acovered_C1 = (L0_C1-L1)*d*n - Auncovered;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseA';
        elseif (r < r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) < d)%-----caseC
            Acovered_C1 = r*r*sin(B1)*n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseC';% special case of caseC
        elseif (r >= r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) <= d)%---caseB
            Auncovered = d*(d/tan(C1-B1/2));
            Acovered_C1 = n*((L1+2*(d/tan(C1-B1/2)))*d - Auncovered);
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseB';
        else
            coverage_values_1(i) = 0;
            legend_labels{1} = 'C1-error';
            break;
        end


%       if (L2_C1+Lr)*n >= L
%           coverage_values_1(i) = coverage_values_1(i-1);
%           if j1 == 1
%                lack_length_1 = L-((L2_C1+Lr)*(n-1)-Lr);
%                legend_labels{1} = sprintf('C1-%s  %.1fM left', str1, lack_length_1);
%                j1 = 0;
%           end
%       end

        if coverage_values_1(i) > 1
            coverage_values_1(i) = 1;
            legend_labels{1} = sprintf('C1-%s', str1);
        end



    %----------------------calcualtions for C2---------------------------------------------
        L1 = 0;
        L2_C2 = 2*r + L1; %MAX length between the two radars

        if (L1 >= 0) && (r0_C2 < r) %--------------------------------------caseA
            Acovered_C2 = (L2_C2-(L1+L0_C2))*d * n;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseA';
        elseif (L1 >= 0) && (r0_C2 >= r)%----------------------------------caseC
            Acovered_C2 = r*r*sin(B1)*n;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseC';
        elseif (L1 < 0) && (r0_C2 < r)%------------------------------------caseB
            Auncovered = 2*(L1/2)*((L1/2)*tan(B1/2))*n;
            Acovered_C2 = (L2_C2-(L1+L0_C2))*d*n - Auncovered;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseB';
        elseif (L1 < 0) && (r0_C2 >= r)%-----------------------------------caseD
            Overlap_C2 = (((L1/2)/cos(B1/2))^2)*sin(B1);
            Acovered_C2 = (r*r*sin(B1) - Overlap_C2)*n;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseD';
        else
            coverage_values_2(i) = 0;
            legend_labels{1} = 'C2-error';
            break;
        end


%         if (L2_C2+Lr)*n >= L 
%             coverage_values_2(i) = coverage_values_2(i-1);
%             if j2 == 1
%                 lack_length = L-((L2_C2+Lr)*(n-1)-Lr);
%                 legend_labels{2} = sprintf('C2-%s  %.1fM left', str2, lack_length); 
%                 j2 = 0;
%             end
%         end


        if coverage_values_2(i) >= 1
            coverage_values_2(i) = 1;
            legend_labels{2} = sprintf('C2-%s', str2);
        end

    %----------------------calcualtions for C3---------------------------------------------
    L1 = -L0_C3; %select a vlaue for L1
    L2_C3 = 2*r + L1; %MAX length between the two radars
    
    if L1 >= 0
        coverage_values_3(i) = coverage_values_1(i);
    elseif L1 < 0

        if strcmp(str1, 'caseC')||strcmp(str1, 'caseD')%---------------caseA
            Overlap_C3 = (-L1/2)*tan(C1+B1/2)*(-L1);
        elseif strcmp(str1, 'caseE')%----------------------------------caseC
            Overlap_C3 = 0;
        elseif strcmp(str1, 'caseA')||strcmp(str1, 'caseC')||strcmp(str1, 'caseB')%----caseD
            angle1 = pi - C1 + B1/2;
            angle2 = pi - C1 - B1/2;
            h = (-L1/2)*tan(C1+B1/2);
            h1 = (-L1/2)*tan(C1-B1/2);
            h2 = (-L1*sin(C1+B1/2)*sin(C1-B1/2))/sin(2*C1);
            Roverlap = 2*(h*h*sin(angle1)*sin(angle2))/(2*sin(angle1+angle2));

            if h+h1 <= d
                Overlap_C3 = Roverlap;
            elseif h+h1 > d && h2 <= d
                l0= d/tan(C1+B1/2);
                Aover = (-L1-2*l0)*(h+h1-d);
                Overlap_C3 = Roverlap - Aover;
            elseif h+h1 > d && h2 > d && h1 <= d
                l0= d/tan(C1+B1/2);
                Aover = (-L1-2*l0)*(h+h1-d);
                Aover1 = (-L1*((d-h1)^2)/(2*h1));
                Overlap_C3 = Roverlap - Aover - Aover1;
            elseif h+h1 > d && h2 > d && h1 > d
                Overlap_C3 = 0;
            else
                coverage_values_3(i) = 0;
                legend_labels{3} = 'C3-error';
                break;
            end
            
        end

        Acovered_C3 = Acovered_C1 - Overlap_C3*n;
        coverage_values_3(i) = Acovered_C3 / (d*L);
    end


%     if (L2_C3+Lr)*n >= L 
%         coverage_values_3(i) = coverage_values_3(i-1);
%         if j3 == 1
%             lack_length_3 = L-((L2_C3+Lr)*(n-1)-Lr);
%             legend_labels{3} = sprintf('C3-%s  %.1fM left', str1, lack_length_3); 
%             j3 = 0;
%         end
%     end

    if coverage_values_3(i) > 1
        coverage_values_3(i) = 1;
        legend_labels{3} = sprintf('C3-%s', str1);
    end

end

% Plot the bar graph for both configurations
bar(n_values, [coverage_values_1; coverage_values_2; coverage_values_3], 0.6);
ylim([0 1]);

% Set the legend with all the labels
legend(legend_labels, 'Location', 'northwest');

% Set axis labels and title
xlabel('Number of Radar Pairs (n)')
ylabel('Coverage (%)')
title('Comparison of Three Configurations')

hold off;


%This script will demostrate the minimum number of 
%radar pairs needed to achieve certain coverage

%assumption: 1.the Road is straight; 2.r > d; 3.L1 > -r; 

%Adjustable Parameters-----------------------------
%Road:(Meter)
d = 3.5*8+2; % width of the road: 3.5m per lane; 8 lanes; 2m gap
L = 11000; % length of the road
n = 12; %number of radar pairs (two radars per pair)

ref = d*L; %the road area as the reference

%Parameters ---------------------------------------
%Radar:(Meter)
B = 20; %Horizontal Beam in Degree
r = -240.35*log(B)+1164.2; % radar range
B1 = (B/180)*pi; % Horizontal Beam. range: 0-120
C1 = (5/180)*pi; % radar placement angle
L1 = 100; %uncovered length between two radars
Lr = 0; %length between two radar pairs

%Radar in Meter (Given)
r1 = 100; % radar range1
r2 = 350; % radar range2
r3 = 600; % radar range3
A1 = (90/180)*pi; % Horizontal Beamwidth1
A2 = (24/180)*pi; % Horizontal Beamwidth2
A3 = (12/180)*pi; % Horizontal Beamwidth3
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
legend_labels{1} = 'Config 1';
legend_labels{2} = 'Config 2';
legend_labels{3} = 'Config 3';
legend_labels{4} = 'Two Radar One';

%Draw Figures
% Initialize vectors to store data
n_values = 1:n;
coverage_values_1 = zeros(size(n_values));
coverage_values_2 = zeros(size(n_values));
coverage_values_3 = zeros(size(n_values));
coverage_values_4 = zeros(size(n_values));

wastage = zeros(size(n_values));
wastage1 = zeros(size(n_values));
wastage2 = zeros(size(n_values));
wastage3 = zeros(size(n_values));

blindspot = zeros(size(n_values));
blindspot1 = zeros(size(n_values));
blindspot2 = zeros(size(n_values));
blindspot3 = zeros(size(n_values));

area_total_r1 = (1/2)*(r1*r1*sin(A1)+r2*r2*sin(A2)+r3*r3*sin(A3));
area_total_C = (1/2)*(r*r*sin(B1));

j1=1; j2=1; j3 = 1;
    

for i = 1:length(n_values)
    n = n_values(i);

    %----------------------calcualtions for C1--------------------------------------------
        %L1 = 0; %select a vlaue for L1
        L2_C1 = 2*r + L1; %MAX length between the two radars

        blindspot1(i) = n*(L1+L0_C1 + Lr)*d;

        if (r >= r0_C1) && (B1 >= C1+B1/2) && (C1+B1/2 >= 0)%--------------caseA
            Acovered_C1 = (L2_C1-L1-L0_C1)*d * n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseC';
            
        elseif (r < r0_C1) && (B1 >= (C1+B1/2)) && ((C1+B1/2) >= 0)%-------caseB
            Acovered_C1 = r*sin(C1+B1/2)*r*cos(C1+B1/2) * n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseD';

        elseif C1+B1/2 <= 0 %----------------------------------------------caseC
            coverage_values_1(i) = 0; 
            str1 = 'caseE';%C
        elseif (r >= r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) < d)%----caseD
            Auncovered = r*sin(C1-B1/2)*r*cos(C1-B1/2)*n;
            Acovered_C1 = (L2_C1-L1-L0_C1)*d*n - Auncovered;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseA';%D
        elseif (r < r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) < d)%-----caseE
            Acovered_C1 = r*r*sin(B1)*n;
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseC';%E
        elseif (r >= r0_C1) && (C1+B1/2 >= B1) && (r*sin(C1-B1/2) >= d)%---caseF
            Auncovered = d*(d/tan(C1-B1/2));
            Acovered_C1 = n*((L1+2*(d/tan(C1-B1/2)))*d - Auncovered);
            coverage_values_1(i) = Acovered_C1 / (L*d);
            str1 = 'caseB';%F
        else
            coverage_values_1(i) = 0;
            legend_labels{1} = 'C1-error';
            break;
        end


        if (L2_C1+Lr)*n >= L 
            coverage_values_1(i) = coverage_values_1(i-1);
            if j1 == 1
                lack_length_1 = L-((L2_C1+Lr)*(n-1)-Lr);
                legend_labels{1} = sprintf('C1-%s  %.1fM left', str1, lack_length_1); 
                j1 = 0;
            end
        end

        if coverage_values_1(i) > 1
            coverage_values_1(i) = 1;
        end

        wastage1(i) = (1/2)*r*r*sin(B1)*n*2 - Acovered_C1;%calculate wastaged area of C1


    %----------------------calcualtions for C2---------------------------------------------
        %L1 = 0;
        L2_C2 = 2*r + L1; %MAX length between the two radars

        blindspot2(i) = n*(L1+L0_C2 + Lr)*d;

        if (L1 >= 0) && (r0_C2 < r) %--------------------------------------caseA
            Acovered_C2 = (L2_C2-(L1+L0_C2))*d * n;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseA';
        elseif (L1 >= 0) && (r0_C2 >= r)%----------------------------------caseB
            Acovered_C2 = r*r*sin(B1)*n;
            coverage_values_2(i) = Acovered_C2 / (L*d);
            str2 = 'caseC';
        elseif (L1 < 0) && (r0_C2 < r)%------------------------------------caseC
            Auncovered = (r0_C2-(L1/2)/cos(B1/2))*(d/2-(L1/2)*tan(B1/2))*n;
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


        if (L2_C2+Lr)*n >= L 
            coverage_values_2(i) = coverage_values_2(i-1);
            if j2 == 1
                lack_length = L-((L2_C2+Lr)*(n-1)-Lr);
                legend_labels{2} = sprintf('C2-%s  %.1fM left', str2, lack_length); 
                j2 = 0;
            end
        end

        if coverage_values_2(i) > 1
            coverage_values_2(i) = 1;
        end

        wastage2(i) = (1/2)*r*r*sin(B1)*n*2 - Acovered_C2; %calculate wastaged area of C2


    %----------------------calcualtions for C3---------------------------------------------
    %L1 = 0; %select a vlaue for L1
    L2_C3 = 2*r + L1; %MAX length between the two radars

    blindspot3(i) = n*(L1+L0_C3 + Lr)*d;
    
    if L1 >= 0
        coverage_values_3(i) = coverage_values_1(i);
        Overlap_C3 = 0;

    elseif L1 < 0

        if strcmp(str1, 'caseC')||strcmp(str1, 'caseD')%---------------caseA
            Overlap_C3 = (-L1/2)*tan(C1+B1/2)*(-L1);
        elseif strcmp(str1, 'caseE')%----------------------------------caseC
            Overlap_C3 = 0;
        elseif strcmp(str1, 'caseA')||strcmp(str1, 'caseB')%----caseD
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
        
    end


    Acovered_C3 = Acovered_C1 - Overlap_C3*n;
    coverage_values_3(i) = Acovered_C3 / (d*L);

    wastage3(i) = (1/2)*r*r*sin(B1)*n*2 - Acovered_C3;%calculate wastaged area of C3


    %----------------------calcualtions for Real Radar---------------------------------------------


    L0 = (d/2)/tan(A1/2); % length from R1 to the edge of fully covered area
    area_covered = r3*d*n * 2 - (L0*d/2 + L1*d)*n * 2; %two radar covered area
    coverage_values_4(i) = area_covered / (L*d);

    wastage(i) = 2*(n*area_total_r1 - area_covered);
    blindspot(i) = 2 * n*( L0*d/2 + Lr*d );

    if Lr < 0 && -Lr <= L0
        blindspot(i) = n*(L0+Lr)^2;
    elseif -Lr >= L0
        blindspot(i) = 0;
    end


    if (L2_C3+Lr)*n >= L 
        coverage_values_3(i) = coverage_values_3(i-1);
        if j3 == 1
            lack_length_3 = L-((L2_C3+Lr)*(n-1)-Lr);
            legend_labels{3} = sprintf('C3-%s  %.1fM left', str1, lack_length_3); 
            j3 = 0;
        end
    end

    if coverage_values_1(i) > 1
        coverage_values_1(i) = 1;
    end
    if coverage_values_2(i) > 1
        coverage_values_2(i) = 1;
    end
    if coverage_values_3(i) > 1
        coverage_values_3(i) = 1;
    end
    if coverage_values_4(i) > 1
        coverage_values_4(i) = 1;
    end
    

end

% Figure 1
% Plot the bar graph for both configurations
figure('Name', 'Three Configurations and Radar One Performance Comparison', 'Position', [180, 180, 1000, 600]);
bar(n_values, [coverage_values_1; coverage_values_2; coverage_values_3; coverage_values_4], 0.6);
ylim([0 1]);

% Set the legend with all the labels
legend(legend_labels, 'Location', 'northwest', 'FontSize', 14);

% Set axis labels and title
xlabel('Number of Radar Pairs (n)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Coverage (%)', 'FontSize', 14, 'FontWeight', 'bold');
title('Coverage Comparison of Three Configurations and Radar One', 'FontSize', 16, 'FontWeight', 'bold');

% Figure 2 and 3
figure('Name', 'Wastage and Blindspot Area Comparison', 'Position', [180, 180, 1000, 500]);

% Subplot 1: Wastage Area Comparison
subplot(1, 2, 1);
plot(n_values, wastage, '-*m', 'LineWidth', 1.5);
hold on;
plot(n_values, wastage1, '-^r', 'LineWidth', 1.5);
plot(n_values, wastage2, '-*b', 'LineWidth', 1.5);
plot(n_values, wastage3, '-*g', 'LineWidth', 1.5);
hold off;

xlabel('Number of Radar Pairs (n)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Area in Square Meter', 'FontSize', 14, 'FontWeight', 'bold');
legend('Wastage area of Radar One', 'Wastage area of Configuration 1', 'Wastage area of Configuration 2', ...
    'Wastage area of Configuration 3', 'Location', 'northwest', 'FontSize', 12);
title('Wastage Comparison', 'FontSize', 16, 'FontWeight', 'bold');

% Subplot 2: Blindspot Area Comparison
subplot(1, 2, 2);
plot(n_values, blindspot, '-*m', 'LineWidth', 1.5);
hold on;
plot(n_values, blindspot1, '-*r', 'LineWidth', 1.5);
plot(n_values, blindspot2, '-*b', 'LineWidth', 1.5);
plot(n_values, blindspot3, '-^g', 'LineWidth', 1.5);
hold off;

xlabel('Number of Radar Pairs (n)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Area in Square Meter', 'FontSize', 14, 'FontWeight', 'bold');
legend('Blindspot Area of Radar One', 'Blindspot Area of Configuration 1', 'Blindspot Area of Configuration 2', ...
    'Blindspot Area of Configuration 3', 'Location', 'northwest', 'FontSize', 12);
title('Blindspot Comparison', 'FontSize', 16, 'FontWeight', 'bold');

% Adjust subplots layout
% sgtitle('Radar1 Performance Comparison', 'FontSize', 16);

%This script will demostrate the coverage rate for R1 
%in any given road section  

% Assumptions: the Road is straight; r > d; L1 > -r; 

%Parameters----------------------------------------
%Road in Meter (Adjustable)
d = 3.5*8+2; % width of the road: 3.5m per lane; 8 lanes; 2m gap
L = 11000; % length of the road
n = 20; %number of radar
Lr = 0; %length between two radar detection range

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
width1 = 2*(sin(A2/2)*r1); % Max road width that R1 can cover at distance r1
width2 = 2*(sin(A3/2)*r2); % Max road width that R1 can cover at distance r2

w1 = r1*sin(A1/2)*2; % Max r1 detection width
w2 = r2*sin(A2/2)*2; % Max r2 detection width
w3 = r3*sin(A3/2)*2; % Max r3 detection width

L0 = (d/2)/tan(A1/2); % length from R1 to the edge of fully covered area

%Draw Figures---------------------------------------
% Initialize vectors to store data
n_values = 1:n;
coverage_values = zeros(size(n_values));
blind_spots = zeros(size(n_values));
wastage = zeros(size(n_values));
overlap2 = zeros(size(n_values));%overlapped area by two radars(r2 and r3)
overlap3 = zeros(size(n_values));%overlapped area by three radars(r1, r2 and r3) 
legend_labels = cell(1, length(n_values));

j = 1;
area_total = (1/2)*(r1*r1*sin(A1)+r2*r2*sin(A2)+r3*r3*sin(A3));

for i = 1:length(n_values)
    n = n_values(i);

    %----------------------calcualtions---------------------------------------------

    area_covered = r3*d*n - L0*d/2;

    overlap3(i) = n*(1/2)*r1*r1*sin(A3);
    overlap1(i) = n*((1/2)*r1*r1*sin(A2)+(1/2)*r2*r2*sin(A3));
    overlap2(i) = overlap1(i) - overlap3(i);

    blind_spots(i) = n*(L0*d/2+Lr*d);
    wastage(i) = n*area_total - area_covered;

    coverage_values(i) = area_covered / (L*d);
        
    legend_labels{1} = sprintf('Road Width=%.1fM', d);

    if (r3+Lr)*n >= L 
        coverage_values(i) = coverage_values(i-1);
        if j == 1
            over_length = (r3+Lr)*n-L;
            legend_labels{1} = sprintf('Road Width=%.1fM  %.1fM beyond the road', d, over_length); 
            j = 0;
        end
    end

    if coverage_values(i) > 1
        coverage_values(i) = 1;
    end

    if Lr < 0
        blind_spots(i) = n*(L0+Lr)^2;
    end


end


% Plot graphs
legend_labels{2} = 'wasted monitoring area';
legend_labels{3} = 'overlap by r2 and r3';
legend_labels{4} = 'overlap by r1, r2 and r3';
legend_labels{5} = 'total overlap';
legend_labels{6} = 'sum of each radar blindspot';


%figure 1 ------------------------------------------------------------------
figure('Name', 'RadarOne Performance Analysis', 'Position', [110, 110, 1200, 800]);

% Plot Coverage Rate
subplot(2, 2, 1);
plot(n_values, coverage_values, '-*b', 'LineWidth', 1.5);
ylim([0 1]);
xlabel('Number of Radars (n)');
ylabel('Coverage (%)');
title('Coverage Rate for Radar One');
legend(legend_labels{1}, 'Location', 'northwest');

% Plot Wastage
subplot(2, 2, 2);
plot(n_values, wastage, '-*b', 'LineWidth', 1.5);
xlabel('Number of Radars (n)');
ylabel('Wastage (square meters)');
title('Wasted Monitoring Area');
legend(legend_labels{2}, 'Location', 'northwest');

% Plot Overlaps
subplot(2, 2, 3);
plot(n_values, overlap1, '-*b', 'LineWidth', 1.5);
hold on;
plot(n_values, overlap2, '-*g', 'LineWidth', 1.5);
hold on;
plot(n_values, overlap3, '-*r', 'LineWidth', 1.5);
hold off;
xlabel('Number of Radar (n)');
ylabel('Overlap (square meters)');
title('Overlaps');
legend(legend_labels{5}, legend_labels{3}, legend_labels{4}, 'Location', 'northwest');

% Plot Blind Points
subplot(2, 2, 4);
plot(n_values, blind_spots, '-*b', 'LineWidth', 1.5);
xlabel('Number of Radars (n)');
ylabel('Blind Spots (square meters)');
title('Blind Spots within Detection Range');
legend(legend_labels{6}, 'Location', 'northwest');

% Adjust subplots layout
sgtitle('Radar One Performance Analysis', 'FontSize', 16);

%figure 2 ------------------------------------------------------------------
figure('Name', 'RadarOne Performance Comperation', 'Position', [180, 180, 1000, 600]);

% Plot Comparation
plot(n_values, wastage, '-*m', 'LineWidth', 1.5);
hold on;
plot(n_values, overlap1, '-^b', 'LineWidth', 1.5);
hold on;
plot(n_values, overlap2, '-og', 'LineWidth', 1.5);
hold on;
plot(n_values, overlap3, '-+b', 'LineWidth', 1.5);
hold on;
plot(n_values, blind_spots, '-*r', 'LineWidth', 1.5);
hold off;
xlabel('Number of Radar (n)');
ylabel('Areas in Square Meter');
legend(legend_labels{2}, legend_labels{5}, legend_labels{3}, legend_labels{4}, legend_labels{6}, 'Location', 'northwest','FontSize',14);

% Adjust subplots layout
sgtitle('Radar One Performance Comparation', 'FontSize', 16);


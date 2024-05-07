%main testing code for objective functions
% Beamwidth from 10 to 100 degree

values = 10:1:100;

f1value = zeros(size(values));
f2value = zeros(size(values));
f3value = zeros(size(values));

B = 10;
Lr = 0;
L1 = 0;

for i = 1:length(values)
    [f1] = function1(B,L1,Lr);%covered area
    [f2] = function2(B,L1,Lr);%blind area
    [f3] = function3(B,L1,Lr);%number of radar pair
    B = B+1;
    % Lr = Lr+10;
    % L1 = L1+10;
    L1 = values(i);
    f1value(i) = f1;
    f2value(i) = f2;
    f3value(i) = f3;
end


% Plotting
yyaxis left
plot(values, f1value, '-*m', 'LineWidth', 1.5);
hold on;
plot(values, f2value, '-^r', 'LineWidth', 1.5);
ylabel('Areas (square meter)');

yyaxis right
plot(values, f3value, '-*b', 'LineWidth', 1.5);
ylabel('Number of Radar Pair');

xlabel('Beamwidth in Degree');
legend('Covered Area', 'Blind Area', 'Number of Radar Pair', 'Location', 'best');
title('Testing Objective Functions');
hold off;

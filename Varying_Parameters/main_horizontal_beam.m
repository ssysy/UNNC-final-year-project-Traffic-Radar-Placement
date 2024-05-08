
%Road:(Meter)
d = 50; % width of the road
L = 11000; % length of the road
n = 12; %number of radar pairs (two radars per pair)

%Radar:(Meter)
r = 500; % radar range
B1 = (30/180)*pi; % Horizontal Beam
C1 = (10/180)*pi; % radar placement angle
L1 = 0; %distances between two radars within one radar pair
Lr = 10; %length between two radar pairs

B = 10:10:70;
% x_range = 1:length(B);
x_range = 1:n;
%Varying 
angle_coverages_1 = [];
angle_coverages_2 = [];
angle_coverages_3 = [];

for i = 1 : length(B)
    %Road:(Meter)
    d = 50; % width of the road
    L = 11000; % length of the road
    n = 12; %number of radar pairs (two radars per pair)

    %Radar:(Meter)
    r = 500; % radar range
    B1 = (B(i)/180)*pi; % Horizontal Beam
    C1 = (10/180)*pi; % radar placement angle
    L1 = 0; %uncovered length between two radars
    Lr = 0; %length between two radar pairs

    [coverage_values_1, coverage_values_2,coverage_values_3] = draw_line_graph(d, L, n, r, B1, C1, L1, Lr);

    angle_coverages_1 = [angle_coverages_1; coverage_values_1];
    angle_coverages_2 = [angle_coverages_2; coverage_values_2];
    angle_coverages_3 = [angle_coverages_3; coverage_values_3];

end

figure(1)
set(gca,'FontSize',12,'FontWeight','bold');

subplot(1, 3, 1)
for i=1: length(B)
    plot(x_range, angle_coverages_1(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("B1= %d", B);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold'); %
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 1", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);
    

subplot(1, 3, 2)
for i=1: length(B)
    plot(x_range, angle_coverages_2(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("B1= %d", B);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 2", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);

subplot(1, 3, 3)
for i=1: length(B)
    plot(x_range, angle_coverages_3(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("B1= %d", B);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 3", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);

hold off;


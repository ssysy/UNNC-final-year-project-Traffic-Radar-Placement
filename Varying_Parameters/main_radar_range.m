
%Road:(Meter)
d = 50; % width of the road
L = 11000; % length of the road
n = 12; %number of radar pairs (two radars per pair)

%Radar:(Meter)
r = 600; % radar range
B1 = (30/180)*pi; % Horizontal Beam
C1 = (10/180)*pi; % radar placement angle
L1 = 0; %uncovered length between two radars
Lr = 0; %length between two radar pairs

R = 100:100:700;
x_range = 1:n;
%Varyings
angle_coverages_1 = [];
angle_coverages_2 = [];
angle_coverages_3 = [];

for i = 1 : length(R)
    %Road:(Meter)
    d = 50; % width of the road
    L = 11000; % length of the road
    n = 12; %number of radar pairs (two radars per pair)

    %Radar:(Meter)
    r = R(i); % radar range
    B1 = (30/180)*pi; % Horizontal Beam
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
for i=1: length(R)
    plot(x_range, angle_coverages_1(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("r= %d", R);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold'); %
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 1", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);
    

subplot(1, 3, 2)
for i=1: length(R)
    plot(x_range, angle_coverages_2(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("r= %d", R);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 2", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);

subplot(1, 3, 3)
for i=1: length(R)
    plot(x_range, angle_coverages_3(i,:),"LineWidth",1.5);
    hold on
end
labels = compose("r= %d", R);
legend(labels, 'Location', 'best', 'FontWeight', 'bold');
xlabel('Number of radar pairs', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Coverage(%)', 'FontSize', 12, 'FontWeight', 'bold');
title("Configuration 3", 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 1]);

hold off;


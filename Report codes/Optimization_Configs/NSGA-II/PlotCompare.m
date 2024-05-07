

function PlotCompare(config1_value,config2_value,config3_value)

    
    figure('Name', 'Comperation of Configurations', 'Position', [180, 180, 1000, 600]);
    plot3(config1_value(1, :), config1_value(2, :),config1_value(3, :), 'r*', 'MarkerSize', 8);
    hold on 
    plot3(config2_value(1, :), config2_value(2, :),config2_value(3, :), 'g^', 'MarkerSize', 8);
    hold on
    plot3(config3_value(1, :), config3_value(2, :),config3_value(3, :), 'b+', 'MarkerSize', 8);
    xlabel('Covered Area (%)');
    ylabel('Blind Area (%)');
    zlabel('Number of Radars');
    title('Optimization Solution for Three Configurations');
    grid on

    
    legend('Configuration 1', 'Configuration 2', 'Configuration 3', 'Location', 'best');



end
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

function cost_storage = PlotCosts(pop,d,L,i,fig_value)

    Costs = [pop.Cost];
    ref = d*L;
    Costs(1, :) = (Costs(1, :)/ref)*100;
    Costs(2, :) = (Costs(2, :)/ref)*100;


    if i == 1
        if fig_value == 1
            figure('Name', 'Comperation of Configurations', 'Position', [180, 180, 1000, 600]);
        end
        plot3(Costs(1, :), Costs(2, :),Costs(3, :), 'r*', 'MarkerSize', 8);
        xlabel('Covered Area (%)');
        ylabel('Blind Area (%)');
        zlabel('Number of Radars');
        title('Optimization Solution for Configuration1');
        grid on

            cost_storage = vertcat(Costs, [pop.Position]);

    elseif i == 2
        if fig_value == 1
            figure('Name', 'Comperation of Configurations', 'Position', [180, 180, 1000, 600]);
        end
        plot3(Costs(1, :), Costs(2, :),Costs(3, :), 'g^', 'MarkerSize', 8);
        xlabel('Covered Area (%)');
        ylabel('Blind Area (%)');
        zlabel('Number of Radars');
        title('Optimization Solution for Configuration2');
        grid on

            cost_storage = vertcat(Costs, [pop.Position]);

    elseif i == 3
        if fig_value == 1
            figure('Name', 'Comperation of Configurations', 'Position', [180, 180, 1000, 600]);
        end

        plot3(Costs(1, :), Costs(2, :),Costs(3, :), 'b+', 'MarkerSize', 8);
        xlabel('Covered Area (%)');
        ylabel('Blind Area (%)');
        zlabel('Number of Radars');
        title('Optimization Solution for Configuration3');
        grid on

            cost_storage = vertcat(Costs, [pop.Position]);

    end


end
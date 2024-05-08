

function CompareResults(config1_value,config2_value,config3_value)

    c1 = config1_value(1:3, :);
    c2 = config2_value(1:3, :);
    c3 = config3_value(1:3, :);


    for k = 1:3 
    
        if k == 1
            AB = c2s_metric(c1, c2);
            BA = c2s_metric(c2, c1);
            if AB >= BA
                disp('c1 better than c2');
            else
                disp('c2 better than c1');
            end
        end
    
        if k == 2
            AB = c2s_metric(c1, c3);
            BA = c2s_metric(c3, c1);
            if AB >= BA
                disp('c1 better than c3');
            else
                disp('c3 better than c1');
            end
        end
    
        if k == 3
            AB = c2s_metric(c2, c3);
            BA = c2s_metric(c3, c2);
            if AB >= BA
                disp('c2 better than c3');
            else
                disp('c3 better than c2');
            end
        end
    
        
        disp(['AB = ', num2str(AB)]);
        disp(['BA = ', num2str(BA)]);
        
    
    end


    function c2s_metric =c2s_metric(front1,front2)

        covered_count =0;

        for i = 1:size(front1,2)
            for j = 1:size(front1,2)
                if front1(1,j)>front2(1,i) && front1(2,j)<front2(2,i) && front1(3,j)<front2(3,i)
                    covered_count =covered_count + 1;
                    break;
                end
            end
        end

        c2s_metric =covered_count / size(front2,2);
    end


end
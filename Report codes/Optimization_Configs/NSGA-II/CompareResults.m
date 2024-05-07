

function cost_storage = CompareResults(config1_value,config2_value,config3_value)


    A = config1_value(1:3, :);
    B = config2_value(1:3, :);
    C = config3_value(1:3, :);

    AB = c2s_metric(A, B);
    BA = c2s_metric(B, A);


    disp(AB);disp(BA);

    function c2s_metric =c2s_metric(front1,front2)
        covered count =0;
        for i = 1:size(front1)
            for j = 1:size(front2)
                if front1(i,1) < front1(j,1) && front1(i,2) < front1(j,2)
                    covered_count =covered_count + 1;
                    break;
                end
            end
        end

        c2s_metric =covered_count / size(front2,1);
    end



end
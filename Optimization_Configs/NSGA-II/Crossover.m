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

function [y1, y2] = Crossover(x1, x2)

    alpha = rand(size(x1));
    
    y1 = alpha.*x1+(1-alpha).*x2;%new x1
    y2 = alpha.*x2+(1-alpha).*x1;%new x2

    if(y1>100)
        y1=99;
    end
    if(y1<10)
        y1=11;
    end

    if(y2>100)
        y2=99;
    end
    if(y2<10)
        y2=11;
    end

        
     
    
end
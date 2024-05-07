% Quadratic fitting method function


points = [90, 100; 24, 350; 12, 600];

% function
A = [points(:,1).^2, points(:,1), ones(size(points,1),1)];
b = points(:,2);

% solve for coefficients
coefficients = A\b;


a = coefficients(1);
b = coefficients(2);
c = coefficients(3);

% print the result
fprintf('function：f(x) = %.6f*x^2 + %.6f*x + %.6f\n', a, b, c);

% plot
x_values = linspace(0, 120, 100); % 
y_values = a*x_values.^2 + b*x_values + c; 

figure;
plot(points(:,1), points(:,2), 'ro', 'MarkerSize', 10); 
hold on;
plot(x_values, y_values, 'b-','LineWidth', 2); 
xlabel('Radar Beanwidth(degree)');
ylabel('Radar Range(M)');
title('Fitted Quadratic Function');
legend('original data', 'fitting cruve', 'Location', 'best');
grid on;

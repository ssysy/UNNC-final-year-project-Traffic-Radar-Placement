% Logarithmic fitting method function

x_data = [90, 24, 12];
y_data = [100, 350, 600];


logarithmic_function = @(a, b, x) a * log(x) + b;

% fitting
fitted_model = fit(x_data', y_data', logarithmic_function, 'StartPoint', [1, 1]);


a_fit = fitted_model.a;
b_fit = fitted_model.b;

%print
disp('the funciton:');
disp(['y = ', num2str(a_fit), ' * ln(x) + ', num2str(b_fit)]);


%plot
x_fit = linspace(0, 120, 100);
y_fit = a_fit * log(x_fit) + b_fit;

figure;
plot(x_data, y_data, 'ro', 'MarkerSize', 10); % 
hold on;
plot(x_fit, y_fit, 'b-', 'LineWidth', 2); %
xlabel('x');
ylabel('y');
title('Fitted Logarithmic Function');
legend('original data', 'fitting cruve', 'Location', 'best');
grid on;

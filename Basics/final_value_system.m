clc;
clear;

function y_n = converge(alpha, N)
    % Demonstrates convergence of the system to sqrt(alpha)
    % alpha: positive constant (amplitude of step input)
    % N: number of samples to compute
    
    % Initialize variables
    x = alpha * ones(1, N); % Step input x[n] = alpha*u[n]
    y = zeros(1, N);        % Output array
    y_prev = 1;             % y[-1] = 1 (initial condition)
    
    % Compute the system output
    for n = 1:N
        y(n) = 0.5 * (y_prev + x(n)/y_prev);
        y_prev = y(n); % Update for next iteration
    end
    
    % Theoretical limit
    sqrt_alpha = sqrt(alpha);
    
    % Plot results
    figure;
    stem(0:N-1, y);
    hold on;
    plot([0 N-1], [sqrt_alpha sqrt_alpha])
    hold off;
    
    title(['Convergence to \surd\alpha (\alpha = ', num2str(alpha), ')']);
    xlabel('Time index n');
    ylabel('Output y[n]');
    legend('System output', 'Theoretical limit \surd\alpha');
    grid on;
    
    % Return the output sequence
    y_n = y;
end

alpha=56;
N=20;
y = converge(alpha,N);

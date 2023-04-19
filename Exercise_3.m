% Exercise 3 - Gurleen Rahi - 400377038 - rahig
clear all; close all %#ok<CLALL> reset everything

% phase velocity
c = 299792458;        % speed of light
eps_r = 3.5;      % relative permittivity based on last digit of student #
vp = c / sqrt(eps_r); % phase velocity

% Sinusoid parameters
f = 1.5*10^8;       % based on last digit of student number
A = 5;              % Amplitude
Omega = f*pi*2;     % Angular frequency
Lamda = vp/f;       % Lambda formula
T = (2*pi)/Omega;   % Time Period formula

% spatial and temporal axes
dz = (3 * Lamda); z = linspace(-dz, +dz, 1001);    % range of z
dt = (3 * T); t = linspace(-dt, +dt*2, 4501);      % range of t

% function for the waves
s = @(tau) (1+erf(Omega*tau))/2;
sinusoid = @(tau) A*cos(Omega*tau);                % sinusoid formula
wave = @(z, ti) sinusoid(ti - z / vp).* s(ti-z/vp);
% function for the superposition
superPosition = @(z, ti) wave(+z, ti) + wave(-z,ti);

% plots specification
subplot(3, 1, 1)                                  % 3x1 grid, 1st plot
line1 = animatedline('Color', 'red');             % line in the plot
title("Truncated Sinusoid traveling in +z direction") % title
xlabel("z [m]"); ylabel("amplitude")              % axis labels
xlim(z([1 end])); ylim([-A A])                     % axis limits

subplot(3, 1, 2)                                  % 3x1 grid, 2nd plot
line2 = animatedline('Color', 'blue');            % line in the plot
title("Truncated Sinusoid traveling in -z direction") % title
xlabel("-z [m]"); ylabel("amplitude")              % axis labels
xlim(z([1 end])); ylim([-A A])                     % axis limits

subplot(3, 1, 3)                                  % 3x1 grid, 3rd plot
line3 = animatedline('Color', 'magenta');         % line in the plot
title("Superposition of two preceeding two waves in both directions")%title
xlabel("z [m]"); ylabel("amplitude")              % axis labels
xlim(z([1 end])); ylim([-2*A 2*A])                   % axis limits

% animation instructions
for ti = t
    clearpoints(line1)
    clearpoints(line2)
    clearpoints(line3)
    addpoints(line1, z, wave(+z, ti))
    addpoints(line2, z, wave(-z, ti))
    addpoints(line3, z, wave(+z, ti)+wave(-z, ti))
    drawnow limitrate
end

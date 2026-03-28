function [T,X,Y,Z,U,V,W] = satellite(Xo,Yo,Zo,Uo,Vo,Wo,Tf)
%SATELLITE takes the initial postion and velocity vector values from the
%satellite_data.txt and simulates the trajectory (X,Y,Z) and velocity
%(U,V,W) of the satellite with respect to time
% outputs are in SI units.
% Call format: [T, X, Y, Z, U, V, W] = satellite(Xo, Yo, Zo, Uo, Vo, Wo, Tf)

Me = 5.97*(10^24); % Mass of the Earth (kg)
G = 6.67408*(10^-11); % Gravitational Constant (m^3*kg^-1*s^-2)
m = 250; % Mass of the satellite (kg)
As = 0.25; % Projected area of the satellite (m^2)
pa = 5.5*(10^-12); % Air density (kg*m^-3)
Cd = 2.2; % drag coefficient 
dt = 1; % Change in time (s)

lim = ceil(Tf/dt); % Allows size of array for each component in the trajectory vector (X,Y,Z) and velocity vector (U,V,W) to be adjusted based on flight duration (Tf - final time) 
T = zeros(1,lim);
X = zeros(1,lim);
Y = zeros(1,lim);
Z = zeros(1,lim);
U = zeros(1,lim);
V = zeros(1,lim);
W = zeros(1,lim);

% Preallocation of inital postion (Xo,Yo,Zo) and velocity (Uo,Vo,Wo),
% obtained from the data set 'satellite_data.txt'
T(1) = 0;
X(1) = Xo;
Y(1) = Yo;
Z(1) = Zo;
U(1) = Uo;
V(1) = Vo;
W(1) = Wo;

% For-loop simulates the trajectory and velocity of the satellite with
% respect to time using Euler-Cromer Method on Newton's Second Law
for n = 1:lim
    T(n+1) = T(n) + dt;
    U(n+1) = U(n) - (G*Me*(X(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) + (((Cd*pa*As)/(2*m))*(U(n)))*sqrt(U(n)^2 + V(n)^2 + W(n)^2))*dt;
    V(n+1) = V(n) - (G*Me*(Y(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) + (((Cd*pa*As)/(2*m))*(V(n)))*sqrt(U(n)^2 + V(n)^2 + W(n)^2))*dt;
    W(n+1) = W(n) - (G*Me*(Z(n)/(X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) + (((Cd*pa*As)/(2*m))*(W(n)))*sqrt(U(n)^2 + V(n)^2 + W(n)^2))*dt;
    X(n+1) = X(n) + U(n+1)*dt;
    Y(n+1) = Y(n) + V(n+1)*dt;
    Z(n+1) = Z(n) + W(n+1)*dt;

% Used to adjust for error value returned when for-loop reaches 'lim' 
end
U(end) = [];
V(end) = [];
W(end) = [];
X(end) = [];
Y(end) = [];
Z(end) = [];

end % satellite function 

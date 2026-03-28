clear all; close all; clc;
format long; format compact; 
name = 'Kayla Washington';
id = 'A********'; 
hw_num = 'project'; 

tic
%% Task 1 
% Use function satellite to obtain the trajectory of the first satellite (ID: 0001) in the
% satellite data.txt file for a duration of Tf = 5,000 s. Create figure 1 to plot the trajectory.
% Also include the final position of the satellite and Earth surface in each panel

% Get the folder where this script is located
projectFolder = fileparts(mfilename('fullpath'));

% Define images folder path
imagesFolder = fullfile(projectFolder, 'images');

% Create images folder if it doesn't exist
if ~exist(imagesFolder, 'dir')
    mkdir(imagesFolder);
end

[Xo,Yo,Zo,Uo,Vo,Wo] = read_input('satellite_data.txt',1); % Preallocation of Intial Positon and Velocity of 1st Satellite 
% (Xo, Yo, Zo) - inital postion vector 
% (Uo, Vo, Wo) - inital velocity vector 

[T,X,Y1,Z,U,V,W1] = satellite(Xo,Yo,Zo,Uo,Vo,Wo,5000); 
Re = 6.37e6; % Radius of the Earth (m)
load('earth_topo.mat'); 

figure(1);hold on;

plot3(X/1e6,Y1/1e6,Z/1e6,'black');
plot3(X(end)/1e6,Y1(end)/1e6,Z(end)/1e6,'o','Markerfacecolor','black');
[x,y,z] = sphere(50);

s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); % creates a sphere
s.CData = topo; % sets color data to topographic data            
s.FaceColor = 'texturemap'; % use texture mapping
s.EdgeColor = 'none'; % removes edges
s.FaceLighting = 'gouraud';  % preferred lighting for curved surfaces  
s.SpecularStrength = 0.4; % change the strength of the reflected light     
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('Satellite One');
set(gca,'LineWidth',1,'FontSize',14,'Xtick',-6:4:6,'Ytick',-6:4:6,'Ztick',-6:4:6);
view(3)

exportgraphics(gcf, fullfile(imagesFolder, 'orbit_single.png'), 'Resolution', 300);

p1a = evalc('help satellite');
p1b = 'See figure 1';
%% Task 2 
% Use function read input and satellite to obtain the trajectories for the first six satellites (ID: 0001-0006) in the satellite data.txt file for a duration of Tf = 12,400 s. Create
% figure 2 which includes 2 panels. On the top panel, plot altitude versus time for the six
% satellites. Plot speed versus time in the bottom panel.

Tf = 12400;
for n = 1:6
    [Xo,Yo,Zo,Uo,Vo,Wo] = read_input('satellite_data.txt',n);
    [T,X,Y,Z,U,V,W] = satellite(Xo,Yo,Zo,Uo,Vo,Wo,Tf);
    result(n).T = T;
    result(n).X = X;
    result(n).Y = Y;
    result(n).Z = Z;
    result(n).U = U;
    result(n).V = V;
    result(n).W = W;
    result(n).h = sqrt(X.^2 + Y.^2 + Z.^2) - Re;
    result(n).Vmag = sqrt(U.^2 + V.^2 + W.^2);
end
  
figure(2);hold on;

subplot(2,1,1);hold on;
for n = 1:6
    plot(result(n).h);
    legend_string{n} = sprintf('Satellite %d',n);
end
title('Altitude of the First 6 Satellites');
ylabel('Altitude (m)');
legend(legend_string);

subplot(2,1,2);hold on;
for n = 1:6
    plot(result(n).Vmag);
    legend_string{n} = sprintf('Satellite %d',n);
end
title('Speed of the First 6 Satellites');
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend(legend_string); 

counter_altitude = 0;
sat_id(1) = 1;
for k = 1:6
    counter_altitude = 0;
    for j = 2:length(result(n).h)-1 
        if result(k).h(j) > result(k).h(j+1) && result(k).h(j) > result(k).h(j-1) 
            counter_altitude = counter_altitude + 1;
            time_lmax_altitude(counter_altitude) = result(k).T(j);
        end
    end
            stat(k).time_lmax_altitude = time_lmax_altitude;
            orbital_period = time_lmax_altitude(2) - time_lmax_altitude(1);
    stat(k).orbital_period = orbital_period;
    sat_id(k) = k;
    stat(k).sat_id = sat_id(k);
    final_position{k} = [result(k).X(end),result(k).Y(end),result(k).Z(end)];
    stat(k).final_position = final_position;
    final_velocity{k} = [result(k).U(end),result(k).V(end),result(k).W(end)];
    stat(k).final_velocity = final_velocity;
    travel_distance = sum(sqrt(diff(X).^2) + diff(Y).^2 + diff(Z).^2);
end
                                                            

fid = fopen('report.txt','w');
fprintf(fid,'Name:Kayla Washington');
fprintf(fid,'PID:A********');
fprintf(fid,'satellite_ID, travel_distance (m), orbital_period (s)');
for k = 1:6
    fprintf(fid, '%d, %15.9e, %15.9e\n',stat(k).sat_id,travel_distance,stat(k).orbital_period);
end
fclose(fid)

exportgraphics(gcf, fullfile(imagesFolder, 'altitude_speed.png'), 'Resolution', 300);

p2a = evalc('help read_input');
p2b = 'See figure 2';
p2c = stat(1);
p2d = stat(2);
p2e = stat(3);
p2f = stat(4);
p2g = stat(5);
p2h = stat(6);
p2i = evalc('type report.txt');
%% Task 3 

Tf = 6000;
for j = 1:520
    [Xo,Yo,Zo,Uo,Vo,Wo] = read_input('satellite_data.txt',j);
    [T,X,Y,Z,U,V,W] = satellite(Xo,Yo,Zo,Uo,Vo,Wo,Tf);
    result(j).T1 = T(1);
    result(j).X1 = Xo;
    result(j).Y1 = Yo;
    result(j).Z1 = Zo;
    result(j).U1 = Uo;
    result(j).V1 = Vo;
    result(j).W1 = Wo;
    result(j).T2 = T(end);
    result(j).X2 = X(end);
    result(j).Y2 = Y(end);
    result(j).Z2 = Z(end);
    result(j).U2 = U(end);
    result(j).V2 = V(end);
    result(j).W2 = W(end);
end

x1 = -5.6*10^6;
y1 = -3.9*10^6;
z1 = 0;

Re = 6.37e6;
load('earth_topo.mat'); 
figure(3);hold on;

subplot(1,2,2);hold on;
for j = 1:520 
  if sqrt(((result(j).X2/1e6)+x1)^2) + (((result(j).Y2/1e6)+y1)^2) + (((result(j).Z2/1e6)+z1)^2) <= 2e6
        plot3(result(j).X2/1e6,result(j).Y2/1e6,result(j).Z2/1e6,'o','MarkerFaceColor','b');
  else 
       plot3(result(j).X2/1e6,result(j).Y2/1e6,result(j).Z2/1e6,'o','MarkerFaceColor','m');
  end
end

[x,y,z] = sphere(50);
s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); 
s.CData = topo;                
s.FaceColor = 'texturemap';    
s.EdgeColor = 'none';          
s.FaceLighting = 'gouraud';    
s.SpecularStrength = 0.4;      
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('All Satellites at Time = 6000s');
set(gca,'LineWidth',1,'FontSize',14,'Xtick',-6:4:6,'Ytick',-6:4:6,'Ztick',-6:4:6);
view(3)

subplot(1,2,1);hold on;
for j = 1:520
      if sqrt(((result(j).X1/1e6)+x1)^2) + (((result(j).Y1/1e6)+y1)^2) + (((result(j).Z1/1e6)+z1)^2) <= 2e6
        plot3(result(j).X2/1e6,result(j).Y2/1e6,result(j).Z2/1e6,'o','MarkerFaceColor','b');
      else
        plot3(result(j).X1/1e6,result(j).Y1/1e6,result(j).Z1/1e6,'o','MarkerFaceColor','m');
      end
end
[x,y,z] = sphere(50);
s = surf(Re*x/1e6,Re*y/1e6,Re*z/1e6); 
s.CData = topo;                
s.FaceColor = 'texturemap';    
s.EdgeColor = 'none';          
s.FaceLighting = 'gouraud';    
s.SpecularStrength = 0.4;      
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('All Satellites at Time = 0s');
set(gca,'LineWidth',1,'FontSize',14,'Xtick',-6:4:6,'Ytick',-6:4:6,'Ztick',-6:4:6);
view(3)

exportgraphics(gcf, fullfile(imagesFolder, 'orbit_all.png'), 'Resolution', 300);

p3a = 'See figure 3';
p3b = 'The satellites move fastest when they are farthest from Earth';
p3c = 'As the satellites travel away from the earth, their speed increases';
fprintf('Project complete in %f s\n',toc)
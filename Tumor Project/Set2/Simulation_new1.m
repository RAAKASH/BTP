%% BTP - Simulation
clc
clear
import com.comsol.model.*
import com.comsol.model.util.*
Surf_X = []; % set of all points on the sphere
for theta = 0:pi/4:2*pi
    for alpha = 0:pi/4:pi
     iter=iter+1;
     Surf_X(iter,:) = [R2*sin(alpha)*cos(theta),R2*sin(alpha)*sin(theta),R2*cos(alpha)];
    end
end
%% varying position and radius of tumours

i=0;
fprintf('start \n');
R = 0.001:0.001:0.03; % RADIUS OF TUMOR
for i = R % Radius of tumour 
    for r1 = 0.01:0.01:(0.072-i) % Radial position of tumour
	  for theta = 5:60:360
            for phi = 5:60:180
              x(i) = r1*cos(theta/180*pi)*cos(phi/180*pi)
              z(i) = r1*cos(theta/180*pi)*cos(phi/180*pi)
              y(i) = r1*sin(phi/180*pi) 
              R1(i) = i;          

            end
        end
    end
end
% Decreasing dataset size because it is exponentially large with the increase in no of tumors
m = length(x)
rng(1) % setting seed
random = rand(1,m)>0.7
x = x(random);
y = y(random);
z = z(random);
R1 = R1(random);
m = length(x)
% Simulation start
iter =0;
for i = 1:m
	for j = i:m
 		for k = j:m
                   iter = iter +1;

                   X1(iter) = x(i);
                   Y1(iter) = y(i) ;
                   Z1(iter) = z(i); 
                   R1(iter) = r(i);
                   X2(iter) = x(j);
                   Y2(iter) = y(j) ;
                   Z2(iter) = z(j); 
                   R2(iter) = r(j);
                   X3(iter) = x(k);
                   Y3(iter) = y(k) ;
                   Z3(iter) = z(k); 
                   R3(iter) = r(k);
                   

       
                 end
         end
end
[model,T] = Blockhemis2new(X1,Y1,Z1,R1,X2,Y2,Z2,R2,X3,Y3,Z3,R3,Surf_X);

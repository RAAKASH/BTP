%% BTP - Simulation
clc
clear
% To import or not
importing = 1;
if importing
    fprintf('Importing, starting server \n');
    cd ('C:\Program Files\COMSOL\COMSOL53\Multiphysics\mli');
    import com.comsol.model.*
    import com.comsol.model.util.*
    mphstart(2036)  
    cd ('C:\Users\Aakash.R\Desktop\notes,lectures\8th sem\BTP\BTP\Tumor Project\Set1');
    
end
%% varying position and radius of tumours

i=0;
fprintf('start \n');
R = 0.001:0.001:0.03; % RADIUS OF TUMOR
iter = 1;
for i = R % Radius of tumour 
    for r1 = 0.01:0.01:(0.072-i) % Radial position of tumour
	  for theta = 5:60:360
            for phi = 5:60:180
              x(iter) = r1*cos(theta/180*pi)*cos(phi/180*pi);
              z(iter) = r1*cos(theta/180*pi)*cos(phi/180*pi);
              y(iter) = r1*sin(phi/180*pi) ;
              R1(iter) = i;
              iter = iter+1;

            end
      end
    end
end
% Decreasing dataset size because it is exponentially large with the increase in no of tumors
m = length(x);
rng(1) % setting seed
random = rand(1,m)>0.7;
x = x(random);
y = y(random);
z = z(random);
R1 = R1(random);
m = length(x);
% Simulation start
iter =0;
for i = 1:m
	for j = i:m
 		for k = j:m
                   iter = iter +1;

                   model = Blockhemis2(x(i),y(i),z(i),R1(i),x(j),y(j),z(j),R1(j),x(k),y(k),z(k),R1(k));    
                   pd = mpheval(model,'T','dataset','ps1');
                   T(:,iter) =     pd.d1; % If shows error try pd.d1'
                   ModelUtil.clear ; % removing all models
                 end
         end
end

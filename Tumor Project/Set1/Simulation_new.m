%% BTP - Simulation
clc
clear
% To import or not

importing = 1;
if importing
%     ModelUtil.disconnect
    fprintf('Importing, starting server \n');
    cd ('F:\Comsol\COMSOL53\Multiphysics\mli');
    import com.comsol.model.*
    import com.comsol.model.util.*
%     mphstart(2036)  
    cd ('C:\Users\Aakash.R\Desktop\notes,lectures\8th sem\BTP\BTP\Tumor Project\Set1');
    
end
%% varying position and radius of tumours
clear x y z R R1
clc
i=0;
fprintf('Generating parameters for manual sweeping \n');
R = 0.005:0.005:0.035; % RADIUS OF TUMOR
iter = 1;
for i = R % Radius of tumour 
    for r1 = 0.04:0.005:(0.072-i) % Radial position of tumour
	  for theta = 5:60:360
            for phi = 5:60:180
              x(iter) = r1*cos(theta/180*pi)*cos(phi/180*pi);
              z(iter) = r1*sin(theta/180*pi)*cos(phi/180*pi);
              y(iter) = r1*sin(phi/180*pi) ;
              R1(iter) = i;
              iter = iter+1;

            end
      end
    end
end
fprintf('No of simulations for 1 tumor : %d \n',length(x))
%% Decreasing dataset size because it is exponentially large with the increase in no of tumors
clc
fprintf('Reducing no of simulations\n');
m = length(x);
rng(1) % setting seed
random1 = rand(1,m)>0.95;  % Random elimination, increase threshold to decrease simulation
random2 = y>((0.072^2-x.^2-y.^2).^0.5-0.03); % eliminating tumors deeper than 30mm
random = (random1.*random2)==1; % Final list of parameters
x = x(random);
y = y(random);
z = z(random);
R1 = R1(random);
m = length(x);
fprintf('No of simulations of 1 tumor reduced to %d\n',m);
%Finding total number of simulations
totsim = 0;
for i = 1:m 
    for j = i:m
        for k = j:m
            totsim = totsim+1;
        end
    end
end
fprintf('No of simulations for all tumors together is %d\n',totsim);
%%  Simulation start
iter =0;
clc
T = [];
X = [];
for i = 1:m
    for j = i:m
        for k = j:m
                   iter = iter +1;
                   fprintf('Iteration no %d /%d \n', iter,totsim);
                   model = Blockhemis2(x(i),y(i),z(i),R1(i),x(j),y(j),z(j),R1(j),x(k),y(k),z(k),R1(k));  
                   if model==0
                       iter=iter-1;
%                        T(:,iter) =  -500;
                   else
                        X(:,iter) = [x(i),y(i),z(i),R1(i),x(j),y(j),z(j),R1(j),x(k),y(k),z(k),R1(k)]';
                        pd = mphinterp(model,'T','dataset','ps1','coorderr','on'); % Tested with export as well, working fine
                        T(:,iter) =  pd(~isnan(pd))'; % or pd
                   end
%                    ModelUtil.clear ; % removing all models
        end
     end
end

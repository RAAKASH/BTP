function out = Blockhemis2(X1,Y1,Z1,R1,X2,Y2,Z2,R2,X3,Y3,Z3,R3)
%
% Blockhemis2.m
%
% Model exported on Apr 12 2018, 18:39 by COMSOL 5.3.0.223.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\munna\Desktop\btp');

model.label('Block-hemis2.mph');

model.comments(['Untitled\n\n']);

model.param.set('x_1', strcat(num2str(X1),'[m]'));
model.param.set('y_1', strcat(num2str(Y1),'[m]'));
model.param.set('z_1', strcat(num2str(Z1),'[m]'));
model.param.set('r_1', strcat(num2str(R1),'[m]'));
model.param.set('R_1', '(0.144/2)[m]', 'Radius of the big sphere');
model.param.set('x_cp', '0[m]');
model.param.set('y_cp', '0[m]');
model.param.set('z_cp', '0[m]');
model.param.set('x_2', strcat(num2str(X2),'[m]'));
model.param.set('y_2', strcat(num2str(Y2),'[m]'));
model.param.set('z_2', strcat(num2str(Z2),'[m]'));
model.param.set('r_2', strcat(num2str(R2),'[m]'));
model.param.set('x_3', strcat(num2str(X3),'[m]'));
model.param.set('y_3', strcat(num2str(Y3),'[m]'));
model.param.set('z_3', strcat(num2str(Z3),'[m]'));
model.param.set('r_3', strcat(num2str(R3),'[m]'));

model.component.create('comp1', false);
model.component('comp1').geom.create('geom1', 3);

model.result.table.create('evl3', 'Table');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').label('Block');
model.component('comp1').geom('geom1').geomRep('comsol');
model.component('comp1').geom('geom1').repairTolType('relative');
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').label('tumor1');
model.component('comp1').geom('geom1').feature('sph1').set('pos', {'x_1' 'y_1' 'z_1'});
model.component('comp1').geom('geom1').feature('sph1').set('r', 'r_1');
model.component('comp1').geom('geom1').create('sph3', 'Sphere');
model.component('comp1').geom('geom1').feature('sph3').label('tumor2');
model.component('comp1').geom('geom1').feature('sph3').set('pos', {'x_2' 'y_2' 'z_2'});
model.component('comp1').geom('geom1').feature('sph3').set('r', 'r_2');
model.component('comp1').geom('geom1').create('sph4', 'Sphere');
model.component('comp1').geom('geom1').feature('sph4').label('tumor3');
model.component('comp1').geom('geom1').feature('sph4').set('pos', {'x_3' 'y_3' 'z_3'});
model.component('comp1').geom('geom1').feature('sph4').set('r', 'r_3');
model.component('comp1').geom('geom1').create('csol1', 'ConvertToSolid');
model.component('comp1').geom('geom1').feature('csol1').set('selresult', true);
model.component('comp1').geom('geom1').feature('csol1').set('selresultshow', 'all');
model.component('comp1').geom('geom1').feature('csol1').selection('input').set({'sph1' 'sph3' 'sph4'});
model.component('comp1').geom('geom1').create('sph2', 'Sphere');
model.component('comp1').geom('geom1').feature('sph2').set('r', 'R_1');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('pos', [0 -0.5 0]);
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'csol1' 'sph2'});
model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.component('comp1').geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.view.create('view2', 2);
model.view.create('view3', 2);
model.view.create('view4', 2);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1]);
model.component('comp1').material('mat2').selection.named('geom1_csol1_dom');

model.component('comp1').physics.create('ht', 'BioHeat', 'geom1');
model.component('comp1').physics('ht').feature('bt1').create('opq1', 'Opacity', 3);
model.component('comp1').physics('ht').feature('bt1').create('bh2', 'Bioheat', 3);
model.component('comp1').physics('ht').feature('bt1').feature('bh2').selection.named('geom1_csol1_dom');
model.component('comp1').physics('ht').create('hs1', 'HeatSource', 3);
model.component('comp1').physics('ht').create('open1', 'OpenBoundary', 2);
model.component('comp1').physics('ht').feature('open1').selection.all;
model.component('comp1').physics('ht').create('init2', 'init', 3);
model.component('comp1').physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.component('comp1').physics('ht').feature('hf1').selection.all;
model.component('comp1').physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht').feature('temp1').selection.set([1]);

model.component('comp1').mesh('mesh1').autoMeshSize(4);

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments('Interactive 3D values');

model.capeopen.label('Thermodynamics Package');

model.component('comp1').view('view1').set('showgrid', false);
model.component('comp1').view('view1').set('scenelight', false);
model.component('comp1').view('view1').set('transparency', true);
model.view('view2').axis.set('xmin', -0.8412294387817383);
model.view('view2').axis.set('xmax', 0.8412294387817383);
model.view('view2').axis.set('ymin', -0.21296948194503784);
model.view('view2').axis.set('ymax', 0.21296948194503784);
model.view('view2').axis.set('abstractviewlratio', -1.6724998950958252);
model.view('view2').axis.set('abstractviewrratio', 1.6724998950958252);
model.view('view2').axis.set('abstractviewbratio', -0.04999998211860657);
model.view('view2').axis.set('abstractviewtratio', 0.04999998211860657);
model.view('view2').axis.set('abstractviewxscale', 0.0042593893595039845);
model.view('view2').axis.set('abstractviewyscale', 0.004259389825165272);
model.view('view3').axis.set('xmin', -3.950000047683716);
model.view('view3').axis.set('xmax', 3.950000047683716);
model.view('view4').axis.set('xmin', -3.950000047683716);
model.view('view4').axis.set('xmax', 3.950000047683716);

model.component('comp1').material('mat1').label('Muscle');
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '3421[J/(kg*K)]');
model.component('comp1').material('mat1').propertyGroup('def').set('density', '1090[kg/m^3]');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'0.49[W/(m*K)]' '0' '0' '0' '0.49[W/(m*K)]' '0' '0' '0' '0.49[W/(m*K)]'});
model.component('comp1').material('mat2').label('Fat');
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', '2348[J/(kg*K)]');
model.component('comp1').material('mat2').propertyGroup('def').set('density', '911[kg/m^3]');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {'0.21[W/(m*K)]' '0' '0' '0' '0.21[W/(m*K)]' '0' '0' '0' '0.21[W/(m*K)]'});
model.component('comp1').material('mat2').propertyGroup('def').set('frequencyfactor', '4.43e16');
model.component('comp1').material('mat2').propertyGroup('def').set('activationenergy', '1.3e5');

model.component('comp1').physics('ht').prop('PhysicalModelProperty').set('HeatTransferInPorousMedia', true);
model.component('comp1').physics('ht').prop('PhysicalModelProperty').set('hasDG', false);
model.component('comp1').physics('ht').feature('bt1').set('k', [0.42; 0; 0; 0; 0.42; 0; 0; 0; 0.42]);
model.component('comp1').physics('ht').feature('bt1').feature('bh1').set('Cp_b', 3000);
model.component('comp1').physics('ht').feature('bt1').feature('bh1').set('omegab', '0.00018*10^(-3)');
model.component('comp1').physics('ht').feature('bt1').feature('bh1').set('rhobl', 920);
model.component('comp1').physics('ht').feature('bt1').feature('bh1').set('Qmet', 450);
model.component('comp1').physics('ht').feature('bt1').feature('opq1').label('Opaque 1');
model.component('comp1').physics('ht').feature('bt1').feature('bh2').set('Cp_b', 3000);
model.component('comp1').physics('ht').feature('bt1').feature('bh2').set('omegab', '0.009*10^(-3)');
model.component('comp1').physics('ht').feature('bt1').feature('bh2').set('rhobl', 920);
model.component('comp1').physics('ht').feature('bt1').feature('bh2').set('Qmet', 29000);
model.component('comp1').physics('ht').feature('init1').set('Tinit', '273+37[K]');
model.component('comp1').physics('ht').feature('hs1').set('P0', 1);
model.component('comp1').physics('ht').feature('hs1').set('Q0', 29000);
model.component('comp1').physics('ht').feature('hs1').active(false);
model.component('comp1').physics('ht').feature('open1').set('T0', '300[K]');
model.component('comp1').physics('ht').feature('open1').active(false);
model.component('comp1').physics('ht').feature('init2').set('Tinit', '400[K]');
model.component('comp1').physics('ht').feature('init2').active(false);
model.component('comp1').physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.component('comp1').physics('ht').feature('hf1').set('h', 13.5);
model.component('comp1').physics('ht').feature('hf1').set('Text', '300[K]');
model.component('comp1').physics('ht').feature('temp1').set('T0', '37 + 273[K]');

model.frame('material1').sorder(1);

model.component('comp1').physics('ht').feature('bt1').set('k_mat', 'userdef');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset.create('ps1', 'ParSurface');
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg2').create('iso1', 'Isosurface');
model.result.export.create('data1', 'Data');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid Solver (ht)');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid Solver (ht)');
model.sol('sol1').runAll;

model.result.dataset('cpt1').set('pointx', 0.1);
model.result.dataset('cpt1').set('pointy', 0.1);
model.result.dataset('cpt1').set('pointz', 0.1);
model.result.dataset('ps1').set('par1', 'theta');
model.result.dataset('ps1').set('parmax1', '2*pi');
model.result.dataset('ps1').set('par2', 'phi');
model.result.dataset('ps1').set('parmax2', 'pi');
model.result.dataset('ps1').set('exprx', 'R_1*sin(phi)*cos(theta)');
model.result.dataset('ps1').set('expry', 'R_1*cos(phi)');
model.result.dataset('ps1').set('exprz', 'R_1*sin(phi)*sin(theta)');
model.result.dataset('ps1').set('res1', 20);
model.result.dataset('ps1').set('res2', 20);
model.result('pg1').label('Temperature (ht)');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormin', 304.09321254824);
model.result('pg1').feature('surf1').set('rangecolormax', 311);
model.result('pg1').feature('surf1').set('colortable', 'Spectrum');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg2').label('Isothermal Contours (ht)');
model.result('pg2').feature('iso1').set('number', 10);
model.result('pg2').feature('iso1').set('colortable', 'ThermalLight');
model.result('pg2').feature('iso1').set('resolution', 'normal');
model.result.export('data1').active(false);
model.result.export('data1').set('data', 'cpt1');
% model.result.export('data1').set('filename', 'C:\Users\Aakash.R\Desktop\notes,lectures\7th sem\BTP\Simulation-1\test.txt');

out = model;

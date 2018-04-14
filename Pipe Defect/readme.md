# Pipe Defect Project 

Check <a href ="https://docs.google.com/spreadsheets/d/1jZoKRMCWiBdC0zCo6taUhGxCAXIs6Qd1isyRwSn-uFw/edit#gid=0"> Paramerters </a> for parameter list.
Also check how the sim file parameters correspond to the parameters in the above sheet.<br> When it comes to exporting the results follow the below steps:
<ol>
 <li> Go to export, data1 tab.
  <li> For time selection select interpolated.
   <li> For times enetr : range(20,1,40).
  <li> In section output set output destination, file name.
   <li> Press the export button.
 </ol>
 One important note, in the dataset tab, parametric surface decrease the resolution to 20x20.
 Just a precaution don't delete the simulation file and the solutions after the results are generated. After you have completed a simulation go the above sheet and enter your status. 
<br>
<h1> Information about simulations</h1>
<h2> Radiation</h2>
<h3> Method A - Using simulations</h3>
First checked if radiation played any significant role in simulations because it takes double the time on an i7 4510U processor. This was done by using the below steps.
<ul>
<li> Running simulations with radiation, without radiation.
<li> Compare the temperature profiles for the time of simulation.
</ul>
<h3> Method B - Using correlations</h3>
<h4>Heat Transfer coefficient due to radiation</h4>
<ul>
 <li> T ambient = 293.15 K
 <li> T pipe = 500 K 
  </ul>
 <br>Emissivity = 0.85 
 Hence, heat transfer coefficient due to radiation is <b>12.84 W/(m^2 K)</b>
 <h4>Heat Transfer coefficient due to forced convection</h4>
 <ul>
 <li> Pipe outer diameter = 113 mm .
 <li> Air inlet velocity = 5 m/s. 
 <li> Air Temperature at infinity is approximately 300 K.
 <li> Kinematic vicosity is given by 1.568* 10^-5 m^2/s.
  <li> Thermal conductivity of air =  2.62* 10^-2 W/(mK)
 <li> Prandtl number is given by 0.707. Check <a href ="https://www.engineeringtoolbox.com/dry-air-properties-d_973.html"> Air 
   Properties </a>, for more info.
</ul>
    
 <br> Hence the <b>reynolds number </b> is calculated and found to be <b>36033</b>.
 Hence using <a href ="http://www.iust.ac.ir/files/mech/mazidi_9920c/heat_transfer_ii/Heat%20Transfer%20II-%20lecture%20note%202.pdf"> hilpert's correlation </a> we obtain the parameters as:
 <ul>
  <li>C = 0.193
    <li> m = 0.618
      </ul>
 Hence we find out the <b>nusselt number</b> using the correlation as <b>112.56</b>. Finally we can calculate the <b>heat transfer coefficient</b>, it is found to be equal to <b> 135.22 W/(m^2 K)</b>.
 Hence as can be seen the heat transfer coefficient due to radiation is 10% of the conjugate heat transfer, even when the emissivity is as high as 0.85.
 
<h3> Results </h3>
From method A we, it was found that there werent any significant temperature difference. Hence it is concluded that radiation can be safely droped from simulations.


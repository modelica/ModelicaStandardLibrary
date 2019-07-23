within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACpin "Single AC pin"

  Modelica.Electrical.Analog.Interfaces.PositivePin ac "AC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.SIunits.Voltage vAC=ac.v "AC potential";
  Modelica.SIunits.Current iAC=ac.i "AC current";
  Modelica.SIunits.Power powerAC=vAC*iAC "AC power";
end ACpin;

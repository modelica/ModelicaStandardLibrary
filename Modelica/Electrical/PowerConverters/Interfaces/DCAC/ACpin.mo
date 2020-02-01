within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACpin "Single AC pin"

  Modelica.Electrical.Analog.Interfaces.PositivePin ac "AC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vAC=ac.v "AC potential";
  SI.Current iAC=ac.i "AC current";
  SI.Power powerAC=vAC*iAC "AC power";
end ACpin;

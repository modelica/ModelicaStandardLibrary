within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACtwoPin "Positive and negative AC pin"

  Modelica.Electrical.Analog.Interfaces.PositivePin ac_p
    "Positive AC input"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ac_n
    "Negative AC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vAC=ac_p.v - ac_n.v "AC voltages";
  SI.Current iAC=ac_p.i "AC currents";
  SI.Power powerAC=vAC*iAC "AC power";
end ACtwoPin;

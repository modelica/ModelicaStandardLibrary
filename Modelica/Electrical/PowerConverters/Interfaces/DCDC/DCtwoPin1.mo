within Modelica.Electrical.PowerConverters.Interfaces.DCDC;
partial model DCtwoPin1 "Positive and negative pins of side 1"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p1
    "Positive DC input"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n1
    "Negative DC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vDC1=dc_p1.v - dc_n1.v "DC voltage side 1";
  SI.Current iDC1=dc_p1.i "DC current side 1";
  SI.Power powerDC1=vDC1*iDC1 "DC power side 1";
end DCtwoPin1;

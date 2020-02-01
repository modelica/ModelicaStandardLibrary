within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model DCtwoPin "Positive and negative DC pins"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
    "Positive DC input"
    annotation (Placement(transformation(extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n
    "Negative DC input"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vDC=dc_p.v - dc_n.v "DC voltage";
  SI.Current iDC=dc_p.i "DC current";
  SI.Power powerDC=vDC*iDC "DC power";
end DCtwoPin;

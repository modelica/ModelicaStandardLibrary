within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model DCtwoPin "Positive and negative DC pins"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n
    "Negative DC output"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.SIunits.Voltage vDC=dc_p.v-dc_n.v "DC voltage";
  Modelica.SIunits.Current iDC=dc_p.i "DC current";
  Modelica.SIunits.Power powerDC=vDC*iDC "DC power";
end DCtwoPin;

within Modelica.Electrical.PowerConverters.Interfaces.DCDC;
partial model DCtwoPin2 "Positive and negative pins of side 2"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p2
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n2
    "Negative DC output"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  SI.Voltage vDC2=dc_p2.v - dc_n2.v "DC voltages side 2";
  SI.Current iDC2=dc_p2.i "DC current side 2";
  SI.Power powerDC2=vDC2*iDC2 "DC power side 2";
end DCtwoPin2;

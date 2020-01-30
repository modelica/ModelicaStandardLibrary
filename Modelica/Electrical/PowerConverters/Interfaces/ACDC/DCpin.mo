within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model DCpin "Single DC pin"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vDC=dc_p.v "DC potential";
  SI.Current iDC=dc_p.i "DC current";
  SI.Power powerDC=vDC*iDC "DC power";
end DCpin;

within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model DCpin "Single DC pin"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
    "Positive DC output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.SIunits.Voltage vDC=dc_p.v "DC potential";
  Modelica.SIunits.Current iDC=dc_p.i "DC current";
  Modelica.SIunits.Power powerDC=vDC*iDC "DC power";
end DCpin;

within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialClockedMIMO
  "Block with multiple clocked input and multiple clocked output Real signals"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  parameter Integer nin=1 "Number of inputs";
  parameter Integer nout=1 "Number of outputs";

  Modelica.Blocks.Interfaces.RealInput u[nin]
    "Connector of clocked, Real input signals"
                               annotation (Placement(transformation(extent=
          {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[nout]
    "Connector of clocked, Real output signals"
                                annotation (Placement(transformation(extent=
         {{100,-10},{120,10}})));

end PartialClockedMIMO;

within Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit;
model MixingUnit
  "Mixing unit demo from Foellinger, Nichtlineare Regelungen II, p. 280"

  Modelica.Blocks.Interfaces.RealInput T_c(unit="K")
    "Cooling temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput c(unit="mol/l") "Concentration"
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
  Modelica.Blocks.Interfaces.RealOutput T(unit="K")
    "Temperature in mixing unit"
    annotation (Placement(transformation(extent={{100,-80},{140,-40}})));
  parameter Real c0(unit="mol/l") = 0.848 "Nominal concentration";
  parameter SI.Temperature T0 = 308.5 "Nominal temperature";
  parameter Real a1 = 0.2674 "Process parameter (see references in help)";
  parameter Real a21 = 1.815 "Process parameter (see references in help)";
  parameter Real a22 = 0.4682 "Process parameter (see references in help)";
  parameter Real b = 1.5476 "Process parameter (see references in help)";
  parameter Real k0 = 1.05e14 "Process parameter (see references in help)";
  parameter Real eps = 34.2894 "Process parameter (see references in help)";
  Real gamma "Reaction speed";
protected
  parameter SI.Time tau0 = 60;
  parameter Real wk0 = k0/c0;
  parameter Real weps = eps*T0;
  parameter Real wa11 = a1/tau0;
  parameter Real wa12 = c0/tau0;
  parameter Real wa13 = c0*a1/tau0;
  parameter Real wa21 = a21/tau0;
  parameter Real wa22 = a22*T0/tau0;
  parameter Real wa23 = T0*(a21 - b)/tau0;
  parameter Real wb = b/tau0;
equation
  gamma = c*wk0*exp( -weps/T);
  der(c) = -wa11*c - wa12*gamma + wa13;
  der(T) = -wa21*T + wa22*gamma + wa23 + wb*T_c;
  annotation (                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,40},{100,-100}},
          lineColor={255,255,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,100},{-100,-100},{100,-100},{100,100}}, color={0,
              0,0}),
        Text(
          extent={{-144,148},{148,100}},
          textColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{118,-86},{160,-124}},
          textString="T"),
        Text(
          extent={{116,114},{158,76}},
          textString="c"),
        Text(
          extent={{-194,72},{-108,34}},
          textString="T_c"),
        Line(points={{0,-50},{0,-100}}),
        Ellipse(
          extent={{-42,-38},{0,-66}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-38},{42,-66}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,16}}),
        Line(points={{20,80},{20,16}}),
        Line(points={{-86,-72},{-86,-114}}),
        Line(points={{-66,-72},{-66,-114}})}),
    Documentation(info="<html>
See description in <a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">ControlledMixingUnit</a>.
</html>"));
end MixingUnit;

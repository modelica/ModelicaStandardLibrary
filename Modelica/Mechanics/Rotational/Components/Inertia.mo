within Modelica.Mechanics.Rotational.Components;
model Inertia "1D-rotational component with inertia"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter SI.Inertia J(min=0, start=1) "Moment of inertia";
  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use phi and w as states"
    annotation (HideResult=true, Dialog(tab="Advanced"));
  SI.Angle phi(stateSelect=stateSelect)
    "Absolute rotation angle of component"
    annotation (Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularVelocity w(stateSelect=stateSelect)
    "Absolute angular velocity of component (= der(phi))"
    annotation (Dialog(group="Initialization", showStartAttribute=true));
  SI.AngularAcceleration a
    "Absolute angular acceleration of component (= der(w))"
    annotation (Dialog(group="Initialization", showStartAttribute=true));

equation
  phi = flange_a.phi;
  phi = flange_b.phi;
  w = der(phi);
  a = der(w);
  J*a = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
Rotational component with <strong>inertia</strong> and two rigidly connected flanges.
</p>
</html>"),
       Icon(
  coordinateSystem(preserveAspectRatio=true,
    extent={{-100.0,-100.0},{100.0,100.0}}),
  graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-10.0},{-50.0,10.0}}),
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{50.0,-10.0},{100.0,10.0}}),
    Line(points={{-80.0,-25.0},{-60.0,-25.0}}),
    Line(points={{60.0,-25.0},{80.0,-25.0}}),
    Line(points={{-70.0,-25.0},{-70.0,-70.0}}),
    Line(points={{70.0,-25.0},{70.0,-70.0}}),
    Line(points={{-80.0,25.0},{-60.0,25.0}}),
    Line(points={{60.0,25.0},{80.0,25.0}}),
    Line(points={{-70.0,45.0},{-70.0,25.0}}),
    Line(points={{70.0,45.0},{70.0,25.0}}),
    Line(points={{-70.0,-70.0},{70.0,-70.0}}),
    Rectangle(lineColor={64,64,64},
      fillColor={255,255,255},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-50.0,-50.0},{50.0,50.0}},
      radius=10.0),
    Text(textColor={0,0,255},
      extent={{-150.0,60.0},{150.0,100.0}},
      textString="%name"),
    Text(extent={{-150.0,-120.0},{150.0,-80.0}},
      textString="J=%J"),
    Rectangle(
      lineColor = {64,64,64},
      fillColor = {255,255,255},
      extent = {{-50,-50},{50,50}},
      radius = 10)}));
end Inertia;

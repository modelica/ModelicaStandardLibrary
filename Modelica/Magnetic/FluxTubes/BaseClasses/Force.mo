within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model Force "Base class for flux tubes with reluctance force generation; constant permeability"

  extends Interfaces.TwoPort;

  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (Evaluate=true, HideResult=true);

  parameter SI.RelativePermeability mu_r(start=1)
    "Relative magnetic permeability";

  SI.Force F_m "Reluctance force";
  SI.Length s=flange.s - s_support
    "Distance between flange and support";

  SI.Reluctance R_m "Magnetic reluctance";
  SI.Permeance G_m "Magnetic permeance";
  SI.Permeability dGmBydx
    "Derivative of permeance with respect to armature position";
  parameter Integer dlBydx=1
    "Derivative of flux tube's varying dimension with respect to armature position; set to +1 or -1";

  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Generated reluctance force at armature position" annotation (Placement(
        transformation(extent={{-10,90},{10,110}})));
  Modelica.Mechanics.Translational.Interfaces.Support support(s=s_support,
      f=-flange.f) if useSupport "Support/housing of component" annotation (
     Placement(transformation(extent={{-10,-110},{10,-90}})));

protected
  SI.Length s_support "Absolute position of support flange";

equation
  V_m = Phi*R_m;
  R_m = 1/G_m;
  F_m = 0.5*V_m^2*dGmBydx;

  if not useSupport then
    s_support = 0;
  end if;
  flange.f = -F_m;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{30,30},{70,-30}},
        lineColor={255,128,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-70,0},{-90,0}}, color={255,128,0}),
      Line(points={{70,0},{90,0}}, color={255,128,0}),
      Text(
        extent={{-150,-80},{150,-40}},
        textString="%name",
        textColor={0,0,255}),
      Line(points={{-10,-100},{-30,-120}}),
      Line(points={{-30,-100},{-50,-120}}),
      Line(points={{-30,-100},{30,-100}}),
      Line(points={{10,-100},{-10,-120}}),
      Line(points={{30,-100},{10,-120}}),
      Rectangle(
        extent={{-70,30},{-30,-30}},
        lineColor={255,128,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-10,80},{10,-30}},
        fillColor={0,127,0},
        fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> for utilisation of this partial model.
</p>
</html>"));
end Force;

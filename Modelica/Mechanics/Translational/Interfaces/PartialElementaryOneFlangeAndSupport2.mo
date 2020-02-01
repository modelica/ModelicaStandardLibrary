within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryOneFlangeAndSupport2
  "Partial model for a component with one translational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models"
  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  SI.Length s
    "Distance between flange and support (= flange.s - support.s)";
  Flange_b flange "Flange of component" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Support support(s=s_support, f=-flange.f) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.Length s_support "Absolute position of support flange";
equation
  s = flange.s - s_support;
  if not useSupport then
    s_support = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with one flange and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),
      graphics={
        Line(
          visible=not useSupport,
          points={{-50,-120},{-30,-100}}, color={0,127,0}),
        Line(
          visible=not useSupport,
          points={{-30,-120},{-10,-100}}, color={0,127,0}),
        Line(
          visible=not useSupport,
          points={{-10,-120},{10,-100}}, color={0,127,0}),
        Line(
          visible=not useSupport,
          points={{10,-120},{30,-100}}, color={0,127,0}),
        Line(
          visible=not useSupport,
          points={{-30,-100},{30,-100}}, color={0,127,0})}));
end PartialElementaryOneFlangeAndSupport2;

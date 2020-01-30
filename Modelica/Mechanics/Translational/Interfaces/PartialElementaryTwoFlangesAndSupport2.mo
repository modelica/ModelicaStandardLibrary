within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryTwoFlangesAndSupport2
  "Partial model for a component with one translational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models"
  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  extends Translational.Interfaces.PartialTwoFlanges;
  Support support(s=s_support, f=-flange_a.f - flange_b.f) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  SI.Length s_a "Distance between left flange and support";
  SI.Length s_b "Distance between right flange and support";
protected
  SI.Length s_support "Absolute position of support flange";
equation
  s_a = flange_a.s - s_support;
  s_b = flange_b.s - s_support;
  if not useSupport then
    s_support = 0;
  end if;

  annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with two flanges and an additional support.
It is used e.g., to build up elementary ideal gear components. The component
contains the force balance, i.e., the sum of the forces of the connectors
is zero (therefore, components that are based on PartialGear cannot have
a mass). The support connector needs to be connected
to avoid the unphysical behavior that the
support force is required to be zero (= the default value, if the
connector is not connected).
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
end PartialElementaryTwoFlangesAndSupport2;

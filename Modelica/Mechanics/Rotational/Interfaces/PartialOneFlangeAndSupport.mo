within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialOneFlangeAndSupport
  "Partial model for a component with one rotational 1-dim. shaft flange and a support used for graphical modeling, i.e., the model is build up by drag-and-drop from elementary components"
  parameter Boolean useSupport=false
    "= true, if support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  Flange_b flange "Flange of shaft" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
  Support support if useSupport "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  Support internalSupport
    "Internal support/housing of component (either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
    annotation (Placement(transformation(extent={{-3,-83},{3,-77}})));
  Components.Fixed fixed if not useSupport
    "Fixed support/housing, if not useSupport"
    annotation (Placement(transformation(extent={{10,-94},{30,-74}})));
equation
  connect(support, internalSupport) annotation (Line(
      points={{0,-100},{0,-80}}));
  connect(internalSupport, fixed.flange) annotation (Line(
      points={{0,-80},{20,-80},{20,-84}}));
  annotation (
    Documentation(info="<html>
<p>
This is a 1-dim. rotational component with one flange and a support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-38,-98},{-6,-96}},
              textColor={95,95,95},
              textString="(if useSupport)"),Text(
              extent={{21,-95},{61,-96}},
              textColor={95,95,95},
              textString="(if not useSupport)")}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              visible=not useSupport,
              points={{-50,-120},{-30,-100}}),Line(
              visible=not useSupport,
              points={{-30,-120},{-10,-100}}),Line(
              visible=not useSupport,
              points={{-10,-120},{10,-100}}),Line(
              visible=not useSupport,
              points={{10,-120},{30,-100}}),Line(
              visible=not useSupport,
              points={{-30,-100},{30,-100}})}));
end PartialOneFlangeAndSupport;

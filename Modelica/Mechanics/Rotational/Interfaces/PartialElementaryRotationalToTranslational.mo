within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialElementaryRotationalToTranslational
  "Partial model to transform rotational into translational motion"
  parameter Boolean useSupportR=false
    "= true, if rotational support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter Boolean useSupportT=false
    "= true, if translational support flange enabled, otherwise implicitly grounded"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  Rotational.Interfaces.Flange_a flangeR "Flange of rotational shaft"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT
    "Flange of translational rod" annotation (Placement(transformation(
          extent={{90,10},{110,-10}})));
  Rotational.Interfaces.Support supportR if useSupportR
    "Rotational support/housing of component" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
  Translational.Interfaces.Support supportT if useSupportT
    "Translational support/housing of component"
    annotation (Placement(transformation(extent={{110,-110},{90,-90}})));

protected
  Rotational.Interfaces.InternalSupport internalSupportR(tau=-flangeR.tau)
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Translational.Interfaces.InternalSupport internalSupportT(f=-flangeT.f)
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Rotational.Components.Fixed fixedR if not useSupportR
    annotation (Placement(transformation(extent={{-90,-94},{-70,-74}})));
  Translational.Components.Fixed fixedT if not useSupportT
    annotation (Placement(transformation(extent={{70,-94},{90,-74}})));
equation
  connect(internalSupportR.flange, supportR) annotation (Line(
      points={{-100,-80},{-100,-100}}));
  connect(internalSupportR.flange, fixedR.flange) annotation (Line(
      points={{-100,-80},{-80,-80},{-80,-84}}));
  connect(fixedT.flange, internalSupportT.flange) annotation (Line(
      points={{80,-84},{80,-80},{100,-80}},
                                   color={0,127,0}));
  connect(internalSupportT.flange, supportT) annotation (Line(
      points={{100,-80},{100,-100}}, color={0,127,0}));
  annotation (Documentation(info="<html>

<p>
This is a 1-dim. rotational component with
</p>

<ul>
<li> one rotational flange,</li>
<li> one rotational support/housing,</li>
<li> one translational flange, and</li>
<li> one translational support/housing</li>
</ul>

<p>
This model is used to build up elementary components of a drive train
transforming rotational into translational motion with
equations in the text layer.
</p>

<p>
If <em>useSupportR=true</em>, the rotational support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupportR=false</em>, the rotational support connector is conditionally disabled
and instead the rotational part is internally fixed to ground.<br>
If <em>useSupportT=true</em>, the translational support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupportT=false</em>, the translational support connector is conditionally disabled
and instead the translational part is internally fixed to ground.
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          visible=not useSupportT,
          points={{85,-110},{95,-100}}, color={0,127,0}),
        Line(
          visible=not useSupportT,
          points={{95,-110},{105,-100}}, color={0,127,0}),
        Line(
          visible=not useSupportT,
          points={{105,-110},{115,-100}}, color={0,127,0}),
        Line(
          visible=not useSupportT,
          points={{85,-100},{115,-100}}, color={0,127,0}),
        Line(
          visible=not useSupportR,
          points={{-115,-110},{-105,-100}}),
        Line(
          visible=not useSupportR,
          points={{-105,-110},{-95,-100}}),
        Line(
          visible=not useSupportR,
          points={{-95,-110},{-85,-100}}),
        Line(
          visible=not useSupportR,
          points={{-115,-100},{-85,-100}})}));
end PartialElementaryRotationalToTranslational;

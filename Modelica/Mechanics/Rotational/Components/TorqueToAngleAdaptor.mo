within Modelica.Mechanics.Rotational.Components;
model TorqueToAngleAdaptor
  "Signal adaptor for a Rotational flange with angle, speed, and acceleration as outputs and torque as input (especially useful for FMUs)"
  parameter Boolean use_w=true
    "= true, enable the output connector w (angular velocity)" annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter Boolean use_a=true
    "= true, enable the output connector a (angular acceleration)"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
    "Flange moves with angle phi due to torque tau"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s") if use_w
    "Flange moves with speed w due to torque tau"
    annotation (Placement(transformation(extent={{20,40},{40,60}}), iconTransformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2") if use_a
    "Flange moves with angular acceleration a due to torque tau"
    annotation (Placement(transformation(extent={{20,10},{40,30}}), iconTransformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
    "Torque to drive the flange"
    annotation (Placement(transformation(extent={{60,-110},{20,-70}}), iconTransformation(extent={{40,-90},{20,-70}})));
protected
  Modelica.Blocks.Interfaces.RealInput w_internal(unit="rad/s")
    "Needed to connect to conditional connector w";
  Modelica.Blocks.Interfaces.RealInput a_internal(unit="rad/s2")
    "Needed to connect to conditional connector a";
equation
  connect(w, w_internal);
  connect(a, a_internal);
  phi = flange.phi;
  if use_w then
    w_internal = der(phi);
  else
    w_internal = 0.0;
  end if;
  if use_a then
    a_internal = der(w_internal);
  else
    a_internal = 0.0;
  end if;
  flange.tau = tau;

  annotation (defaultComponentName="torqueToAngleAdaptor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          radius=10),
        Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={95,95,95},
          radius=10,
          lineThickness=0.5),
        Text(
          extent={{-20,92},{20,70}},
          fillPattern=FillPattern.Solid,
          textString="phi"),
        Text(
          visible=use_w,
          extent={{-20,62},{20,40}},
          fillPattern=FillPattern.Solid,
          textString="w"),
        Text(
          visible=use_a,
          extent={{-20,32},{20,10}},
          fillPattern=FillPattern.Solid,
          textString="a"),
        Text(
          extent={{-20,-68},{20,-90}},
          fillPattern=FillPattern.Solid,
          textString="tau"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Rotational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>.
This adaptor has torque as input and angle, angular velocity and angular acceleration as output signals.
</p>
</html>"));
end TorqueToAngleAdaptor;

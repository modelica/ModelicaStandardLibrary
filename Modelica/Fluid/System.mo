within Modelica.Fluid;
model System
  "System properties and default values (ambient, flow direction, initialization)"

  package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for default start values"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure"
    annotation(Dialog(group="Environment"));
  parameter Modelica.SIunits.Temperature T_ambient=293.15
    "Default ambient temperature"
    annotation(Dialog(group="Environment"));
  parameter Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Constant gravity acceleration"
    annotation(Dialog(group="Environment"));

  // Assumptions
  parameter Boolean allowFlowReversal = true
    "= false to restrict to design flow direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Default formulation of energy balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=
    energyDynamics "Default formulation of mass balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Modelica.Fluid.Types.Dynamics substanceDynamics=
    massDynamics "Default formulation of substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Modelica.Fluid.Types.Dynamics traceDynamics=
    massDynamics "Default formulation of trace substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=
    Modelica.Fluid.Types.Dynamics.SteadyState
    "Default formulation of momentum balances, if options available"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

  // Initialization
  parameter Modelica.SIunits.MassFlowRate m_flow_start = 0
    "Default start value for mass flow rates"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.AbsolutePressure p_start = p_ambient
    "Default start value for pressures"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.Temperature T_start = T_ambient
    "Default start value for temperatures"
    annotation(Dialog(tab = "Initialization"));
  // Advanced
  parameter Modelica.SIunits.Pressure dp_nominal = 10000
    "Default nominal pressure loss"
    annotation(Dialog(group="Nominal operating point"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1
    "Default nominal mass flow rate"
    annotation(Dialog(group="Nominal operating point"));
  parameter Real eps_m_flow(min=0) = 1e-4
    "Regularization of zero flow for |m_flow| < eps_m_flow*m_flow_nominal"
    annotation(Dialog(tab = "Advanced", enable = not use_small));
  parameter Boolean use_small = false
    "= false to use new eps_m_flow and eps_dp"
    annotation(Dialog(tab = "Advanced", group="Obsolete"));
  parameter Modelica.SIunits.AbsolutePressure dp_small(min=0) = 1
    "Default small pressure drop for regularization of zero flow"
    annotation(Dialog(tab="Advanced", group="Obsolete", enable = use_small));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1e-2
    "Default small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced", group="Obsolete", enable = use_small));
equation
  assert(use_small == false, "Using obsolete system.m_flow_small and system.dp_small."
         + " Please update the model to new use_small = false",
         level=AssertionLevel.warning);

  annotation (
    defaultComponentName="system",
    defaultComponentPrefixes="inner",
    missingInnerMessage="
Your model is using an outer \"system\" component but
an inner \"system\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties.
",  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          textString="%name"),
        Line(points={{-86,-30},{82,-30}}, color={0,0,0}),
        Line(points={{-82,-68},{-52,-30}}, color={0,0,0}),
        Line(points={{-48,-68},{-18,-30}}, color={0,0,0}),
        Line(points={{-14,-68},{16,-30}}, color={0,0,0}),
        Line(points={{22,-68},{52,-30}}, color={0,0,0}),
        Line(points={{74,84},{74,14}}, color={0,0,0}),
        Polygon(
          points={{60,14},{88,14},{74,-18},{60,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{16,20},{60,-18}},
          lineColor={0,0,0},
          textString="g"),
        Text(
          extent={{-90,82},{74,50}},
          lineColor={0,0,0},
          textString="defaults"),
        Line(
          points={{-82,14},{-42,-20},{2,30}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-10,40},{12,18}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
 A system component is needed in each fluid model to provide system-wide settings, such as ambient conditions and overall modeling assumptions.
 The system settings are propagated to the fluid models using the inner/outer mechanism.
</p>
<p>
 A model should never directly use system parameters.
 Instead a local parameter should be declared, which uses the global setting as default.
 The only exception currently made is the gravity system.g.
</p>
</html>"));
end System;

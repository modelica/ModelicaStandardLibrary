within Modelica.Blocks.Interfaces.Adaptors;
partial model PotentialToFlowAdaptor "Signal adaptor for a connector with potential, 1st derivative of potential, and 2nd derivative of potential as inputs and
  flow, 1st derivative of flow, and 2nd derivative of flow as outputs (especially useful for FMUs)"
  parameter Boolean use_pder=true "Use input for 1st derivative of potential"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_pder2=true "Use input for 2nd derivative of potential (only if 1st derivative is used, too)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_fder=true "Use output for 1st derivative of flow"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_fder2=true "Use output for 2nd derivative of flow (only if 1st derivative is used, too)"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput p "Input for potential"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Interfaces.RealInput pder if use_pder
    "Optional input for der(potential)"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Interfaces.RealInput pder2 if (use_pder and use_pder2)
    "Optional input for der2(potential)"
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.RealOutput f "Output for flow"
    annotation (Placement(transformation(extent={{-20,-90},{-40,-70}})));
  Modelica.Blocks.Interfaces.RealOutput fder if use_fder
    "Optional output for der(flow)"
    annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
  Modelica.Blocks.Interfaces.RealOutput fder2 if (use_fder and use_fder2)
    "Optional output for der2(flow)"
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
protected
  parameter String Name_p="p" "Name of potential variable";
  parameter String Name_pder="der(p)" "Name of 1st derivative of potential variable";
  parameter String Name_pder2="der2(p)" "Name of 2nd derivative of potential variable";
  parameter String Name_f="f" "Name of flow variable";
  parameter String Name_fder="der(f)" "Name of 1st derivative of flow variable";
  parameter String Name_fder2="der2(f)" "Name of 2nd derivative of flow variable";
  Real y "output signal" annotation(HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput y1 "Optional 1st derivative of output" annotation(HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput y2 "Optional 2nd derivative of output" annotation(HideResult=true);
  Real u "input signal" annotation(HideResult=true);
  Modelica.Blocks.Interfaces.RealInput u1 "Optional 1st derivative of input" annotation (HideResult=true);
  Modelica.Blocks.Interfaces.RealInput u2 "Optional 2nd derivative of input" annotation (HideResult=true);
equation
  y = -f;
  y1 = if use_fder then -der(y) else 0;
  y2 = if (use_fder and use_fder2) then -der(y1) else 0;
  connect(y1, fder);
  connect(y2, fder2);
  if use_pder then
    connect(pder, u1);
  else
    u1 = 0;
  end if;
  if (use_pder and use_pder2) then
    connect(pder2, u2);
  else
    u2 = 0;
  end if;
  if (use_pder and use_pder2) then
    u = Functions.state2({p, u1, u2}, time);
  elseif (use_pder and not use_pder2) then
    u = Functions.state1({p, u1}, time);
  else
    u = p;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name"),
            Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={0,0,127},
              radius=10),
        Text(
          extent={{-18,90},{18,70}},
          textString="%Name_p"),
        Text(
          extent={{-18,60},{18,40}},
          textString="%Name_pder",
          visible=use_pder),
        Text(
          extent={{-18,30},{18,10}},
          textString="%Name_pder2",
          visible=(use_pder and use_pder2)),
        Text(
          extent={{-18,-70},{18,-90}},
          textString="%Name_f"),
        Text(
          extent={{-18,-40},{18,-60}},
          textString="%Name_fder",
          visible=use_fder),
        Text(
          extent={{-18,-10},{18,-30}},
          textString="%Name_fder2",
          visible=(use_fder and use_fder2))}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Adaptor between a physical connector and a signal representation of the connector signals.
This component is used to provide a pure signal interface around a physical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
<p>
This adaptor has potential, optional 1st derivative of potential, and optional 2nd derivative of potential as input and
flow, optional 1st derivative of flow, and optional 2nd derivative of flow as output signals.
</p>
<p>
Note, the input signals must be consistent to each other
(pder=der(p), pder2=der(pder)).
</p>
</html>"));
end PotentialToFlowAdaptor;

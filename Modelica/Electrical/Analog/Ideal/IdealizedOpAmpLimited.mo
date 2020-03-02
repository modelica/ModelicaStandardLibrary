within Modelica.Electrical.Analog.Ideal;
model IdealizedOpAmpLimited "Idealized operational amplifier with limitation"
  parameter Real V0=15000.0 "No-load amplification";
  parameter Boolean useSupply=false
    "Use supply pins (otherwise constant supply)" annotation (Evaluate=true);
  parameter SI.Voltage Vps=+15 "Positive supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter SI.Voltage Vns=-15 "Negative supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter Boolean strict=true "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  parameter Modelica.Blocks.Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy "Simplified model for homotopy-based initialization"
    annotation (Evaluate=true, Dialog(group="Initialization"));
  SI.Voltage vps "Positive supply voltage";
  SI.Voltage vns "Negative supply voltage";
  SI.Voltage v_in=in_p.v - in_n.v "Input voltage difference";
  SI.Voltage v_out=out.v "Output voltage to ground";
  SI.Power p_in=in_p.v*in_p.i + in_n.v*in_n.i "Input power";
  SI.Power p_out=out.v*out.i "Output power";
  SI.Power p_s=-(p_in + p_out) "Supply power";
  SI.Current i_s=p_s/(vps - vns) "Supply current";
  Modelica.Electrical.Analog.Interfaces.PositivePin in_p
    "Positive pin of the input port" annotation (Placement(transformation(
          extent={{-90,-70},{-110,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin in_n
    "Negative pin of the input port" annotation (Placement(transformation(
          extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin out
    "Pin of the output port" annotation (Placement(transformation(extent={{
            110,-10},{90,10}}), iconTransformation(extent={{110,-10},
            {90,10}})));
  //optional supply pins
  Modelica.Electrical.Analog.Interfaces.PositivePin s_p(final i=+i_s, final v=
       vps) if useSupply "Optional positive supply pin" annotation (Placement(
        transformation(extent={{10,90},{-10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin s_n(final i=-i_s, final v=
       vns) if useSupply "Optional negative supply pin" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.Voltage simplifiedExpr "Simplified expression for homotopy-based initialization";
equation
  if not useSupply then
    vps = Vps;
    vns = Vns;
  end if;
  in_p.i = 0;
  in_n.i = 0;
  simplifiedExpr = (if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.Linear then V0*v_in
                    else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.UpperLimit then vps
                    else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.LowerLimit then vns
                    else 0);
  if strict then
    if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
      v_out = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in));
    else
      v_out = homotopy(actual = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in)),
                       simplified=simplifiedExpr);
    end if;
  else
    if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
      v_out = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in);
    else
      v_out = homotopy(actual = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in),
                       simplified=simplifiedExpr);
    end if;
  end if;
  annotation (defaultComponentName="opAmp",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-100,60},{-70,60}}, color={0,0,255}),
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}),
        Line(points={{-60,50},{-40,50}}, color={0,0,255}),
        Line(points={{-50,-40},{-50,-60}}, color={0,0,255}),
        Line(points={{-60,-50},{-40,-50}}, color={0,0,255}),
        Line(points={{0,40},{0,100}}, color={0,0,255}, visible=useSupply),
        Line(points={{0,-100},{0,-40}}, color={0,0,255}, visible=useSupply)}),
    Documentation(info="<html>
<p>Idealized operational amplifier with saturation:</p>
<ul>
<li>Input currents are zero.</li>
<li>No-load amplification is high (but not infinite).</li>
<li>Output voltage is limited between positive and negative supply.</li>
</ul>
<p>Supply voltage is either defined by parameter Vps and Vns or by (optional) pins s_p and s_n.</p>
<p>In the first case the necessary power is drawn from an implicit internal supply, in the second case from the external supply.</p>
<p>If initialization is problematic for a model containing this as a component you can set the <strong>homotopyType</strong> parameter.
Using <strong>Linear</strong> ignores the saturation initially which simplifies the initialization, and may help if the component
is connected with negative feedback; but generally fails if the feedback is positive.
Using <strong>LowerLimit</strong> (or <strong>UpperLimit</strong>) gives a fixed value within the saturation bounds, which works with positive feedback.
However, it does not work if the intent is to initialize the input to give a specific output.
</p>
</html>"));
end IdealizedOpAmpLimited;

within Modelica.Electrical.Analog.Ideal;
model IdealizedOpAmpLimited "Idealized operational amplifier with limitation"
  parameter Real V0=15000.0 "No-load amplification";
  parameter Boolean useSupply=false
    "Use supply pins (otherwise constant supply)" annotation (Evaluate=true);
  parameter Modelica.Units.SI.Voltage Vps=+15 "Positive supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter Modelica.Units.SI.Voltage Vns=-15 "Negative supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter Boolean regularized=false "= true, if regularization instead of smoothed / strict"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  parameter Boolean smoothed=false "= true, if output is limited with smooth(0, ..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(enable=not regularized, tab="Advanced"));
  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(enable=not regularized, tab="Advanced"));
  parameter Modelica.Blocks.Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy "Simplified model for homotopy-based initialization"
    annotation (Evaluate=true, Dialog(group="Initialization"));
  Modelica.Units.SI.Voltage vps "Positive supply voltage";
  Modelica.Units.SI.Voltage vns "Negative supply voltage";
  Modelica.Units.SI.Voltage v_in(start=0)=in_p.v - in_n.v "Input voltage difference";
  Modelica.Units.SI.Voltage v_out=out.v "Output voltage to ground";
  Modelica.Units.SI.Current i_out(start=0)=-out.i "Output current";
  Modelica.Units.SI.Power p_in=in_p.v*in_p.i + in_n.v*in_n.i "Input power";
  Modelica.Units.SI.Power p_out=out.v*out.i "Output power";
  Modelica.Units.SI.Power p_s=-(p_in + p_out) "Supply power";
  Modelica.Units.SI.Current i_s=p_s/(vps - vns) "Supply current";
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
  Modelica.Units.SI.Voltage simplifiedExpr
    "Simplified expression for homotopy-based initialization";
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
  if regularized then
    if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
      v_out = (if v_in>0 then vps else -vns)*(2/(1 + Modelica.Math.exp(-v_in/(0.01*(if v_in>0 then vps else -vns)/V0)))-1);
    else
      v_out = homotopy(actual = (if v_in>0 then vps else -vns)*(2/(1 + Modelica.Math.exp(-v_in/(0.01*(if v_in>0 then vps else -vns)/V0)))-1), simplified=simplifiedExpr);
    end if;
  else
    if smoothed then
      if strict then
        if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
          v_out = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in));
        else
          v_out = homotopy(actual = smooth(0, noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in)), simplified=simplifiedExpr);
        end if;
      else
        if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
          v_out = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in);
        else
          v_out = homotopy(actual = smooth(0, if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in), simplified=simplifiedExpr);
        end if;
      end if;
    else
      if strict then
        if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
          v_out = noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in);
        else
          v_out = homotopy(actual = noEvent(if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in), simplified=simplifiedExpr);
        end if;
      else
        if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
          v_out = (if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in);
        else
          v_out = homotopy(actual = (if V0*v_in>vps then vps else if V0*v_in<vns then vns else V0*v_in), simplified=simplifiedExpr);
        end if;
      end if;
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
<p>You may choose between different implementations for calculating output voltage from input voltage:</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th>regularized</th><th>smoothed</th><th>strict  </th>
    <th>explanation</th>
  </tr>
  <tr>
    <td>true       </td><td>        </td><td>        </td>
    <td>uses a regularization formula which is nearly linear around 0 and saturates at positive resp. negative supply</td>
  </tr>
  <tr>
    <td>false      </td><td>false   </td><td>false   </td>
    <td>uses a linear relationship and saturates at positive resp. negative supply without using smooth and/or noEvent</td>
  </tr>
  <tr>
    <td>false      </td><td>true    </td><td>false   </td>
    <td>uses a linear relationship and saturates at positive resp. negative supply using smooth but without noEvent</td>
  </tr>
  <tr>
    <td>false      </td><td>false   </td><td>true    </td>
    <td>uses a linear relationship and saturates at positive resp. negative supply without using smooth but using noEvent</td>
  </tr>
  <tr>
    <td>false      </td><td>true    </td><td>true    </td>
    <td>uses a linear relationship and saturates at positive resp. negative supply using both smooth and noEvent</td>
  </tr>
</table>
<p>
Recommendation:<br>
Use of the opAmp in the linear range: regularized = false, smoothed = false, strict = false.<br>
Use of the opAmp as switching device: regularized = true,  smoothed = false, strict = false. 
</p>
<p>If initialization is problematic for a model containing this as a component you can set the <strong>homotopyType</strong> parameter.
Using <strong>Linear</strong> ignores the saturation initially which simplifies the initialization, and may help if the component
is connected with negative feedback; but generally fails if the feedback is positive.
Using <strong>LowerLimit</strong> (or <strong>UpperLimit</strong>) gives a fixed value within the saturation bounds, which works with positive feedback.
However, it does not work if the intent is to initialize the input to give a specific output.
</p>
</html>"));
end IdealizedOpAmpLimited;

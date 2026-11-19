within Modelica.Electrical.Analog.Ideal;
model OpAmpLimited "Operational amplifier with limitation and optional slew rate"
  import Modelica.Constants.pi;
  parameter Real V0=15000.0 "No-load amplification";
  parameter Boolean useSupply=false
    "Use supply pins (otherwise constant supply)" annotation (Evaluate=true);
  parameter SI.Voltage Vps=+15 "Positive supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter SI.Voltage Vns=-15 "Negative supply voltage"
    annotation (Dialog(enable=not useSupply));
  parameter Boolean enableOutputRise=false "Enable dynamic rise of output voltage"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Frequency G_BW=0.15E6 "Gain-bandwidth-product"
    annotation (Dialog(tab="Advanced", enable=enableOutputRise));
  parameter Modelica.Units.SI.Frequency fc=G_BW/V0
    "Cut-off frequency (open loop)"
    annotation (Dialog(tab="Advanced", enable=enableOutputRise));
  parameter Modelica.Units.SI.Time Tau=1/(2*pi*fc)
    "Time constant of firstOrder rise"
    annotation (Dialog(tab="Advanced", enable=enableOutputRise));
  parameter Modelica.Units.SI.VoltageSlope slewRate=0.1E6 "Slew rate"
    annotation (Dialog(tab="Advanced", enable=enableOutputRise));
  parameter Modelica.Electrical.Analog.Types.InitOpAmp initOpAmp=Modelica.Electrical.Analog.Types.InitOpAmp.Linear
    "Initialization of firstOrder rise of output voltage"
    annotation (Evaluate=true, Dialog(tab="Advanced", enable=enableOutputRise));
  //Indicate saturation and provide events without being involved in limitation
  Boolean slewLim=abs(dv)>=slewRate "Saturation of voltage rise";
  Boolean satPos=v_int>=vps "Positive Saturation";
  Boolean satNeg=v_int<=vns "Negative Saturation";
  SI.Voltage vps "Positive supply voltage";
  SI.Voltage vns "Negative supply voltage";
  SI.Voltage v_in(start=0)=in_p.v - in_n.v "Input voltage difference";
  SI.Voltage v_int "Intermediate voltage";
  Modelica.Units.SI.VoltageSlope dv "Unclamped voltage rise";
  Modelica.Units.SI.VoltageSlope dv_slew "Voltage rise clamped to slewRate";
  SI.Voltage v_out=out.v "Output voltage to ground";
  SI.Current i_out(start=0)=out.i "Output current into OpAmp";
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
  Modelica.Electrical.Analog.Interfaces.PositivePin s_p(final i=+i_s, final v=vps)
    if useSupply "Optional positive supply pin" annotation (Placement(
        transformation(extent={{10,90},{-10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin s_n(final i=-i_s, final v=vns)
    if useSupply "Optional negative supply pin" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}})));
initial equation
  if enableOutputRise then
    if initOpAmp == Modelica.Electrical.Analog.Types.InitOpAmp.UpperLimit then
      v_int=vps;
    elseif initOpAmp == Modelica.Electrical.Analog.Types.InitOpAmp.LowerLimit then
      v_int=vns;
    else
      v_int=min(vps, max(vns, V0*v_in));
    end if;
  end if;
equation
  if not useSupply then
    vps = Vps;
    vns = Vns;
  end if;
  assert(vps > vns, "OpAmp supply voltages are not consistent.");
  //input currents
  in_p.i = 0;
  in_n.i = 0;
  //either dynamic output rise or simple gain
  if enableOutputRise then
    dv = (V0*v_in - v_int)/Tau;
    //limit slew rate
    dv_slew = smooth(0, min(slewRate, max(-slewRate, dv)));
    //first order with anti-windup (stop integrator)
    der(v_int)= if (satPos and dv_slew>0) or (satNeg and dv_slew<0) then 0
      else dv_slew;
  else
    dv = 0;
    dv_slew = 0;
    v_int = V0*v_in;
  end if;
  //saturation of output: satPos and satNeg trigger events
  v_out = smooth(0, min(vps, max(vns, v_int)));
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
<p>Operational amplifier with saturation:</p>
<ul>
<li>Input currents are zero.</li>
<li>No-load amplification is high (but not infinite).</li>
<li>Output voltage is limited between positive and negative supply.</li>
<li>Transient rise of the output voltage can be enabled and limited to given slew rate.</li>
</ul>
<p>Supply voltage is either defined by parameter <code>Vps</code> and <code>Vns</code> or by (optional) pins <code>s_p</code> and <code>s_n</code>.<br>
In the first case the necessary power is drawn from an implicit internal supply, in the second case from the external supply.</p>
<p>
For most applications it is sufficient to use default settings <code>enableOutputRise=false</code> (default on the Advanced-tab).
In this case the intermediate voltage <code>v_int</code> is simply <code>V0*v_in</code>.<br>
In some applications it might be necessary to set <code>enableOutputRise=true</code> 
to let the intermediate voltage <code>v_int</code> rise according to a firstOrder with time constant <code>T</code> and limited slew rate.<br>
The integration of <code>v_int</code> is stopped if either the positive supply voltage is reached and the voltage would continue to rise or 
the negative supply voltage is reached and the voltage would continue to fall to avoid the windup-effect.
</p>
<p>
If this intermediate voltage <code>v_int</code> gets higher than positive supply, Boolean <code>satPos</code> indicates positive saturation.<br>
If this intermediate voltage <code>v_int</code> gets lower  than negative supply, Boolean <code>satNeg</code> indicates negative saturation.<br>
Intermediate voltage <code>v_int</code> is limited between positive supply and negative supply to achieve output voltage <code>v_out</code> without further events.
</p>
<h4>Relationship between the parameters (which could be taken from manufacturer's datasheet):</h4>
<table>
<tr><td>Open-loop amplification       </td><td><code>V0</code></td></tr>
<tr><td>Gain-bandwidth product        </td><td><code>G_BW</code></td></tr>
<tr><td>Cut-off frequency (open loop) </td><td><code>fc = G_BW/V0</code></td></tr>
<tr><td>Time constant of voltage rise </td><td><code>T = 1/(2*&pi;*fc)</code></td></tr>
<tr><td>Slew rate                     </td><td><code>slewRate</code></td></tr>
</table>
<h4>Initialization</h4>
<p>
<code>v_in.start</code> and <code>i_out.start</code> are just helpful starting values during initialization,
it is unlikely that it is necessary to change the start values and / or to declare them as fixed.
</p>
<p>
If it is necessary to use <code>enableOutputRise=true</code>, it is essential to initialize intermediate voltage <code>v_int</code> correctly.<br>
As a default, default initialization (<strong>Linear</strong>) is sufficient: <code>v_int = V0*v_in</code>.<br>
However, in some cases the initialization has more than one solution and it is desired to set
<code>v_int</code> at the positive supply (<strong>UpperLimit</strong>) or
<code>v_int</code> at the negative supply (<strong>LowerLimit</strong>).
</p>
</html>"));
end OpAmpLimited;

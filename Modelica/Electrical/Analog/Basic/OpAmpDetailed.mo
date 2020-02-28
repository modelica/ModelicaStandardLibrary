within Modelica.Electrical.Analog.Basic;
model OpAmpDetailed "Detailed model of an operational amplifier"
  // literature: Conelly, J.A.; Choi, P.: Macromodelling with SPICE. Englewood Cliffs: Prentice-Hall, 1992
  import Modelica.Constants.pi;
  parameter SI.Resistance Rdm=2.0e6
    "Input resistance (differential input mode)";
  parameter SI.Resistance Rcm=2.0e9 "Input resistance (common mode)";
  parameter SI.Capacitance Cin=1.4e-12 "Input capacitance";
  parameter SI.Voltage Vos=1.0e-3 "Input offset voltage";
  parameter SI.Current Ib=80.0e-9 "Input bias current";
  parameter SI.Current Ios=20.0e-9 "Input offset current";
  parameter SI.Voltage vcp=0.0 "Correction value for limiting by p_supply";
  parameter SI.Voltage vcm=0.0 "Correction value for limiting by msupply";
  parameter Real Avd0=106.0 "Differential amplifier [dB]";
  parameter Real CMRR=90.0 "Common-mode rejection [dB]";
  parameter SI.Frequency fp1=5.0 "Dominant pole";
  parameter SI.Frequency fp2=2.0e6 "Pole frequency";
  parameter SI.Frequency fp3=20.0e6 "Pole frequency";
  parameter SI.Frequency fp4=100.0e6 "Pole frequency";
  parameter SI.Frequency fz=5.0e6 "Zero frequency";
  parameter SI.VoltageSlope sr_p=0.5e6 "Slew rate for increase";
  parameter SI.VoltageSlope sr_m=0.5e6 "Slew rate for decrease";
  parameter SI.Resistance Rout=75.0 "Output resistance";
  parameter SI.Current Imaxso=25.0e-3
    "Maximal output current (source current)";
  parameter SI.Current Imaxsi=25.0e-3 "Maximal output current (sink current)";

  // number of intervals: 2500, stop time: 0.003
  parameter SI.Time Ts=0.0000012 "Sampling time";

  // power supply
  final parameter SI.Voltage vcp_abs=abs(vcp)
    "Positive correction value for limiting by p_supply";
  final parameter SI.Voltage vcm_abs=abs(vcm)
    "Positive correction value for limiting by msupply";

  // input stage
  //  Ib = 0.5*(I1 + I2);
  //  Ios = I1 - I2;
  final parameter SI.Current I1=Ib + Ios/2.0 "Current of internal source I1";
  final parameter SI.Current I2=Ib - Ios/2.0 "Current of internal source I2";

  // gain stage (difference and common mode)
  final parameter Real Avd0_val=10.0^(Avd0/20.0) "Differential mode gain";
  final parameter Real Avcm_val=(Avd0_val/(10.0^(CMRR/20.0)))/2.0
    "Common mode gain";

  // slew rate stage
  final parameter SI.VoltageSlope sr_p_val=abs(sr_p)
    "Value of slew rate for increase";
  final parameter SI.VoltageSlope sr_m_val=-abs(sr_m)
    "Negative value of slew rate for increase";

  // output stage
  final parameter SI.Current Imaxso_val=abs(Imaxso) "Orientation out outp";
  final parameter SI.Current Imaxsi_val=abs(Imaxsi) "Orientation into outp";

  Modelica.Electrical.Analog.Interfaces.PositivePin p
    "Positive pin of the input port" annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin m
    "Negative pin of the input port" annotation (Placement(transformation(
          extent={{-90,50},{-110,70}}), iconTransformation(extent={{-90,50},{-110,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin outp "Output pin"
    annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_supply
    "Positive output voltage limitation" annotation (Placement(transformation(
          extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin m_supply
    "Negative output voltage limitation" annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));

  // power supply
  SI.Voltage v_pos;
  SI.Voltage v_neg;

  // input stage
  SI.Voltage v_vos;
  SI.Voltage v_3;
  SI.Voltage v_in;
  SI.Voltage v_4;

  SI.Current i_vos;
  SI.Current i_3;
  SI.Current i_r2;
  SI.Current i_c3;
  SI.Current i_4;

  // frequency response
  Real q_fr1;
  Real q_fr2;
  Real q_fr3;

  // gain stage
  SI.Voltage q_sum;
  SI.Voltage q_sum_help;
  SI.Voltage q_fp1;

  // slew rate stage
  SI.Voltage v_source;

  SI.Voltage x "Auxiliary variable for slew rate";

  // output stage
  SI.Voltage v_out;

  SI.Current i_out;

  // functions
  function FCNiout_limit "Internal limitation function"
    extends Modelica.Icons.Function;
    input SI.Voltage v_source;
    input SI.Voltage v_out;
    input SI.Resistance Rout;
    input SI.Current Imaxsi_val;
    input SI.Current Imaxso_val;
    output SI.Current result;

  algorithm
    if v_out > v_source + Rout*Imaxsi_val then
      result := Imaxsi_val;
    elseif v_out < v_source - Rout*Imaxso_val then
      result := -Imaxso_val;
    else
      result := (v_out - v_source)/Rout;
    end if;
    return;
    annotation (Documentation(info="<html>
<p>Internal limitation function, designed for OpAmpDetailed, not for purpose of external usage.</p>
</html>"));
  end FCNiout_limit;

  function FCNq_sum_limit "Internal limitation function"
    extends Modelica.Icons.Function;
    input SI.Voltage q_sum;
    input SI.Voltage q_sum_ltf;
    input SI.Voltage v_pos;
    input SI.Voltage v_neg;
    input SI.Voltage vcp;
    input SI.Voltage vcm;
    output SI.Voltage result;

  algorithm
    if q_sum > v_pos - vcp and q_sum_ltf >= v_pos - vcp then
      result := v_pos - vcp;
    elseif q_sum < v_neg + vcm and q_sum_ltf <= v_neg + vcm then
      result := v_neg + vcm;
    else
      result := q_sum;
    end if;
    return;
    annotation (Documentation(info="<html>
<p>Internal limitation function, designed for OpAmpDetailed, not for purpose of external usage.</p>
</html>"));
  end FCNq_sum_limit;

initial equation
  v_source = q_fp1;
  x = 0;
equation
  assert(Rout > 0.0, "Rout must be > 0.0.");

  // power supply
  v_pos = p_supply.v;
  v_neg = m_supply.v;

  // input stage
  p.i = i_vos;
  m.i = i_4 - i_r2 - i_c3;
  0 = i_3 + i_r2 + i_c3 - i_vos;
  p.v - m.v = v_vos + v_in;
  v_4 = m.v;
  v_3 = p.v - v_vos;
  v_vos = Vos;
  i_3 = I1 + v_3/Rcm;
  v_in = Rdm*i_r2;
  i_c3 = Cin*der(v_in);
  i_4 = I2 + v_4/Rcm;

  // frequency response
  // Laplace transformation
  der(q_fr1) = 2.0*pi*fp2*(v_in - q_fr1);
  q_fr2 + (1.0/(2.0*pi*fp3))*der(q_fr2) = q_fr1 + (1.0/(2.0*pi*fz))*der(q_fr1);
  der(q_fr3) = 2.0*pi*fp4*(q_fr2 - q_fr3);

  // gain stage
  // Laplace transformation
  q_sum = Avd0_val*q_fr3 + Avcm_val*(v_3 + v_4);
  q_sum_help = FCNq_sum_limit(
      q_sum,
      q_fp1,
      v_pos,
      v_neg,
      vcp_abs,
      vcm_abs);
  der(q_fp1) = 2.0*pi*fp1*(q_sum_help - q_fp1);

  // slew rate stage
  der(x) = (q_fp1 - v_source)/Ts;
  der(v_source) = smooth(0, noEvent(if der(x) > sr_p_val then sr_p_val else
    if der(x) < sr_m_val then sr_m_val else der(x)));

  // output stage
  v_out = outp.v;
  i_out = outp.i;
  i_out = FCNiout_limit(
      v_source,
      v_out,
      Rout,
      Imaxsi_val,
      Imaxso_val);

  p_supply.i = 0;
  m_supply.i = 0;

  annotation (defaultComponentName="opAmp",
    Documentation(info="<html>
<p>The OpAmpDetailed model is a general operational amplifier model. The emphasis is on separating each important data sheet parameter into a sub-circuit independent of the other parameters. The model is broken down into five functional stages <strong>input</strong>, <strong>frequency response</strong>, <strong>gain</strong>, <strong>slew rate</strong> and an <strong>output</strong> stage. Each stage contains data sheet parameters to be modeled. This partitioning and the modelling of the separate submodels are based on the description in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Conelly1992</a>].</p>
<p>Using [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Conelly1992</a>] Joachim Haase (Fraunhofer Institute for Integrated Circuits, Design Automation Division) transferred 2001 operational amplifier models into VHDL-AMS. Now one of these models, the model &quot;amp(macro)&quot; was transferred into Modelica.</p>
</html>",    revisions="<html>
<dl>
<dt><em>June 17, 2009</em></dt>
<dd>by Susann Wolf initially implemented</dd>
</dl>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{0,40},{0,110}}, color={0,0,255}),
        Line(points={{0,-40},{0,-90}}, color={0,0,255}),
        Line(points={{-90,60},{-70,60}}, color={0,0,255}),
        Line(points={{-90,-60},{-70,-60}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(points={{-58,50},{-38,50}}, color={0,0,255}),
        Line(points={{-60,-51},{-38,-51}}, color={0,0,255}),
        Line(points={{-49,-40},{-49,-61}}, color={0,0,255})}));
end OpAmpDetailed;

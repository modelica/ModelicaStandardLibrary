within Modelica.Electrical.Machines.Losses.InductionMachines;
model Core "Model of core losses"
  parameter Machines.Losses.CoreParameters coreParameters(m=3)
    "Core parameters";
  //for backwards compatibility present but unused
  final parameter Integer m=coreParameters.m "Number of phases" annotation(Evaluate=true);
  parameter Real turnsRatio(final min=Modelica.Constants.small)
    "Effective number of stator turns / effective number of rotor turns (if used as rotor core)";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  Machines.Interfaces.SpacePhasor spacePhasor annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  input SI.AngularVelocity w
    "Remagnetization angular velocity" annotation (Dialog(group="Losses"));
  SI.Conductance Gc "Variable core loss conductance";
protected
  SI.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)),
      coreParameters.wMin)) "Limited angular velocity";
equation
  if (coreParameters.PRef <= 0) then
    Gc = 0;
    spacePhasor.i_ = zeros(2);
  else
    Gc = coreParameters.GcRef;
    //  * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
    spacePhasor.i_ = Gc*spacePhasor.v_;
  end if;
  lossPower = 3/2*(+spacePhasor.v_[1]*spacePhasor.i_[1] + spacePhasor.v_[2]*spacePhasor.i_[2]);
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-70,0}}),
        Line(points={{-70,10},{70,10}}, color={0,0,255}),
        Line(points={{-70,-30},{70,-30}}, color={0,0,255}),
        Line(points={{-70,-10},{70,-10}}, color={0,0,255}),
        Line(
          points={{70,0},{80,0}},
          color={0,0,255}),
        Line(
          points={{80,20},{80,-20}},
          color={0,0,255}),
        Line(
          points={{90,14},{90,-14}},
          color={0,0,255}),
        Line(
          points={{100,8},{100,-8}},
          color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
Core losses can be separated into <strong>eddy current</strong> and <strong>hysteresis</strong> losses. The total core losses
can thus be expressed as
</p>
<blockquote><pre>
P = PRef * (ratioHysteresis * (wRef / w) + 1 - ratioHysteresis) * (V / VRef)^2
</pre></blockquote>
<p>
where <code>w</code> is the actual angular remagnetization velocity and <code>V</code> is the actual voltage.
The term <code>ratioHysteresis</code> is the ratio of the hysteresis losses with respect to the total core losses for the reference voltage and frequency.
</p>

<p>
In the current implementation hysteresis losses are <strong>not considered</strong> since complex numbers are not provided in Modelica.
Therefore, implicitly <code>ratioHysteresis = 0</code> is set. For the voltage and frequency range with respect to Fig.&nbsp;1,
the dependency of total core losses on the parameter <code>ratioHysteresis</code> is depicted in Fig.&nbsp;2.
The current implementation has thus the drawback over a model that considers <code>ratioHysteresis &gt; 0</code>:
</p>
<ul>
<li>underestimation of the losses in the constant field region (<code>w</code> &lt; <code>wRef</code>)</li>
<li>overestimation of the losses in the field weakening region (<code>w</code> &gt; <code>wRef</code>)</li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesVw.png\"
                alt=\"corelossesVw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 1: </strong>Voltage versus angular velocity</td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesPcw.png\"
                alt=\"corelossesPcw.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 2: </strong>Core losses versus angular velocity with parameter <code>ratioHysteresis</code></td>
  </tr>
</table>

<h4>Note</h4>
<p>In the current implementation it is assumed that <code>ratioHysteresis = 0</code>. This parameter cannot be changed due to compatibility reasons.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.CoreParameters\">Core loss parameters</a>
</p>

</html>"));
end Core;

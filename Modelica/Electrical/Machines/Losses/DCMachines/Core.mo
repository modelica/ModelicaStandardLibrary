within Modelica.Electrical.Machines.Losses.DCMachines;
model Core "Model of core losses"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Machines.Losses.CoreParameters coreParameters(m=1)
    "Armature core losses";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  input SI.AngularVelocity w
    "Remagnetization angular velocity" annotation (Dialog(group="Losses"));
  SI.Conductance Gc "Variable core loss conductance";
protected
  SI.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)),
      coreParameters.wMin)) "Limited angular velocity";
equation
  if (coreParameters.PRef <= 0) then
    Gc = 0;
    i = 0;
  else
    Gc = coreParameters.GcRef;
    // * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
    i = Gc*v;
  end if;
  lossPower = v*i;
  annotation (Icon(graphics={Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{70,0},{90,0}}),
          Line(points={{-90,0},{-70,0}}),Line(points={{-70,10},{70,10}},
          color={0,0,255}),Line(points={{-70,-30},{70,-30}}, color={0,0,255}),
          Line(points={{-70,-10},{70,-10}}, color={0,0,255}),Text(
                extent={{-150,90},{150,50}},
                textColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Core losses can be separated into <em>eddy current</em> and <em>hysteresis</em> losses. The total core losses
can thus be expressed as
</p>
<blockquote><pre>
p = PRef * (ratioHysteresis * (wRef / w) + 1 - ratioHysteresis) * (v / VRef)^2
</pre></blockquote>
<p>
where <code>w</code> is the actual angular velocity and <code>v</code> is the actual voltage. The term <code>ratioHysteresis</code> is the ratio
of the hysteresis losses with respect to the total core losses for reference inner voltage and reference angular velocity.
</p>

<p>
For the voltage and angular velocity range with respect to Fig.&nbsp;1,
the dependency of total core losses on the parameter <code>ratioHysteresis</code> is depicted in Fig.&nbsp;2.
</p>

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

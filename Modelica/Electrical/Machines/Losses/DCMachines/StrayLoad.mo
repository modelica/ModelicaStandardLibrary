within Modelica.Electrical.Machines.Losses.DCMachines;
model StrayLoad
  "Model of stray load losses dependent on current and speed"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Machines.Interfaces.FlangeSupport;
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters
    "Stray load loss parameters";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  v = 0;
  if (strayLoadParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -strayLoadParameters.tauRef*(i/strayLoadParameters.IRef)^2*
      sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (Icon(graphics={Line(points={{-90,0},{90,0}}, color={0,0,255}),
          Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                pattern=LinePattern.Dot),Text(
                extent={{-150,90},{150,50}},
                textColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
The stray load loss torque is
</p>
<blockquote><pre>
tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre></blockquote>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The dependency of the stray load torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<p>
The stray load losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
If it is desired to neglect stray load losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
end StrayLoad;

within Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses;
model StrayLoad "Model of stray load losses dependent on current and speed"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort;
  extends Modelica.Electrical.Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.QuasiStatic.Polyphase.Functions.quasiRMS;
  parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters
    strayLoadParameters "Stray load loss parameters";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  SI.Current iRMS=quasiRMS(i);
equation
  v = {Complex(0, 0) for k in 1:m};
  if (strayLoadParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -strayLoadParameters.tauRef*(iRMS/strayLoadParameters.IRef)^2*
      sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (defaultComponentName="strayLoss", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={85,170,255},
          pattern=LinePattern.Dot), Line(
          points={{-102,0},{100,0}},
          color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
Stray load losses are modeled similar to standards EN 60034-2 and IEEE 512, i.e., they are dependent on square of current,
but without scaling them to zero at no-load current.
</p>
<p>
For an estimation of dependency on varying angular velocity see:
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.References\">[Lang1984]</a>
</p>
<p>
The stray load losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
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
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
If it is desired to neglect stray load losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
end StrayLoad;

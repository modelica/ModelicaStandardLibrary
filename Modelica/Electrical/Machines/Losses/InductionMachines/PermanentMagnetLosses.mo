within Modelica.Electrical.Machines.Losses.InductionMachines;
model PermanentMagnetLosses
  "Model of permanent magnet losses dependent on current and speed"
  extends Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.Polyphase.Functions.quasiRMS;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters
    "Permanent magnet loss parameters";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  input SI.Current is[m] "Instantaneous stator currents";
  SI.Current iRMS=quasiRMS(is);
equation
  if (permanentMagnetLossParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -permanentMagnetLossParameters.tauRef*(permanentMagnetLossParameters.c + (1 - permanentMagnetLossParameters.c)*
      (iRMS/permanentMagnetLossParameters.IRef)^permanentMagnetLossParameters.power_I)*
      sign(w)*(abs(w)/permanentMagnetLossParameters.wRef)^permanentMagnetLossParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (defaultComponentName="magnetLoss",
    Icon(graphics={Ellipse(extent={{-40,-40},{40,40}},
          lineColor={200,0,0})}), Documentation(info="<html>
<p>
Permanent magnet losses are modeled dependent on current and speed.
</p>
<p>
The permanent magnet losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<p>
The permanent magnet loss torque is
</p>
<blockquote><pre>
tau = PRef/wRef * (c + (1 - c) * (i/IRef)^power_I) * (w/wRef)^power_w
</pre></blockquote>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The parameter <code>c</code> designates the part of the permanent magnet losses that are present even at current = 0, i.e. independent of current.
The dependency of the permanent magnet loss torque on the stator current is modeled by the exponent <code>power_I</code>.
The dependency of the permanent magnet loss torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters\">Permanent magnet loss parameters</a>
</p>
<p>
If it is desired to neglect permanent magnet losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
end PermanentMagnetLosses;

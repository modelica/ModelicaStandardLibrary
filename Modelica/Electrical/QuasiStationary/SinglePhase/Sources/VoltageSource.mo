within Modelica.Electrical.QuasiStationary.SinglePhase.Sources;
model VoltageSource "Constant AC voltage"
  extends QuasiStationary.SinglePhase.Interfaces.Source;
  parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
  parameter Modelica.SIunits.Voltage V(start=1) "RMS voltage of the source";
  parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
equation
  omega = 2*Modelica.Constants.pi*f;
  v = Complex(V*cos(phi), V*sin(phi));
  annotation (Icon(graphics={
        Text(
          extent={{-120,50},{-20,0}},
          lineColor={0,0,255},
          textString=
                  "+"),
        Text(
          extent={{20,50},{120,0}},
          lineColor={0,0,255},
          textString=
                  "-"),
        Line(points={{50,0},{-50,0}}, color={0,0,0})}),
      Documentation(info="<html>

<p>
This is a constant voltage source, specifying the complex voltage by the RMS voltage and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;

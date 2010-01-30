within Modelica.Electrical.QuasiStationary.SinglePhase.Sources;
model CurrentSource "Constant AC current"
  extends QuasiStationary.SinglePhase.Interfaces.Source;
  parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
  parameter Modelica.SIunits.Current I(start=1) "RMS current of the source";
  parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
equation
  omega = 2*Modelica.Constants.pi*f;
  i = Complex(I*cos(phi), I*sin(phi));
  annotation (Icon(graphics={
        Line(points={{0,-50},{0,50}}, color={0,0,0}),
        Line(points={{-60,60},{60,60}}, color={0,0,255}),
        Polygon(
          points={{60,60},{30,70},{30,50},{60,60}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
This is a constant current source, specifying the complex current by the RMS current and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end CurrentSource;

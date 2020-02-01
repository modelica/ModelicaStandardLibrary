within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model CurrentSource "Constant polyphase AC current"
  extends Interfaces.Source;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  parameter SI.Current I[m](start=fill(1, m))
    "RMS current of the source";
  parameter SI.Angle phi[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)
    "Phase shift of the source";
equation
  omega = 2*Modelica.Constants.pi*f;
  i = {I[k]*exp(j*phi[k]) for k in 1:m};
  annotation (
    Icon(graphics={Line(points={{0,50},{0,-50}}, color={85,170,255}),
          Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
This model describes <em>m</em> constant current sources, specifying the complex currents by the RMS currents and the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">single-phase CurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">SinglePhase.CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end CurrentSource;

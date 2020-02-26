within Modelica.Electrical.Analog.Interfaces;
partial model VoltageSource "Interface for voltage sources"
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
  extends OnePort;
  replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
      final offset = offset, final startTime=startTime) annotation (Placement(
        transformation(extent={{70,69},{91,89}})));
  parameter SI.Voltage offset=0 "Voltage offset";
  parameter SI.Time startTime=0 "Time offset";
equation
  v = signalSource.y;
  annotation (
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The VoltageSource partial model prepares voltage sources by providing the pins, and the offset and startTime parameters, which are the same at all voltage sources. The source behavior is taken from Modelica.Blocks signal sources by inheritance and usage of the replaceable possibilities.</p>
</html>"));
end VoltageSource;

within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
partial model PartialOpAmp
  "Partial circuit of operational amplifiers"
  extends Modelica.Electrical.Analog.Interfaces.FourPin;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter Real V0=15000.0 "No-load amplification";
  Ideal.IdealizedOpAmpLimited opAmp(
    V0=V0,
    final useSupply=false,
    final Vps=Vps,
    final Vns=Vns,
    out(i(start=0, fixed=false)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}), Polygon(
          points={{-60,70},{70,0},{-60,-72},{-60,70}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),    Documentation(info="<html>
<p>
Partial model for operational amplifier circuits, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.
Different functionality is achieved by different circuits.
</p>
</html>"));
end PartialOpAmp;

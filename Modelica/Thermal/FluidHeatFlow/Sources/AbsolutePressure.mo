within Modelica.Thermal.FluidHeatFlow.Sources;
model AbsolutePressure "Defines absolute pressure level"
  extends FluidHeatFlow.BaseClasses.SinglePortLeft(
    final Exchange=false,
    final T0=293.15,
    final T0fixed=false);
  parameter SI.Pressure p(start=0) "Pressure ground";
equation
  // defining pressure
  flowPort.p = p;
  // no no mass flow means no energy flow
  flowPort.H_flow = 0;
  annotation (
    Documentation(info="<html>
<p>AbsolutePressure to define pressure level of a closed cooling cycle.</p>
<p>Coolant's mass flow, temperature and enthalpy flow are not affected.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
    graphics={
       Ellipse(extent={{-90,90},{90,-90}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end AbsolutePressure;

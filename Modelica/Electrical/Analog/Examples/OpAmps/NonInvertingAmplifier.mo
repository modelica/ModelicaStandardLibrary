within Modelica.Electrical.Analog.Examples.OpAmps;
model NonInvertingAmplifier "Non-inverting amplifier"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
    V=2*Vin,
    rising=0.2/f,
    width=0.3/f,
    falling=0.2/f,
    period=1/f,
    nperiod=-1,
    offset=-Vin,
    startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.Buffer buffer(k=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.n, buffer.n1)
    annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
  connect(vIn.p, buffer.p1)
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(buffer.p2, vOut.p)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(buffer.n2, vOut.n)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  connect(buffer.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a non inverting amplifier.</p>
</html>",
      figures = {
        Figure(
          title = "Voltages",
          identifier = "e8928",
          preferred = true,
          plots = {
            Plot(
              curves = {
                Curve(y = vIn.v, legend = "Voltage from source vIn")
              }
            ),
            Plot(
              curves = {
                Curve(y = buffer.opAmp.v_out, legend = "Amplified voltage out from opAmp"),
                Curve(y = buffer.opAmp.Vns, legend = "Negative supply voltage in opAmp (negative limit voltage)"),
                Curve(y = buffer.opAmp.Vps, legend = "Positive supply voltage in opAmp (positive limit voltage)")
              }
            ),
            Plot(
              curves = {
                Curve(y = buffer.k, legend = "Desired amplification")
              }
            )
          }
        )
      }
    ),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end NonInvertingAmplifier;

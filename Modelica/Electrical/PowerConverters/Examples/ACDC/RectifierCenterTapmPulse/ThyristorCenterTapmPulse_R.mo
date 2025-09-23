within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse;
model ThyristorCenterTapmPulse_R
  "2*m pulse thyristor rectifier with center tap and resistive load"
  extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
        constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180
    "Firing angle";
  parameter SI.Resistance R=20 "Load resistance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Tolerance=1e-06,
      Interval=0.0002),
    Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>",
      figures = {
        Figure(
          title = "Voltage and current",
          identifier = "7ba5e",
          preferred = true,
          plots = {
            Plot(
              curves = {
                Curve(y = currentSensor.i, legend = "Measured current value"),
                Curve(y = meanCurrent.y, legend = "Mean value of current")
              }
            ),
            Plot(
              curves = {
                Curve(y = voltagesensor.v, legend = "Measured value of voltage"),
                Curve(y = meanVoltage.y, legend = "Mean value of voltage")
              }
            )
          }
        )
      }
    ));
end ThyristorCenterTapmPulse_R;

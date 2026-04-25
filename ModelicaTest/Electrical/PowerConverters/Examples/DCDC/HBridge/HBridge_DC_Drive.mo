within ModelicaTest.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_DC_Drive "H bridge DC/DC converter with DC drive"
  extends Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge.HBridge_DC_Drive;
  annotation (
    experiment(
      StopTime=4.10,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={4.00, 4.10}),
    Documentation(info="<html>
<p>This example of an H bridge with DC drive demonstrates the operation of the DC machine in four quadrants.
The DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th><strong>start time (s)</strong></th>
    <th><strong>machine speed</strong></th>
    <th><strong>machine torque</strong></th>
    <th><strong>mode</strong></th>
  </tr>
  <tr>
    <td>0</td> <td>zero</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>3</td> <td>positive</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>6</td> <td>positive</td> <td>positive</td> <td>motor</td>
  </tr>
  <tr>
    <td>9.5</td> <td>positive</td> <td>negative</td> <td>generator</td>
  </tr>
  <tr>
    <td>12.5</td> <td>negative</td> <td>negative</td> <td>motor</td>
  </tr>
  <tr>
    <td>15.5</td> <td>negative</td> <td>positive</td> <td>generator</td>
  </tr>
  <tr>
    <td>19</td> <td>negative</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>22</td> <td>zero</td> <td>zero</td> <td></td>
  </tr>
</table>

<p>
Plot machine current <code>dcpm.ia</code>, averaged current <code>meanCurrent.y</code>, machine speed <code>dcpm.wMechanical</code>, averaged machine speed <code>dcpm.va</code> and torque <code>dcpm.tauElectrical</code>.</p>
</html>"));
end HBridge_DC_Drive;

within Modelica.Magnetic.FluxTubes.Material.HysteresisTableData;
record BaseData "Hysteresis table data"

  extends Modelica.Icons.Record;

  parameter Real[:,:] tabris=[
    -10000000, -0.8000;
    -1000, -0.8000;
    -300, -0.8000;
    -200, -0.8000;
    -190, -0.8000;
    -180, -0.8000;
    -160, -0.7999;
    -150, -0.7998;
    -140, -0.7997;
    -130, -0.7996;
    -120, -0.7993;
    -110, -0.7989;
    -100, -0.7982;
    -90, -0.7971;
    -80, -0.7953;
    -70, -0.7924;
    -60, -0.7878;
    -50, -0.7802;
    -40, -0.7680;
    -30, -0.7486;
    -20, -0.7180;
    -10, -0.6708;
    0, -0.6000;
    10, -0.4983;
    20, -0.3611;
    30, -0.1908;
    40, 0.0000;
    50, 0.1908;
    60, 0.3611;
    70, 0.4983;
    80, 0.6000;
    90, 0.6708;
    100, 0.7180;
    110, 0.7486;
    120, 0.7680;
    130, 0.7802;
    140, 0.7878;
    150, 0.7924;
    160, 0.7953;
    170, 0.7971;
    180, 0.7982;
    190, 0.7989;
    200, 0.7993;
    300, 0.8000;
    1000, 0.8000;
    10000000, 0.8000]
    "Table data of the rising (lower) branch of the hysteresis envelope curve (H, B)";

  parameter Real[:,:] tabfal=[
    -10000000, -0.8000;
    -1000, -0.8000;
    -300, -0.8000;
    -200, -0.7993;
    -190, -0.7989;
    -180, -0.7982;
    -170, -0.7971;
    -160, -0.7953;
    -150, -0.7924;
    -140, -0.7878;
    -130, -0.7802;
    -120, -0.7680;
    -110, -0.7486;
    -100, -0.7180;
    -90, -0.6708;
    -80, -0.6000;
    -70, -0.4983;
    -60, -0.3611;
    -50, -0.1908;
    -40, 0.0000;
    -30, 0.1908;
    -20, 0.3611;
    -10, 0.4983;
    0, 0.6000;
    10, 0.6708;
    20, 0.7180;
    30, 0.7486;
    40, 0.7680;
    50, 0.7802;
    60, 0.7878;
    70, 0.7924;
    80, 0.7953;
    90, 0.7971;
    100, 0.7982;
    110, 0.7989;
    120, 0.7993;
    130, 0.7996;
    140, 0.7997;
    150, 0.7998;
    160, 0.7999;
    180, 0.8000;
    190, 0.8000;
    200, 0.8000;
    300, 0.8000;
    1000, 0.8000;
    10000000, 0.8000]
    "Table data of the falling (upper) branch of the hysteresis envelope curve (H, B)";
  parameter SI.Conductivity sigma = 1 "Electric conductivity";
  annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_BaseData.png\">
   </td>
  </tr>
</table>
</html>"));
end BaseData;

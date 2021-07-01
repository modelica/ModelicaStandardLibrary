within Modelica.Magnetic.FluxTubes.Material;
package HysteresisTableData
  extends Modelica.Icons.MaterialPropertiesPackage;

  annotation (Documentation(info="<html>
<p>
Material table data for the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a> flux tube element. The records contain two data tables <code>tabris</code> and <code>tabfal</code> describing the rising and the falling branch of the hysteresis envelope curve of the corresponding material. The first column is the magnetic field strength H and has to be strictly monotonically increasing. The second column contains the corresponding values of the magnetic fluxdensity B. Both curves may not intersect each other.
</p>

<p>
Fig. 1 and Fig. 2 show library entries based on own measurements of several steel sheet qualities in two different ranges of the magnetic field strength. For the measurements a 25 cm Epstein frame was used according to DIN EN 60404-2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 1:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 2:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops02.png\">
    </td>
  </tr>
</table>

<p>
Fig. 3 shows the static hysteresis loop library entries for soft magnetic cobalt-iron-alloys which were extracted from <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a>.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption><strong>Fig. 3:</strong> Soft magnetic cobalt iron library entries <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a></caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops03.png\">
    </td>
  </tr>
</table>

</html>"));
end HysteresisTableData;

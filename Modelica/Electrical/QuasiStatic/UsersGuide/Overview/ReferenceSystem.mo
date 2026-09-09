within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class ReferenceSystem "Reference system"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
The reference angle <code>gamma</code>:
</p>
<ul>
  <li>defines the angular frequency <code>omega</code> of the voltages and currents
      of a circuit by means of <code>omega = der(gamma)</code>.</li>
  <li>is not a global quantity since it propagated through the connector.
      Therefore, independent circuits of different frequencies can be modeled in one model.</li>
  <li>is present only once in a polyphase connector;
      a polyphase component has only one reference angle common to all phases.</li>
  <li>can be either constant or variable, but it has to be consistent in one contiguous circuit.</li>
  <li>is defined by the sources.</li>
</ul>
<p>
Designing new components, the guidelines of <a href=\"https://specification.modelica.org/maint/3.6/connectors-and-connections.html#connection-graphs-and-their-operators\">Section&nbsp;9.4.1 <em>Connection Graphs and Their Operators</em> of the Modelica&nbsp;3.6 specification</a> have to be taken into account.
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          Power</a>

</html>"));
end ReferenceSystem;

within Modelica.Electrical;
package Polyphase "Library for electrical components of one or more phases"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.1 2006/01/12 Anton Haumer<br>
      added Sensors.PowerSensor</li>
  <li>v1.2 2006/07/05 Anton Haumer<br>
      removed annotation from pin of Interfaces.Plug<br>
      corrected usage of resistance/conductance</li>
  <li>v1.3.0 2007/01/23 Anton Haumer<br>
      improved some icons</li>
  <li>v1.3.1 2007/08/12 Anton Haumer<br>
      improved documentation</li>
  <li>v1.3.2 2007/08/24 Anton Haumer<br>
      removed redeclare type SignalType</li>
  <li>v1.4.0 2009/08/26 Anton Haumer<br>
      added conditional HeatPorts as Electrical.Analog<br>
      added switches with arc as Electrical.Analog</li>
  </ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          origin={14,56},
          lineColor={95,95,95},
          extent={{-84,-126},{56,14}}),
        Ellipse(
          origin={0,42},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-40,-34},{-20,-14}}),
        Ellipse(
          origin={20,40},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{0,-34},{20,-14}}),
        Ellipse(
          origin={10,34},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-20,-74},{0,-54}})}));
end Polyphase;

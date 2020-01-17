within Modelica;
package ComplexBlocks "Library of basic input/output control blocks with Complex signals"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>This library hosts blocks using Complex inputs and outputs.</p>
<p>It depends on the implementation of Complex.</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
          preserveAspectRatio=true), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(origin={-51.25,0.0}, points={{21.25,-35.0},{-13.75,-35.0},{-13.75,
              35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(origin={51.25,0.0}, points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},
              {-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
end ComplexBlocks;

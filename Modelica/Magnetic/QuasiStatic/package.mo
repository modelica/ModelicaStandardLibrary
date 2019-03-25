within Modelica.Magnetic;
package QuasiStatic "Quasi static magnetic package"
extends Icons.Package;

annotation (Documentation(info="<html>
<p>
This package contains quasi static magnetic libraries
</p>
</html>"), Icon(graphics={ Line(
        origin={10,20},
        points={{-90,-20},{-78.7,14.2},{-71.5,33.1},{-65.1,46.4},{-59.4,54.6},{
            -53.8,59.1},{-48.2,59.8},{-42.6,56.6},{-36.9,49.7},{-31.3,39.4},{-24.9,
            24.1},{-16.83,1.2},{0.1,-50.8},{7.3,-70.2},{13.7,-84.2},{19.3,-93.1},
            {25,-98.4},{30.6,-100},{36.2,-97.6},{41.9,-91.5},{47.5,-81.9},{53.9,
            -67.2},{62,-44.8},{70,-20}},
        smooth=Smooth.Bezier),
      Rectangle(
        extent={{-20,30},{20,-30}},
        lineColor={255,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid,
        origin={-30,0},
        rotation=90),
      Rectangle(
        extent={{-20,30},{20,-30}},
        lineColor={0,140,72},
        fillColor={0,140,72},
        fillPattern=FillPattern.Solid,
        origin={30,0},
        rotation=90)}));
end QuasiStatic;

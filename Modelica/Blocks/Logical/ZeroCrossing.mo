within Modelica.Blocks.Logical;
block ZeroCrossing "Trigger zero crossing of input u"
  extends Blocks.Interfaces.partialBooleanSO;
  Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
            {-140,-20},{-100,20}})));
  Blocks.Interfaces.BooleanInput enable
    "Zero input crossing is triggered if the enable input signal is true"
    annotation (Placement(transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));

protected
  Boolean disable=not enable;
  Boolean u_pos;
initial equation
  pre(u_pos) = false;
  pre(enable) = false;
  pre(disable) = not pre(enable);
equation
  u_pos = enable and u >= 0;
  y = change(u_pos) and not edge(enable) and not edge(disable);
  annotation (Documentation(info="<html>
<p>
The output \"y\" is <strong>true</strong> at the
time instant when the input \"u\" becomes
zero, provided the input \"enable\" is
<strong>true</strong>. At all other time instants, the output \"y\" is <strong>false</strong>.
If the input \"u\" is zero at a time instant when the \"enable\"
input changes its value, then the output y is <strong>false</strong>.
</p>
<p>
Note, that in the plot window of a Modelica simulator, the output of
this block is usually identically to <strong>false</strong>, because the output
may only be <strong>true</strong> at an event instant, but not during
continuous integration. In order to check that this component is
actually working as expected, one should connect its output to, e.g.,
component <em><a href=\"modelica://Modelica.Blocks.Discrete.TriggeredSampler\">Modelica.Blocks.Discrete.TriggeredSampler</a></em>.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{-78,68},{-78,-80}}, color={192,192,192}),
        Polygon(
          points={{-78,90},{-86,68},{-70,68},{-78,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-88,0},{70,0}}, color={192,192,192}),
        Line(points={{-78,0},{-73.2,32.3},{-70,50.3},{-66.7,64.5},{-63.5,74.2},
              {-60.3,79.3},{-57.1,79.6},{-53.9,75.3},{-50.7,67.1},{-46.6,52.2},
              {-41,25.8},{-33,-13.9},{-28.2,-33.7},{-24.1,-45.9},{-20.1,-53.2},
              {-16.1,-55.3},{-12.1,-52.5},{-8.1,-45.3},{-3.23,-32.1},{10.44,
              13.7},{15.3,26.4},{20.1,34.8},{24.1,38},{28.9,37.2},{33.8,31.8},
              {40.2,19.4},{53.1,-10.5},{59.5,-21.2},{65.1,-25.9},{70.7,-25.9},
              {77.2,-20.5},{82,-13.8}}, color={192,192,192}, smooth = Smooth.Bezier),
        Polygon(
          points={{92,0},{70,8},{70,-8},{92,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-36,-59},{-36,81}}, color={255,0,255}),
        Line(points={{6,-59},{6,81}}, color={255,0,255}),
        Line(points={{49,-59},{49,81}}, color={255,0,255}),
        Line(points={{-78,0},{70,0}}, color={255,0,255})}));
end ZeroCrossing;

within Modelica.Thermal.HeatTransfer.Components;
model HeatCapacitor "Lumped thermal element storing heat"
  parameter SI.HeatCapacity C
    "Heat capacity of element (= cp*m)";
  SI.Temperature T(start=293.15, displayUnit="degC")
    "Temperature of element";
  SI.TemperatureSlope der_T(start=0)
    "Time derivative of temperature (= der(T))";
  Interfaces.HeatPort_a port annotation (Placement(transformation(
        origin={0,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  T = port.T;
  der_T = der(T);
  C*der(T) = port.Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,
              13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},
              {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,
              -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
              70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,
              33},{44,41},{36,57},{26,65},{0,67}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
              -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,
              -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,
              -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,
              -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},
              {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,
              27},{-48,35},{-44,45},{-40,57},{-58,35}},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-69,7},{71,-24}},
          textString="%C")}),
    Documentation(info="<html>
<p>
This is a generic model for the heat capacity of a material.
No specific geometry is assumed beyond a total volume with
uniform temperature for the entire volume.
Furthermore, it is assumed that the heat capacity
is constant (independent of temperature).
</p>
<p>
The temperature T [Kelvin] of this component is a <strong>state</strong>.
A default of T = 25 degree Celsius (= Modelica.Units.Conversions.from_degC(25))
is used as start value for initialization.
This usually means that at start of integration the temperature of this
component is 25 degrees Celsius. You may, of course, define a different
temperature as start value for initialization. Alternatively, it is possible
to set parameter <strong>steadyStateStart</strong> to <strong>true</strong>. In this case
the additional equation '<strong>der</strong>(T) = 0' is used during
initialization, i.e., the temperature T is computed in such a way that
the component starts in <strong>steady state</strong>. This is useful in cases,
where one would like to start simulation in a suitable operating
point without being forced to integrate for a long time to arrive
at this point.
</p>
<p>
Note, that parameter <strong>steadyStateStart</strong> is not available in
the parameter menu of the simulation window, because its value
is utilized during translation to generate quite different
equations depending on its setting. Therefore, the value of this
parameter can only be changed before translating the model.
</p>
<p>
This component may be used for complicated geometries where
the heat capacity C is determined my measurements. If the component
consists mainly of one type of material, the <strong>mass m</strong> of the
component may be measured or calculated and multiplied with the
<strong>specific heat capacity cp</strong> of the component material to
compute C:
</p>
<blockquote><pre>
C = cp*m.
Typical values for cp at 20 degC in J/(kg.K):
   aluminium   896
   concrete    840
   copper      383
   iron        452
   silver      235
   steel       420 ... 500 (V2A)
   wood       2500
</pre></blockquote>
</html>"));
end HeatCapacitor;

within Modelica.Mechanics.Rotational.Components;
model FreeWheel "Ideal freewheel"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
  SI.AngularVelocity w_rel(start=0) "Relative angular velocity (= flange_a.w - flange_b.w)";
  SI.Torque tau "Torque between flanges (= flange_a.tau)";
  Boolean free( start=false) "Indicates freewheeling";
  Real s(start=0) "Auxilliary variable";
  parameter SI.Torque tauRes=1e-5 "Residual friction coefficient";
  parameter SI.AngularVelocity wRes=1e-5 "Residual relative velocity coefficient";
protected
  constant SI.AngularVelocity unitAngularVelocity=1;
  constant SI.Torque unitTorque=1;
equation
  w_rel = der(flange_a.phi) - der(flange_b.phi);
  tau =  flange_a.tau;
  tau = -flange_b.tau;
  free = w_rel <= 0;
  w_rel = s*unitAngularVelocity*(if free then 1 else tauRes/unitTorque);
  tau   = s*unitTorque*(if free then wRes/unitAngularVelocity else 1);
  annotation (                                 Icon(graphics={
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-100,-10},{-30,10}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={255,255,255},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-30,-60},{-10,60}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={255,255,255},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{10,-60},{30,60}}),
      Rectangle(  lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{30,-10},{100,10}}),
        Polygon(points={{-10,30},{50,0},{-10,-30},{-10,30}},
          fillPattern=FillPattern.Solid),
        Text(extent={{-152,60},{148,100}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(graphics={         Polygon(
            points={{-4,70},{0,80},{4,70},{-4,70}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),Line(points={{0,80},{0,-80}},
          color={128,128,128}),   Line(points={{-80,0},{80,0}}, color={128,128,128}),
          Polygon(
            points={{70,4},{80,0},{70,-4},{70,4}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
                            Text(
            extent={{70,-10},{80,-20}},
            textColor={128,128,128},
          textString="w"),  Text(
            extent={{-20,80},{-10,70}},
            textColor={128,128,128},
          textString="tau"),Line(
            points={{-70,-20},{0,0},{20,70}},
            thickness=0.5),     Text(
            extent={{20,60},{40,50}},
            textColor={128,128,128},
          textString="wRes"),   Text(
            extent={{-60,-20},{-40,-30}},
            textColor={128,128,128},
          textString="tauRes")}),
    Documentation(info="<html>
<p>
An idealized model of a&nbsp;freewheel. Compared to
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.OneWayClutch\">OneWayClutch</a>
it is modeled in a&nbsp;simplified way referring to
<a href=\"Modelica.Electrical.Analog.Ideal.IdealDiode\">an&nbsp;idealized
model of electrical diode</a>.
This means in particular that there exist two cases indicated
by the variable <code>free</code> and distinguished as follows.
</p>
<ul>
  <li>
    <code>flange_a</code> is driving (<code>free&nbsp;= false</code>): torque is
    transferred with a&nbsp;residual difference <code>wRes</code> of relative angular
    velocity of the flanges.
  </li>
  <li>
    <code>flange_b</code> is driving (<code>free&nbsp;= true</code>): the flanges move
    independently except a&nbsp;residual friction torque <code>tauRes</code>.</li>
</ul>
</html>"));
end FreeWheel;

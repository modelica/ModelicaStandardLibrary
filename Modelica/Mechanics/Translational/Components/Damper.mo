within Modelica.Mechanics.Translational.Components;
model Damper "Linear 1D translational damper"
  extends Translational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.TranslationalDampingConstant d(final min=0, start=0)
    "Damping constant";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
equation
  f = d*v_rel;
  lossPower = f*v_rel;
  annotation (
    Documentation(info="<html>
<p>
<em>Linear, velocity dependent damper</em> element. It can be either connected
between a sliding mass and the housing (model Fixed), or
between two sliding masses.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-90,0},{100,0}}, color={0,127,0}),
          Line(points={{-60,-30},{-60,30}}),                    Rectangle(
              extent={{-60,30},{30,-30}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
          lineColor={0,127,0}),                                           Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),    Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
                                                                               Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              textColor={0,0,255}),Text(
              extent={{-150,-45},{150,-75}},
              textString="d=%d"),Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-20},{-14,-20}},
              color={191,0,0},
              pattern=LinePattern.Dot),
                                Line(points={{60,-30},{-60,-30},{-60,30},{60,30}}, color={0,127,0})}));
end Damper;

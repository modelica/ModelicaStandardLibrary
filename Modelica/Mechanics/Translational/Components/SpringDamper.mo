within Modelica.Mechanics.Translational.Components;
model SpringDamper "Linear 1D translational spring and damper in parallel"
  extends Translational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1)
    "Spring constant";
  parameter SI.TranslationalDampingConstant d(final min=0, start=1)
    "Damping constant";
  parameter SI.Position s_rel0=0 "Unstretched spring length";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  Modelica.SIunits.Force f_c "Spring force";
  Modelica.SIunits.Force f_d "Damping force";
equation
  f_c = c*(s_rel - s_rel0);
  f_d = d*v_rel;
  f = f_c + f_d;
  lossPower = f_d*v_rel;
  annotation (
    Documentation(info="<html>
<p>
A <em>spring and damper element connected in parallel</em>.
The component can be
connected either between two sliding masses to describe the elasticity
and damping, or between a sliding mass and the housing (model Fixed),
to describe a coupling of the sliding mass with the housing via a spring/damper.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{
              60,40},{80,40}}, color={0,127,0}),
        Line(points={{-80,40},{-80,-70},{80,-70},{80,40}}, color={0,127,0}),
        Line(points={{-90,0},{-80,0}}, color={0,127,0}),
        Line(points={{80,0},{90,0}}, color={0,127,0}),
        Polygon(
          points={{53,-20},{23,-10},{23,-30},{53,-20}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-57,-20},{23,-20}}, color={95,127,95}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-135},{150,-165}},
          textString="d=%d"),
        Text(
          extent={{-150,-100},{150,-130}},
          textString="c=%c"),
        Line(
          visible=useHeatPort,
          points={{-100,-100},{-100,-80},{-5,-80}},
          color={191,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-50,-50},{40,-90}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          lineColor={0,127,0}), Line(points={{70,-90},{-50,-90},{-50,-50},{70,-50}}, color={0,127,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(
              points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,
            32},{80,32}},
              thickness=0.5),Line(points={{-100,31},{-100,96}}, color={128,128,128}),
          Line(points={{100,29},{100,94}}, color={128,128,128}),
          Line(points={{-98,82},{100,82}}, color={128,128,128}),Polygon(
              points={{90,85},{100,82},{90,79},{90,85}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),Text(
              extent={{-63,83},{46,103}},
              textColor={0,0,255},
              textString="s_rel"),Rectangle(
              extent={{-52,-28},{38,-72}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-51,-72},{69,-72}}),Line(points={{-52,-28},{68,-28}}),
          Line(points={{38,-50},{80,-50}}),Line(points={{-80,
          -50},{-52,-50}}),Line(points={{-80,32},{-80,-50}}),Line(points={{80,32},{80,-50}}),
          Line(points={{-90,0},{-80,0}}),Line(points={{90,0},
          {80,0}})}));
end SpringDamper;

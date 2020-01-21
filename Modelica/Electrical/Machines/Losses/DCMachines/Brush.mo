within Modelica.Electrical.Machines.Losses.DCMachines;
model Brush "Model considering voltage drop of carbon brushes"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Machines.Losses.BrushParameters brushParameters
    "Brush loss parameters";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  if (brushParameters.V <= 0) then
    v = 0;
  else
    v = smooth(0, if (i > +brushParameters.ILinear) then +brushParameters.V
       else if (i < -brushParameters.ILinear) then -brushParameters.V
       else brushParameters.V*i/brushParameters.ILinear);
  end if;
  lossPower = v*i;
  annotation (Icon(graphics={
        Line(points={{-100,-100},{-92,-80},{-80,-60},{-60,-40},{-40,-28},
              {-20,-22},{0,-20},{20,-22},{40,-28},{60,-40},{80,-60},{92,-80},
              {100,-100}}, color={0,0,255}),
        Polygon(
          points={{-20,-22},{-40,-28},{-40,20},{40,20},{40,-28},{20,-22},
              {0,-20},{-20,-22}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,80},{150,40}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
Model of voltage drop and losses of carbon brushes. For currents between <code>-ILinear</code> and <code>ILinear</code>
 the voltage drop shows a linear behavior as depicted in Fig. 1.
 For positive currents greater or equal than <code>ILinear</code> the voltage drop equals <code>V</code>.
 For negative currents less or equal than <code>-ILinear</code> the voltage drop equals <code>-V</code>.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/brush.png\"
                alt=\"brush.png\"> </td> </tr>
  <tr><td> <strong> Fig. 1: </strong>Model of voltage drop of carbon brushes</td> </tr>
</table>
<h4>Note</h4>
<p>
The voltage drop <code>v</code> is the total voltage drop of all series connected brushes.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.BrushParameters\">BrushParameters</a>
</p>
<p>
If it is desired to neglect brush losses, set <code>brushParameters.V = 0</code> (this is the default).
</p>
</html>"));
end Brush;

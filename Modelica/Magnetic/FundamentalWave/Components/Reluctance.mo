within Modelica.Magnetic.FundamentalWave.Components;
model Reluctance "Salient reluctance"

  import Modelica.Constants.pi;

  extends Interfaces.PartialTwoPort;
  parameter Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(
    d(start=1), q(start=1)) "Magnetic reluctance in d=re and q=im axis";

equation
  (pi/2) * V_m.re = R_m.d * Phi.re;
  (pi/2) * V_m.im = R_m.q * Phi.im;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-96,0},{-70,0}}, color={255,128,0}),
        Line(points={{70,0},{96,0}}, color={255,128,0}),
        Text(
          extent={{0,60},{0,100}},
          lineColor={255,128,0},
          textString =                         "%name"),
        Text(
          extent={{0,-70},{0,-110}},
          lineColor={0,0,0},
          textString=
               "R_m.re=%R_m.re, R_m.im=%R_m.im")}),Documentation(info="<html>
<p>
The salient reluctance models the relationship between the complex magnetic potential difference
<img src=\"../Images/Magnetic/FundamentalWave/V_m.png\"> and the complex magnetic flux <img src=\"../Images/Magnetic/FundamentalWave/Phi.png\">,
</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/reluctance.png\">
</p>

<p>which can also be expressed in terms complex phasors:</p>

<p> 
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/reluctance_alt.png\">
</p> 
</html>"));
end Reluctance;

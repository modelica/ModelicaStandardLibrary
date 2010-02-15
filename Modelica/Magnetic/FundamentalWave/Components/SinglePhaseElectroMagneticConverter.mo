within Modelica.Magnetic.FundamentalWave.Components;
model SinglePhaseElectroMagneticConverter
  "Single phase electro magnetic converter"

  import Modelica.Constants.pi;

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin" 
    annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin" 
    annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}, rotation=0)));
  Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}}, rotation=
           0)));

  parameter Real effectiveTurns "Effective number of turns";
  parameter Modelica.SIunits.Angle windingAngle
    "Angle of winding axis (with respect to fundamental)";

  // Local electric single phase quantities
  Modelica.SIunits.Voltage v "Voltage drop";
  Modelica.SIunits.Current i "Current";

  // Local electromagnetic fundamental wave quantities
  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";

  final parameter Complex rotator = Modelica.ComplexMath.exp(Complex(0,windingAngle))
    "Equivalent vector representation of windingAngle";

equation
  // Complex magnetic flux into positive port
  port_p.Phi = Phi;

  // Complex magnetic potential difference
  port_p.V_m - port_n.V_m = V_m;
  port_p.Phi + port_n.Phi = Complex(0,0);

  // Voltage equation
  v = pin_p.v - pin_n.v;

  // Current equations
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;

  // Complex magnetic potential difference from currents, number
  // of turns and angles of winding axis
  // V_m.re = (2/pi) * effectiveTurns*cos(windingAngle)*i;
  // V_m.im = (2/pi) * effectiveTurns*sin(windingAngle)*i;
  V_m = (2.0/pi) * effectiveTurns*rotator*i;

  // Induced voltages from complex magnetic flux, number of turns
  // and angles of winding axis
  // -v = effectiveTurns*real(rotator*Complex(der(Phi.re),der(Phi.im));
  -v = effectiveTurns*cos(windingAngle)*der(Phi.re)
     + effectiveTurns*sin(windingAngle)*der(Phi.im);

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
                       Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,60},{58,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,0},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{0,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{
              42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},
              {78,96},{90,100},{100,100}}, color={255,128,0}),
        Line(points={{0,60},{-100,60},{-100,100}}, color={0,0,255}),
        Line(points={{0,-60},{-100,-60},{-100,-98}}, color={0,0,255}),
        Text(
          extent={{0,160},{0,120}},
          lineColor={0,0,255},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),
  Documentation(info="<html>
<p>
The single phase winding has an effective number of turns, <img src=\"../Images/Magnetic/FundamentalWave/effectiveTurns.png\"> and a respective winding angle, <img src=\"../Images/Magnetic/FundamentalWave/windingAngle.png\">. The current in winding is <img src=\"../Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
The total complex magnetic potential difference of the single phase winding is determined by: 
</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
In this equation the magneto motive forc is aligned with the winding axis. 
</p>

<p>
The voltage <img src=\"../Images/Magnetic/FundamentalWave/v.png\"> induced in the winding depends on the cosine between the the winding angle and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are propotional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/singlephaseconverter_phi.png\">
</p>

<p>The single phase electro magnetic converter is a special case of the 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">MultiPhaseElectroMagneticConverter</a>
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">MultiPhaseElectroMagneticConverter</a>
</p>

</html>"));
end SinglePhaseElectroMagneticConverter;

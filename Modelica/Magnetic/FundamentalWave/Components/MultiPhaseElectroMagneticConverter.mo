within Modelica.Magnetic.FundamentalWave.Components;
model MultiPhaseElectroMagneticConverter
  "Multi phase electro magnetic converter"

  import Modelica.Constants.pi;

  // constant Modelica.SIunits.Angle offset = 0.0000
  //   "Development constant to be removed in the final version";
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(
    final m=m) "Positive plug" 
    annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(
    final m=m) "Negative plug" 
    annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}, rotation=0)));
  Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}}, rotation=
           0)));

  parameter Integer m = 3 "Number of phases";
  parameter Real effectiveTurns[m] "Effective number of turns";
  parameter Modelica.SIunits.Angle windingAngle[m]
    "Angle of winding axis (with respect to fundamental)";

  // Local electric multi phase quantities
  Modelica.SIunits.Voltage v[m] "Voltage drop";
  Modelica.SIunits.Current i[m] "Current";

  // Local electromagnetic fundamental wave quantities
  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";

  // A technical solution with a rotator cannot be applied to the equations below
  // final parameter Complex rotator[m] = {Modelica.ComplexMath.exp(Complex(0,windingAngle[k])) for k in 1:m}
  //  "Equivalent vector representation of windingAngle";

equation
  // Flux into positive port
  port_p.Phi = Phi;

  // Magneto motive force
  port_p.V_m - port_n.V_m = V_m;
  port_p.Phi + port_n.Phi = Complex(0,0);

  // Voltage equation
  v = plug_p.pin.v - plug_n.pin.v;

  // Current equations
  i = plug_p.pin.i;
  plug_p.pin.i + plug_n.pin.i = zeros(m);

  // Complex magnetic potential difference from currents, number
  // of turns and angles of winding axis
  V_m.re = (2.0/pi) * sum( effectiveTurns[k]*cos(windingAngle[k])*i[k] for k in 1:m);
  V_m.im = (2.0/pi) * sum( effectiveTurns[k]*sin(windingAngle[k])*i[k] for k in 1:m);

  // Induced voltages from complex magnetic flux, number of turns
  // and angles of winding axis
  for k in 1:m loop
    -v[k] = effectiveTurns[k]*cos(windingAngle[k])*der(Phi.re)
          + effectiveTurns[k]*sin(windingAngle[k])*der(Phi.im);
  end for;

  annotation (Diagram(graphics),
                       Icon(graphics={
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
Each phase <img src=\"../Images/Magnetic/FundamentalWave/k.png\"> of an <img src=\"../Images/Magnetic/FundamentalWave/m.png\"> phase winding has an effective number of turns, <img src=\"../Images/Magnetic/FundamentalWave/effectiveTurns_k.png\"> and an respective winging angle <img src=\"../Images/Magnetic/FundamentalWave/windingAngle_k.png\"> and a phase current <img src=\"../Images/Magnetic/FundamentalWave/i_k.png\">. 
</p>

<p>
The total complex magnetic potential difference of the mutli phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/multiphaseconverter_vm.png\">
</p>

<p>
In this equation each contribution of a winding magneto motive force on the total complex magnetic potential difference is aligned with the respective winding axis. 
</p>

<p>
The voltages <img src=\"../Images/Magnetic/FundamentalWave/v_k.png\"> induced in each winding depend on the cosinus between the the winding angle and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are propotional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Components/multiphaseconverter_phi.png\">
</p>

<p>for <img src=\"../Images/Magnetic/FundamentalWave/k_in_1_m.png\"> and is also illustrated by the following figure:</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><b>Fig:</b> Winding axis and location of complex magnetic flux</caption>
  <tr>
    <td>
      <img src=\"../Images/Magnetic/FundamentalWave/Components/coupling.png\">
    </td>
  </tr>
</table> 

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a>
<p>
</p>
</html>"));
end MultiPhaseElectroMagneticConverter;

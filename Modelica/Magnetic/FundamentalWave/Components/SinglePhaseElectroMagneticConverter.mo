within Modelica.Magnetic.FundamentalWave.Components;
model SinglePhaseElectroMagneticConverter
  "Single-phase electromagnetic converter"
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
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  parameter Real effectiveTurns "Effective number of turns"
    annotation (Evaluate=true);
  parameter SI.Angle orientation
    "Orientation of the resulting fundamental wave V_m phasor"
    annotation (Evaluate=true);
  // Local electric single-phase quantities
  SI.Voltage v "Voltage";
  SI.Current i "Current";

  // Local electromagnetic fundamental wave quantities
  SI.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";

  SI.ComplexMagneticFlux Phi "Complex magnetic flux";
  SI.MagneticPotentialDifference abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
      0, orientation)) "Complex number of turns";
equation
  // Magnetic flux and flux balance of the magnetic ports
  port_p.Phi = Phi;
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // Magnetic potential difference of the magnetic ports
  port_p.V_m - port_n.V_m = V_m;
  // Voltage drop between the electrical pins
  v = pin_p.v - pin_n.v;
  // Current and current balance of the electric pins
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;
  // Complex magnetic potential difference is determined from currents, number
  // of turns and angles of orientation of winding
  // V_m.re = (2/pi) * effectiveTurns*cos(orientation)*i;
  // V_m.im = (2/pi) * effectiveTurns*sin(orientation)*i;
  V_m = (2.0/pi)*N*i;
  // Induced voltages is determined from complex magnetic flux, number of turns
  // and angles of orientation of winding
  // -v = effectiveTurns*cos(orientation)*der(Phi.re)
  //    + effectiveTurns*sin(orientation)*der(Phi.im);
  -v = Modelica.ComplexMath.real(Modelica.ComplexMath.conj(N)*Complex(der(
    Phi.re), der(Phi.im)));
  annotation (
    defaultComponentName="converter",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{100,-100},{94,-100},
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
          color={255,128,0}),Line(points={{-20,60},{-20,100},{-100,100}},
          color={0,0,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}},
          color={0,0,255}),
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-13,45},
          rotation=270),
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-13,-15},
          rotation=270),
          Text(
              extent={{-150,120},{150,160}},
              textColor={0,0,255},
              textString="%name")}),
    Documentation(info="<html>
<p>
The single-phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\"> and a respective orientation of the winding, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">. The current in winding is <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
The total complex magnetic potential difference of the single-phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
In this equation the magnetomotive force is aligned with the orientation of the winding.
</p>

<p>
The voltage <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\"> induced in the winding depends on the cosine between the orientation of the winding and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are proportional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_phi.png\">
</p>

<p>The single-phase electromagnetic converter is a special case of the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a>
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a>
</p>

</html>"));
end SinglePhaseElectroMagneticConverter;

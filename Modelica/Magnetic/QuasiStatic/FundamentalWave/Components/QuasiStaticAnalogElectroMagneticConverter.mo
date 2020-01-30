within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model QuasiStaticAnalogElectroMagneticConverter
  "Electromagnetic converter to only (!) quasi-static analog, neglecting induced voltage"
  // Note: It has not whether the transient voltage induction and the
  //   leakage induction shall be considered in this model or not.
  //   This model is required for electrical excited synchronous machines (SMEE)
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
  // Local electric single-phase quantities
  SI.Voltage v "Voltage drop";
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

  SI.Angle gamma "Angle of V_m fixed reference frame";
  SI.AngularVelocity omega=der(port_p.reference.gamma);
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
  // of turns and angles of orientation of the magnetic potential difference
  V_m = (2/pi)*effectiveTurns*i*Modelica.ComplexMath.fromPolar(1, -gamma);
  // Induced voltages is zero due to quasi-static electric analog circuit
  v = 0;
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  // Reference angle to magnetic potential fixed frame
  gamma = port_p.reference.gamma;
  annotation (
    defaultComponentName="converter",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{100,-100},{94,-100},
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
          color={255,170,85}),
                             Line(points={{-20,60},{-20,100},{-100,100}},
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
          extent={{150,150},{-150,110}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
The analog single-phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\"> and a respective orientation of the winding, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">. The current in the winding is <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
The total complex magnetic potential difference of the single-phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
is the reference angle of the electrical and magnetic system, respectively. The induced voltage <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\"> is identical to zero.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
PolyphaseElectroMagneticConverter</a>
</p>

</html>"));
end QuasiStaticAnalogElectroMagneticConverter;

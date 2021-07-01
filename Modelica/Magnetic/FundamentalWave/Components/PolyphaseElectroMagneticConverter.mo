within Modelica.Magnetic.FundamentalWave.Components;
model PolyphaseElectroMagneticConverter
  "Polyphase electromagnetic converter"

  import Modelica.Magnetic.FundamentalWave.Types.SalientPermeance;

  // Global plug and port variables
  SI.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "Voltage";
  SI.Current i[m]=plug_p.pin.i "Current";
  SI.ComplexMagneticPotentialDifference V_m=port_p.V_m -
      port_n.V_m "Magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";

  SI.ComplexMagneticFlux Phi=port_p.Phi "Magnetic flux";
  SI.MagneticPotentialDifference abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    "Positive plug" annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    "Negative plug" annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive complex magnetic port"
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative complex magnetic port"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Real effectiveTurns[m] "Effective number of turns";
  parameter SI.Angle orientation[m]
    "Orientation of the resulting fundamental wave field phasor";
  parameter Boolean useStrayPermeance=false "Use optional stray permeance";
  parameter SI.Inductance Lsigma=0 "Optional stray inductance"
    annotation(Dialog(enable=useStrayPermeance));
  Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter singlePhaseElectroMagneticConverter[m](
    final effectiveTurns=effectiveTurns, final orientation=orientation)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Permeance strayPermeance[m](final G_m={SalientPermeance(
    d=Lsigma/effectiveTurns[k]^2, q=Lsigma/effectiveTurns[k]^2) for k in 1:m}) if useStrayPermeance
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,0})));
equation
  connect(plug_p.pin, singlePhaseElectroMagneticConverter.pin_p)
    annotation (Line(
      points={{-100,100},{-8,100},{-8,10}}, color={0,0,255}));
  connect(singlePhaseElectroMagneticConverter.pin_n, plug_n.pin)
    annotation (Line(
      points={{-8,-10},{-8,-100},{-100,-100}}, color={0,0,255}));
  connect(singlePhaseElectroMagneticConverter[1].port_p, port_p)
    annotation (Line(
      points={{12,10},{12,100},{100,100}}, color={255,128,0}));
  for k in 2:m loop
    connect(singlePhaseElectroMagneticConverter[k - 1].port_n,
      singlePhaseElectroMagneticConverter[k].port_p);
  end for;
  connect(singlePhaseElectroMagneticConverter[m].port_n, port_n)
    annotation (Line(
      points={{12,-10},{12,-100},{100,-100}}, color={255,128,0}));
  connect(singlePhaseElectroMagneticConverter.port_p, strayPermeance.port_p)
    annotation (Line(points={{12,10},{30,10}}, color={255,128,0}));
  connect(singlePhaseElectroMagneticConverter.port_n, strayPermeance.port_n)
    annotation (Line(points={{12,-10},{30,-10}}, color={255,128,0}));
  annotation (defaultComponentName="converter",
    Icon(graphics={           Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
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
Each phase <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\"> of an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\"> and an respective winging angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\"> and a phase current <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
The total complex magnetic potential difference of the polyphase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/polyphaseconverter_vm.png\">
</p>

<p>
In this equation each contribution of a winding magnetomotive force on the total complex magnetic potential difference is aligned with the respective orientation of the winding.
</p>

<p>
The voltages <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\"> induced in each winding depend on the cosines between the orientation of the winding and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are proportional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/polyphaseconverter_phi.png\">
</p>

<p>for <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k_in_1_m.png\"> and is also illustrated by the following figure:</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig:</strong> Orientation of winding and location of complex magnetic flux</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/coupling.png\">
    </td>
  </tr>
</table>

<p>
The converter model optionally (if <code>useStrayPermeance = true</code>) considers stray field permeances (inductance) solely coupled to each individual phase, but no mutual stray inductance.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a>
</p>
</html>"));
end PolyphaseElectroMagneticConverter;

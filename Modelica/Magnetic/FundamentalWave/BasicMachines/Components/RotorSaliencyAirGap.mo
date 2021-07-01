within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model RotorSaliencyAirGap "Air gap model with rotor saliency"
  import Modelica.Constants.pi;
  Interfaces.PositiveMagneticPort port_sp
    "Positive complex magnetic stator port" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
  Interfaces.NegativeMagneticPort port_sn
    "Negative complex magnetic stator port" annotation (Placement(
        transformation(extent={{-110,90},{-90,110}})));
  Interfaces.PositiveMagneticPort port_rp
    "Positive complex magnetic rotor port" annotation (Placement(
        transformation(extent={{90,90},{110,110}})));
  Interfaces.NegativeMagneticPort port_rn
    "Negative complex magnetic rotor port" annotation (Placement(
        transformation(extent={{90,-110},{110,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "Flange of the rotor" annotation (Placement(transformation(extent={{-10,
            110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "Support at which the reaction torque is acting" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));
  parameter Integer p "Number of pole pairs";
  parameter Magnetic.FundamentalWave.Types.SalientInductance L0(d(start=1), q(
        start=1))
    "Salient inductance of a single unchorded coil w.r.t. the fundamental wave";
  final parameter Magnetic.FundamentalWave.Types.SalientReluctance R_m(d=1/L0.d,
      q=1/L0.q) "Reluctance of the air gap model";
  // Complex phasors of magnetic potential differences
  SI.ComplexMagneticPotentialDifference V_mss
    "Complex magnetic potential difference of stator w.r.t. stator fixed frame";
  SI.ComplexMagneticPotentialDifference V_msr
    "Complex magnetic potential difference of stator w.r.t. rotor fixed frame";
  SI.ComplexMagneticPotentialDifference V_mrr
    "Complex magnetic potential difference of rotor w.r.t. rotor fixed frame";
  // Complex phasors of magnetic fluxes
  SI.ComplexMagneticFlux Phi_ss
    "Complex magnetic flux of stator w.r.t. stator fixed frame";
  SI.ComplexMagneticFlux Phi_sr
    "Complex magnetic flux of stator w.r.t. rotor fixed frame";
  SI.ComplexMagneticFlux Phi_rr
    "Complex magnetic flux of rotor w.r.t. rotor fixed frame";
  // Electrical torque and mechanical angle
  SI.Torque tauElectrical "Electrical torque";
  SI.Angle gamma
    "Electrical angle between rotor and stator";
  Complex rotator "Equivalent vector representation of orientation";
equation
  port_sp.Phi = Phi_ss "Stator flux into positive stator port";
  port_sp.Phi + port_sn.Phi = Complex(0, 0) "Balance of stator flux";
  port_rp.Phi = Phi_rr "Rotor flux into positive rotor port";
  port_rp.Phi + port_rn.Phi = Complex(0, 0) "Balance of rotor flux";
  port_sp.V_m - port_sn.V_m = V_mss "Magnetomotive force of stator";
  port_rp.V_m - port_rn.V_m = V_mrr "Magnetomotive force of rotor";
  // Transformations between stator and rotor fixed frame
  V_msr = V_mss*Modelica.ComplexMath.conj(rotator);
  Phi_sr = Phi_ss*Modelica.ComplexMath.conj(rotator);
  // Stator flux and rotor flux are equal
  Phi_sr = Phi_rr;
  // Local balance of magnetomotive force
  (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
  (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
  // Torque
  tauElectrical = -(pi*p/2.0)*(Phi_ss.im*V_mss.re - Phi_ss.re*V_mss.im);
  flange_a.tau = -tauElectrical;
  support.tau = tauElectrical;
  // Electrical angle between stator and rotor
  gamma = p*(flange_a.phi - support.phi);
  rotator = Modelica.ComplexMath.exp(Complex(0, gamma));
  annotation (defaultComponentName="airGap", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,90},{-100,60},{-80,60}}, color={255,128,0}),
        Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,128,0}),
        Line(points={{40,60},{100,60},{100,90}}, color={255,128,0}),
        Line(points={{40,-60},{100,-60},{100,-90}}, color={255,128,0}),
        Ellipse(
          extent={{-60,80},{60,-80}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,90}})}), Documentation(info="<html>
<p>
This salient air gap model can be used for machines with uniform air gaps and for machines with rotor saliency. The air gap model is not symmetrical towards stator and rotor since it is assumed the saliency always refers to the rotor. The saliency of the air gap is represented by a main field inductance in the d- and q-axis.
</p>

<p>
For the mechanical interaction of the air gap model with the stator and the rotor is equipped with two
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. The torques acting on both connectors have the same absolute values but different signs. The difference between the stator and the rotor angle,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/gamma.png\">, is required for the transformation of the magnetic stator quantities to the rotor side.</p>

<p>
The air gap model has two magnetic stator and two magnetic rotor
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. The magnetic potential difference and the magnetic flux of the stator (superscript s) are transformed to the rotor fixed reference frame (superscript r). The effective reluctances of the main field with respect to the d- and q-axis are considered then in the balance equations
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<p>
according to the following figure.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig:</strong> Magnetic equivalent circuit of the air gap model</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap_phasors.png\">
    </td>
  </tr>
</table>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
</p>

</html>"));
end RotorSaliencyAirGap;

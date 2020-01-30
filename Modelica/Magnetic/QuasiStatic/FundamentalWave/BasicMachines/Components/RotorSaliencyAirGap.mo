within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
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
  SI.ComplexMagneticPotentialDifference V_ms
    "Complex magnetic potential difference of stator w.r.t. stator fixed frame";
  SI.ComplexMagneticPotentialDifference V_msr=V_ms*
      Modelica.ComplexMath.fromPolar(1, gammar)
    "Complex magnetic potential difference of stator w.r.t. rotor fixed frame";
  SI.ComplexMagneticPotentialDifference V_mr
    "Complex magnetic potential difference of rotor w.r.t. rotor fixed frame";
  SI.ComplexMagneticPotentialDifference V_mrr=V_mr*
      Modelica.ComplexMath.fromPolar(1, gammar)
    "Complex magnetic potential difference of rotor w.r.t. rotor fixed frame";
  // Complex phasors of magnetic fluxes
  SI.ComplexMagneticFlux Phi_s
    "Complex magnetic flux of stator w.r.t. stator fixed frame";
  SI.ComplexMagneticFlux Phi_sr=Phi_s*
      Modelica.ComplexMath.fromPolar(1, gammar)
    "Complex magnetic flux of stator w.r.t. rotor fixed frame";
  SI.ComplexMagneticFlux Phi_r
    "Complex magnetic flux of rotor w.r.t. rotor fixed frame";
  SI.ComplexMagneticFlux Phi_rr=Phi_r*
      Modelica.ComplexMath.fromPolar(1, gammar)
    "Complex magnetic flux of rotor w.r.t. rotor fixed frame";
  // Electrical torque and mechanical angle
  SI.Torque tauElectrical "Electrical torque";
  SI.Angle gamma=p*(flange_a.phi - support.phi)
    "Electrical angle between rotor and stator";
  SI.Angle gammas=port_sp.reference.gamma
    "Angle electrical quantities in stator fixed frame";
  SI.Angle gammar=port_rp.reference.gamma
    "Angle electrical quantities in rotor fixed frame";
equation
  port_sp.Phi = Phi_s "Stator flux into positive stator port";
  port_sp.Phi + port_sn.Phi = Complex(0, 0) "Balance of stator flux";
  port_rp.Phi = Phi_r "Rotor flux into positive rotor port";
  port_rp.Phi + port_rn.Phi = Complex(0, 0) "Balance of rotor flux";
  port_sp.V_m - port_sn.V_m = V_ms "Magnetomotive force of stator";
  port_rp.V_m - port_rn.V_m = V_mr "Magnetomotive force of rotor";
  // Stator flux and rotor flux are equal
  Phi_s = Phi_r;
  // Local balance of magnetomotive force
  (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
  (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
  // Torque
  tauElectrical = -(pi*p/2.0)*(Phi_s.im*V_ms.re - Phi_s.re*V_ms.im);
  flange_a.tau = -tauElectrical;
  support.tau = tauElectrical;
  // Potential root of rotor has been removed. Only the stator positive
  //   plug is a potential root so that being a root determines that not
  //   electrical stator root is connected from outside; in this case the
  //   machine is operated as generator and the rotor angle is set to zero.
  // Magnetic stator and rotor port are (again) connected through
  //   Connections.branch, even though it is not clear yet whether this
  //   implementation is Modelica compliant
  Connections.potentialRoot(port_sp.reference);
  // Connections.potentialRoot(port_rp.reference);
  Connections.branch(port_sp.reference, port_sn.reference);
  port_sp.reference.gamma = port_sn.reference.gamma;
  Connections.branch(port_rp.reference, port_rn.reference);
  port_rp.reference.gamma = port_rn.reference.gamma;
  Connections.branch(port_sp.reference, port_rp.reference);
  gammas = gammar + gamma;
  if Connections.isRoot(port_sp.reference) then
    gammar = 0;
  end if;
  annotation (defaultComponentName="airGap",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,90},{-100,60},{-80,60}}, color={255,170,85}),
        Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,170,85}),
        Line(points={{40,60},{100,60},{100,90}}, color={255,170,85}),
        Line(points={{40,-60},{100,-60},{100,-90}}, color={255,170,85}),
        Ellipse(
          extent={{-60,80},{60,-80}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,90}})}),
    Documentation(info="<html>
<p>
This salient air gap model can be used for machines with uniform air gaps and for machines with rotor saliency. The air gap model is not symmetrical towards stator and rotor since it is assumed the saliency always refers to the rotor. The saliency of the air gap is represented by a main field inductance in the d- and q-axis.
</p>

<p>
For the mechanical interaction of the air gap model with the stator and the rotor is equipped with two
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. The torques acting on both connectors have the same absolute values but different signs. The stator and the rotor reference angles,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"> and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\"> are related by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\">
where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
is the electrical angle between stator and rotor.
</p>

<p>
The air gap model has two magnetic stator and two magnetic rotor
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. The magnetic potential difference and the magnetic flux of the stator and rotor are equal complex quantities, respectively, but the reference angles are different; see <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">Concept</a>. The d and q axis components with respect to the rotor fixed reference frame (superscript r) are determined from the stator (superscript s) and rotor (superscript r) reference quantities, by
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/V_m_transformation.png\">.
</p>

<p>
The d and q axis magnetic potential difference components and flux components are related with the flux by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>

</html>"));
end RotorSaliencyAirGap;

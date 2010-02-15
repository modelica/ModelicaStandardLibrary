within Modelica.Magnetic.FundamentalWave.Machines.Components;
model RotorSaliencyAirGap "Air gap model with rotor saliency"

  import Modelica.Constants.pi;

  Interfaces.PositiveMagneticPort port_sp
    "Positive complex magnetic stator port" 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}}, rotation=
           0)));
  Interfaces.NegativeMagneticPort port_sn
    "Negative complex magnetic stator port" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}},
          rotation=0)));
  Interfaces.PositiveMagneticPort port_rp
    "Positive complex magnetic rotor port" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}, rotation=0)));
  Interfaces.NegativeMagneticPort port_rn
    "Negative complex magnetic rotor port" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}}, rotation=
           0)));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "Flange of the rotor" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "Support at which the reaction torque is acting" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));

  parameter Integer p "Number of pole pairs";
  parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance L0(
    d(start=1), q(start=1))
    "Salient inductance of a single unchorded coil w.r.t. the fundamental wave";
  final parameter Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(
    d=1/L0.d, q=1/L0.q) "Reluctance of the air gap model";

  // Stator magnetic quantities
  Modelica.SIunits.ComplexMagneticPotentialDifference V_mss
    "Complex magnetic potential difference of stator w.r.t. stator reference frame";
  Modelica.SIunits.ComplexMagneticPotentialDifference V_msr
    "Complex magnetic potential difference of stator w.r.t. rotor reference frame";
  Modelica.SIunits.ComplexMagneticPotentialDifference V_mrr
    "Complex magnetic potential difference of rotor w.r.t. rotor reference frame";
  // Modelica.SIunits.ComplexMagneticPotentialDifference V_mrs
  //   "Complex magnetic potential difference of rotor w.r.t. stator reference frame";

  Modelica.SIunits.ComplexMagneticFlux Phi_ss
    "Complex magnetic potential difference of stator w.r.t. stator reference frame";
  Modelica.SIunits.ComplexMagneticFlux Phi_sr
    "Complex magnetic potential difference of stator w.r.t. rotor reference frame";
  Modelica.SIunits.ComplexMagneticFlux Phi_rr
    "Complex magnetic potential difference of rotor w.r.t. rotor reference frame";
  // Modelica.SIunits.ComplexMagneticFlux Phi_rs
  //   "Complex magnetic potential difference of rotor w.r.t. stator reference frame";

  // Electrical torque and mechanical angle
  Modelica.SIunits.Torque tauElectrical "Electrical torque";
  // Modelica.SIunits.Torque tauTemp "Electrical torque";
  Modelica.SIunits.Angle gamma "Electrical angle between rotor and stator";

  Complex rotator "Equivalent vector representation of windingAngle";

equation
  // Stator flux into positive stator port
  port_sp.Phi = Phi_ss;
  // Balance of stator flux
  port_sp.Phi + port_sn.Phi = Complex(0,0);

  // Rotor flux into positive rotor port
  port_rp.Phi = Phi_rr;
  // Balance of rotor flux
  port_rp.Phi + port_rn.Phi = Complex(0,0);

  // Magneto motive force of stator
  port_sp.V_m - port_sn.V_m = V_mss;

  // Magneto motive force of stator
  port_rp.V_m - port_rn.V_m = V_mrr;

  // Transformation of fluxes between stator and rotor fixed frame, if wanted
  // Phi_rs.re = + Phi_rr.re * cos(gamma) - Phi_rr.im * sin(gamma);
  // Phi_rs.im = + Phi_rr.re * sin(gamma) + Phi_rr.im * cos(gamma);
  // Alternative transformation
  // Phi_rr.re = + Phi_rs.re * cos(gamma) + Phi_rs.im * sin(gamma);
  // Phi_rr.im = - Phi_rs.re * sin(gamma) + Phi_rs.im * cos(gamma);

  // Transformed stator flux is not needed
  // Phi_sr.re = + Phi_ss.re * cos(gamma) + Phi_ss.im * sin(gamma);
  // Phi_sr.im = - Phi_ss.re * sin(gamma) + Phi_ss.im * cos(gamma);
  Phi_sr = Phi_ss * Modelica.ComplexMath.conj(rotator);
  // Alternative transformation
  // Phi_ss.re = + Phi_sr.re * cos(gamma) - Phi_sr.im * sin(gamma);
  // Phi_ss.im = + Phi_sr.re * sin(gamma) + Phi_sr.im * cos(gamma);

  // Local balance of flux w.r.t. the rotor fixed frame
  Phi_sr + Phi_rr = Complex(0,0);

  // Transformation of magnetic potential difference between stator and rotor fixed frame
  // V_mrs.re = + V_mrr.re * cos(gamma) - V_mrr.im * sin(gamma);
  // V_mrs.im = + V_mrr.re * sin(gamma) + V_mrr.im * cos(gamma);
  // V_mrr.re = + V_mrs.re * cos(gamma) + V_mrs.im * sin(gamma);
  // V_mrr.im = - V_mrs.re * sin(gamma) + V_mrs.im * cos(gamma);
  // V_msr.re = + V_mss.re * cos(gamma) + V_mss.im * sin(gamma);
  // V_msr.im = - V_mss.re * sin(gamma) + V_mss.im * cos(gamma);
  V_msr = V_mss * Modelica.ComplexMath.conj(rotator);
  // V_msr.re = + V_mss.re * cos(gamma) + V_mss.im * sin(gamma);
  // V_msr.im = - V_mss.re * sin(gamma) + V_mss.im * cos(gamma);

  // Local balance of maganeto motive force
  (pi/2.0) * (V_mrr.re - V_msr.re) = Phi_rr.re*R_m.d;
  (pi/2.0) * (V_mrr.im - V_msr.im) = Phi_rr.im*R_m.q;

  // Torque
  tauElectrical = - (pi*p/2.0)*(Phi_ss.re * V_mss.im - Phi_ss.im * V_mss.re);

  flange_a.tau = tauElectrical;
  support.tau = -tauElectrical;

  // Electrical angle between stator and rotor
  gamma = p*(flange_a.phi-support.phi);
  rotator = Modelica.ComplexMath.exp(Complex(0,gamma));

  annotation (Diagram(graphics),
                       Icon(graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,90},{-100,60},{-80,60}}, color={255,128,0}),
        Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,128,0}),
        Line(points={{40,60},{100,60},{100,90}}, color={255,128,0}),
        Line(points={{40,-60},{100,-60},{100,-90}}, color={255,128,0}),
        Ellipse(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,90}}, color={0,0,0})}),
    Documentation(info="<html>
<p> 
This salient air gap model can be used for machines with uniform airgaps and for machines with rotor saliencies. The air gap model is not symmetrical towards stator and rotor since it is assumed the saliency always refers to the rotor. The saliency of the air gap is represented by a main field inductance in the d- and q-axis. 
</p>

<p>
For the mechanical interaction of the air gap model with the stator and the rotor it is equipped with to 
<a href=\"Modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. The torques acting on both connectors have the same absolute values but different signs. The difference between the stator and the rotor angle, 
<img src=\"../Images/Magnetic/FundamentalWave/gamma.png\">, is required for the transformation of the magnetic stator quantities to the rotor side.</p>

<p>
The air gap model has two magnetic stator and two magnetic rotor 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. The magnetic potential difference and the magnetic flux of the stator (superscript s) are transformed to the rotor fixed reference frame (superscript r). The effective reluctances of the main field with respect to the d- and q-axis are considered then in the balance equations
</p>

<p>
&nbsp;&nbsp;<img src=\"../Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<p>
according to the following figure. 
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><b>Fig:</b> Magnetic equivalent circuit of the air gap model</caption>
  <tr>
    <td>
      <img src=\"../Images/Magnetic/FundamentalWave/Machines/Components/airgap_phasors.png\">
    </td>
  </tr>
</table> 

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseCageWinding\">
   SymmetricMultiPhaseCageWinding</a>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SaliencyCageWinding\">
   SaliencyCageWinding</a>
</p>

</html>"),    Icon(
      Text(
        extent=[0,20; 0,-20],
        string="%name",
        style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=45,
          rgbfillColor={255,128,0},
          fillPattern=1))));
end RotorSaliencyAirGap;

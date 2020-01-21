within Modelica.Electrical.Machines.BasicMachines.Components;
partial model PartialAirGap "Partial airgap model"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p(min=1) "Number of pole pairs";
  output SI.Torque tauElectrical;
  SI.Angle gamma "Rotor displacement angle";
  SI.Current i_ss[2]
    "Stator current space phasor with respect to the stator fixed frame";
  SI.Current i_sr[2]
    "Stator current space phasor with respect to the rotor fixed frame";
  SI.Current i_rs[2]
    "Rotor current space phasor with respect to the stator fixed frame";
  SI.Current i_rr[2]
    "Rotor current space phasor with respect to the rotor fixed frame";
  SI.MagneticFlux psi_ms[2]
    "Magnetizing flux phasor with respect to the stator fixed frame";
  SI.MagneticFlux psi_mr[2]
    "Magnetizing flux phasor with respect to the rotor fixed frame";
  Real RotationMatrix[2, 2] "Matrix of rotation from rotor to stator";
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
      Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "Support at which the reaction torque is acting" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));
  Machines.Interfaces.SpacePhasor spacePhasor_s
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Machines.Interfaces.SpacePhasor spacePhasor_r
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  /*
  SI.AngularVelocity omegaPsi_ms
    "Angular velocity of main flux with respect to the stator fixed frame";
  SI.AngularVelocity omegaPsi_mr
    "Angular velocity of main flux with respect to the rotor fixed frame";
  SI.Current i_sm[2]
    "Stator current space phasor with respect to the main flux fixed frame";
  SI.Current i_rm[2]
    "Rotor current space phasor with respect to the main flux fixed frame";
protected
  SI.MagneticFlux psi_msAbs "Length of main flux phasor";
  SI.Angle psi_msArg
    "(Wrapped) angle of main flux phasor with respect to the stator fixed frame";
  SI.Angle psi_mrArg
    "(Wrapped) angle of main flux phasor with respect to the rotor fixed frame";
initial equation
  i_sm = Machines.SpacePhasors.Functions.Rotator(i_ss, psi_msArg);
  i_rm = Machines.SpacePhasors.Functions.Rotator(i_rr, psi_mrArg);
equation
  // AngularVelocity of main flux phasor
  (psi_msAbs, psi_msArg) = Machines.SpacePhasors.Functions.ToPolar(psi_ms);
  psi_mrArg = psi_msArg - gamma;
  omegaPsi_ms = if noEvent(psi_msAbs<Modelica.Constants.small) then 0 else
    (spacePhasor_s.v_[2]*cos(psi_msArg) - spacePhasor_s.v_[1]*sin(psi_msArg))/psi_msAbs;
  omegaPsi_mr = omegaPsi_ms - der(gamma);
  // stator and rotor current w.r.t. main flux fixed frame
  der(i_sm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_ss[1]) + omegaPsi_ms*i_ss[2], der(i_ss[2]) - omegaPsi_ms*i_ss[1]}, psi_msArg);
  der(i_rm) = Machines.SpacePhasors.Functions.Rotator(
    {der(i_rr[1]) + omegaPsi_mr*i_rr[2], der(i_rr[2]) - omegaPsi_mr*i_rr[1]}, psi_mrArg);
*/
equation
  // mechanical angle of the rotor of an equivalent 2-pole machine
  gamma = p*(flange.phi - support.phi);
  RotationMatrix = {{+cos(gamma),-sin(gamma)},{+sin(gamma),+cos(gamma)}};
  i_ss = spacePhasor_s.i_;
  i_ss = RotationMatrix*i_sr;
  i_rr = spacePhasor_r.i_;
  i_rs = RotationMatrix*i_rr;
  // Stator voltage induction
  spacePhasor_s.v_ = der(psi_ms);
  // Rotor voltage induction
  spacePhasor_r.v_ = der(psi_mr);
  // Electromechanical torque (cross product of current and flux space phasor)
  tauElectrical = m/2*p*(spacePhasor_s.i_[2]*psi_ms[1] - spacePhasor_s.i_[
    1]*psi_ms[2]);
  flange.tau = -tauElectrical;
  support.tau = tauElectrical;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-92}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
        Rectangle(
          extent={{-10,90},{10,-80}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={128,128,128}),
        Text(
          extent={{-150,-110},{150,-150}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
Partial model of the airgap, using only equations.
</html>"));
end PartialAirGap;

within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model GenericHysteresis "Partial hysteresis model"
  extends BaseClasses.Generic;
  extends Interfaces.ConditionalHeatPort(final T=293.15);

  parameter Boolean includeEddyCurrents = false
    "= true, if eddy current losses are enabled"
  annotation(Dialog(tab="Losses and heat", group="Eddy currents"), Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SI.Conductivity sigma=10e6 "Conductivity of core material" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=includeEddyCurrents));
  parameter SI.Length d = 0.5e-3 "Thickness of lamination" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=includeEddyCurrents));

  output SI.MagneticFieldStrength H(start=0) "Magnetic field strength";
  output SI.MagneticFieldStrength Hstat
    "Static (ferromagnetic) portion of the magnetic field strength";
  output SI.MagneticFieldStrength Heddy
    "Dynamic (eddy currents) portion of the magnetic field strength";
  output SI.MagneticFluxDensity B "Magnetic flux density";
  output Real MagRel(final quantity="Relative magnetization", final unit="1", start=0, min=-1, max=1)
    "Relative magnetization at initialization (-1..1)";
  output SI.Power LossPowerStat "Ferromagnetic (static) hysteresis losses";
  output SI.Power LossPowerEddy
    "Eddy current losses (dynamic hysteresis losses)";
  //output SI.Power LossPower "Total power loss of core (ferromagnetic + eddy currents)"; // defined in ConditionalHeatPort
  Real derHstat(start=0, unit="A/(m.s)")=der(Hstat);

protected
  final parameter Real eddyCurrentFactor(final unit="S.m") = (sigma * d^2)/12;

equation
  der(MagRel)=0;

  H = Hstat + Heddy;
  H = V_m/l;
  Phi = B*A;

  Heddy = if includeEddyCurrents then eddyCurrentFactor* der(B)  else 0;

  LossPowerStat = Hstat * der(B) * V;
  LossPowerEddy = Heddy * der(B) * V;
  LossPower = LossPowerStat + LossPowerEddy;
  annotation (Icon(graphics={Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
          color={255,128,0},
          smooth=Smooth.Bezier), Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
          color={255,128,0},
          smooth=Smooth.Bezier,
          origin={-4,0},
          rotation=180)}));
end GenericHysteresis;

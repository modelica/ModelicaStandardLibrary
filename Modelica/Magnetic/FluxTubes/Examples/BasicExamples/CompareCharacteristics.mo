within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model CompareCharacteristics "Investigate magnetic characteristic"
  extends Modelica.Icons.Example;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.makeTable;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.app_J;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.app_mu_r;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.app_mu_rd;
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.M350_50A
    material annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  constant Modelica.Units.SI.Time Tend=1;
  parameter Modelica.Units.SI.MagneticFieldStrength Hmin=0 "Start of H";
  parameter Modelica.Units.SI.MagneticFieldStrength Hmax=50000 "End of H";
  Modelica.Units.SI.MagneticFieldStrength H=Hmin + (Hmax - Hmin)*time/Tend
    "Driving field strength";
  parameter Modelica.Units.SI.Area wA=1 "Number of turns x area";
  Modelica.Units.SI.MagneticPolarization Jraw=combiTable1Ds.y[1] "Raw data";
  Modelica.Units.SI.MagneticPolarization J=app_J(H, material) "Approx. polarization";
  Modelica.Units.SI.MagneticFluxDensity B=mu_0*H + J "Approx. flux density";
  Modelica.Units.SI.RelativePermeability mu_r=app_mu_r(H, material) "Approx. relative permeability";
  Modelica.Units.SI.RelativePermeability mu_rd=app_mu_rd(H, material) "Approx. relative differential permeability";
  Modelica.Units.SI.MagneticFlux psi=wA*B "Flux linkage";
  // differentiable due to definition of derJ=mu_0*(mu_rd - 1)*derH
  Modelica.Units.SI.Voltage v=-der(psi) "Induced voltage";
  Modelica.Units.SI.Voltage v_Alt1=-wA*mu_0*mu_rd*der(H) "Induced voltage (alternative calculation 1)";
  Modelica.Units.SI.Voltage v_Alt2=-wA*(mu_0*der(H) + der(J)) "Induced voltage (alternative calculation 2)";
  Modelica.Units.SI.Voltage v_Alt3=-wA*mu_0*(mu_r*der(H) + der(mu_r)*H) "Induced voltage (alternative calculation 3)";
  Modelica.Blocks.Sources.RealExpression realExpression(y=H)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    table=makeTable(material),
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation
  connect(combiTable1Ds.u, realExpression.y)
    annotation (Line(points={{-12,-20},{-19,-20}},
                                                 color={0,0,127}));
  annotation (experiment(
      StopTime = 1,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Magnetic field Strength <code>H</code> is varied within 1 second from <code>Hmin</code> to <code>Hmax</code>. 
Magnetic polarization <code>J</code>, magnetic flux density <code>B</code>, relative permeability <code>mu_r</code>, differential relative permeability <code>mu_rd</code>, 
magnetic flux linkage <code>psi</code> and induced voltage <code>v</code> are calculated an can be plotted versus H to investigate the characteristic of the choosen material. 
Additionally, all approximation functions are tested. 
</p>
</html>"));
end CompareCharacteristics;

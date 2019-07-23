within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenTable
  "Generic flux tube with ferromagnetic hysteresis based on the Tellinen model and table data"

  parameter FluxTubes.Material.HysteresisTableData.BaseData mat=
    FluxTubes.Material.HysteresisTableData.BaseData() "Material properties"
    annotation (choicesAllMatching=true, Dialog(group="Hysteresis"));
  parameter Real K = 1
    "Slope of hysteresis in the saturation region (K*mu_0)" annotation(Dialog(group="Hysteresis"));

  extends BaseClasses.GenericHysteresisTellinen(      mu0=mu_0*K, sigma=mat.sigma);

protected
  constant SI.MagneticFluxDensity unitT=1;
  parameter SI.MagneticFluxDensity eps = unitT*mat.tabris[size(mat.tabris,1),2]/1000;

  Modelica.Blocks.Tables.CombiTable1Dv tabris(
    table=mat.tabris,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

  Modelica.Blocks.Tables.CombiTable1Dv tabfal(
    table=mat.tabfal,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

equation
  tabris.u[1]=Hstat;
  tabfal.u[1]=Hstat;

  hystR = unitT*tabris.y[1]+mu0*Hstat-eps;
  hystF = unitT*tabfal.y[1]+mu0*Hstat+eps;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}},
          textColor={255,128,0},
          textString="TT")}),
    Documentation(info="<html>

<p>
Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The rising and falling branch of the limiting ferromagnetic hysteresis loop are specified by table data. Therefore, almost any hysteresis shapes are possible. A library with predefined tables can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>.
</p>
<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
end GenericHystTellinenTable;

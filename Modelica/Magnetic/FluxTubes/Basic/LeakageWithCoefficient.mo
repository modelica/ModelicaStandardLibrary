within Modelica.Magnetic.FluxTubes.Basic;
model LeakageWithCoefficient
  "Leakage reluctance with respect to the reluctance of a useful flux path (not for dynamic simulation of actuators)"
  extends BaseClasses.Leakage;
  import Modelica.Constants.eps;
  parameter SI.CouplingCoefficient c_usefulFlux(final min=eps, final max=1-eps, start=0.7)
    "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux"
    annotation (Dialog(groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));
  Blocks.Interfaces.RealInput R_mUsefulTot(quantity="Reluctance", unit="H-1")
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
  // Generalized Kirchhoff's current law
  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Differently from the flux tube elements of package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
that are calculated from their geometry, this leakage reluctance is calculated with reference to the total reluctance of a useful flux path. Please refer to the <strong>Parameters</strong> section for an illustration of the resulting magnetic network. Exploiting <em>Kirchhoff</em>'s generalized current law, the leakage reluctance is calculated by means of a coupling coefficient c_usefulFlux.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png\" alt=\"Leakage with coefficient\">
</div>

<h4>Attention</h4>

<p>
This element must <strong>not</strong> be used <strong>for dynamic simulation of</strong> electro-magneto-mechanical <strong>actuators</strong>, where the shape of at least one flux tube element with reluctance force generation in the useful flux path changes with armature motion (e.g., air gap). This change results in a non-zero derivative dG_m/dx of those elements permeance G_m with respect to armature position x, which in turn will lead to a non-zero derivative of the leakage permeance with respect to armature position. This would generate a reluctance force in the leakage element that is not accounted for properly. <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Shapes.Force.LeakageAroundPoles</a> provides a simple leakage reluctance with force generation.
</p>
</html>"));
end LeakageWithCoefficient;

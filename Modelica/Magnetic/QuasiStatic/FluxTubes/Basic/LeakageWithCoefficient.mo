within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model LeakageWithCoefficient
"Leakage reluctance with respect to the reluctance of a useful flux path (not for dynamic simulation of actuators)"

  extends BaseClasses.Leakage;

  parameter SI.CouplingCoefficient c_usefulFlux=0.7
  "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux";

  input SI.Reluctance R_mUsefulTot
  "Total reluctance of useful flux path as reference"   annotation (Dialog(
        group="Reference reluctance", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));

equation
  (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
  // Generalized Kirchhoff's current law

  annotation (Documentation(info="<html>
<p>
Differently from the flux tube elements of package <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
that are calculated from their geometry, this leakage reluctance is calculated with reference to the total reluctance of a useful flux path. Parameter <code>c_usefulFlux</code> is the ratio of the useful flux over the total flux.
</p>
</html>"));
end LeakageWithCoefficient;

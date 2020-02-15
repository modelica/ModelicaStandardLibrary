within Modelica.Magnetic.FluxTubes.Basic;
model ConstantReluctance "Constant reluctance"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  parameter SI.Reluctance R_m=1 "Magnetic reluctance";

equation
  V_m = Phi*R_m;

  annotation (defaultComponentName="reluctance", Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-40},{150,-80}},
          textString="R_m=%R_m",
          textColor={0,0,0})}), Documentation(info="<html>
<p>
This constant reluctance is provided for test purposes and simple magnetic network models. The reluctance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>"));
end ConstantReluctance;

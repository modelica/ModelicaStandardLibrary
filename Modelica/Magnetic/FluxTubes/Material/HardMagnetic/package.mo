within Modelica.Magnetic.FluxTubes.Material;
package HardMagnetic "Characteristics of common permanent magnetic materials (temperature dependence considered)"
  extends Modelica.Icons.MaterialPropertiesPackage;

  annotation (Documentation(info="<html>
<p>
Typical values for remanence, coercivity and the temperature coefficient of remanence are provided for the common permanent magnetic materials illustrated below.</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HardMagnetic/HardMagneticMaterials.png\" alt=\"Demagnetization characteristics of included permanent magnetic materials\">
</dd>
</dl>
<p>
Linear demagnetization curves are modelled. The characteristic, temperature-dependent \"knee\" of many permanent magnetic materials is not considered, since proper design of permanent magnetic circuits should avoid operation of permanent magnets \"below\" that point due to partial demagnetization. As a result, the temperature coefficient of coercivity is not considered. Only the temperature coefficient of remanence alpha_Br is accounted for, since it describes the dependence of the demagnetization curve on the temperature sufficiently for the region \"above the knee-point\".
</p>
<p>
Additional user-specific materials can be defined as needed.
</p>
</html>"));
end HardMagnetic;

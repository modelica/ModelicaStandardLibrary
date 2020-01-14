within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryRotationalToTranslational
  "Partial model to transform rotational into translational motion"
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational;
  annotation (Documentation(info="<html>
<p>This is a 1-dim. rotational component with</p>
<ul>
<li>one rotational flange,</li>
<li>one rotational support/housing,</li>
<li>one translational flange, and</li>
<li>one translational support/housing</li>
</ul>
<p>This model is used to build up elementary components of a drive train transforming rotational into translational motion with equations in the text layer.</p>
<p>If <em>useSupportR=true</em>, the rotational support connector is conditionally enabled and needs to be connected.</p>
<p>If <em>useSupportR=false</em>, the rotational support connector is conditionally disabled and instead the rotational part is internally fixed to ground.</p>
<p>If <em>useSupportT=true</em>, the translational support connector is conditionally enabled and needs to be connected.</p>
<p>If <em>useSupportT=false</em>, the translational support connector is conditionally disabled and instead the translational part is internally fixed to ground.</p>
</html>"));
end PartialElementaryRotationalToTranslational;

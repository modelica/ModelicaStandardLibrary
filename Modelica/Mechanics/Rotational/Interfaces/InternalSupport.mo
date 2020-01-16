within Modelica.Mechanics.Rotational.Interfaces;
model InternalSupport
  "Adapter model to utilize conditional support connector"
  input Modelica.SIunits.Torque tau
    "External support torque (must be computed via torque balance in model where InternalSupport is used; = flange.tau)";
  Modelica.SIunits.Angle phi "External support angle (= flange.phi)";
  Flange_a flange
    "Internal support flange (must be connected to the conditional support connector for useSupport=true and to conditional fixed model for useSupport=false)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  flange.tau = tau;
  flange.phi = phi;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
              extent={{-20,20},{20,-20}},
              lineColor={135,135,135},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Text(
              extent={{-200,80},{200,40}},
              textColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
<p>
This is an adapter model to utilize a conditional support connector
in an elementary component, i.e., where the component equations are
defined textually:
</p>

<ul>
<li> If <em>useSupport = true</em>, the flange has to be connected to the conditional
     support connector.</li>
<li> If <em>useSupport = false</em>, the flange has to be connected to the conditional
     fixed model.</li>
</ul>

<p>
Variable <strong>tau</strong> is defined as <strong>input</strong> and must be provided when using
this component as a modifier (computed via a torque balance in
the model where InternalSupport is used). Usually, model InternalSupport is
utilized via the partial models:
</p>

<blockquote>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport\">
PartialElementaryOneFlangeAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport\">
PartialElementaryTwoFlangesAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">
PartialElementaryRotationalToTranslational</a>.
</blockquote>

<p>
Note, the support angle can always be accessed as internalSupport.phi, and
the support torque can always be accessed as internalSupport.tau.
</p>
</html>"));
end InternalSupport;

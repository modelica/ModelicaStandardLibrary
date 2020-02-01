within Modelica.Mechanics.Rotational.Interfaces;
model InternalSupport
  "Adapter model to utilize conditional support connector"
  input SI.Torque tau
    "External support torque (must be computed via torque balance in model where InternalSupport is used; = flange.tau)";
  SI.Angle phi "External support angle (= flange.phi)";
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
This is an adapter model to utilize a&nbsp;conditional
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Support\">support connector</a>
in a&nbsp;component. It could be applied to both textually (equations based) and graphically
defined components:
</p>

<ul>
<li> If <em>useSupport = true</em>, this flange has to be connected to the conditional
     support connector.</li>
<li> If <em>useSupport = false</em>, this flange has to be connected to the conditional
     fixed model.</li>
</ul>

<p>
Variable <strong>tau</strong> is defined as <strong>input</strong>. It must be
provided as a&nbsp;modifier and computed via a&nbsp;torque balance when using this
model in textually defined components.
This approach of internal support is utilized, e.g., via the following partial models:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>

<p>
Note, the support angle can always be accessed as internalSupport.phi, and
the support torque can always be accessed as internalSupport.tau.
</p>
</html>"));
end InternalSupport;

within Modelica.Mechanics.Translational.Interfaces;
model InternalSupport
  "Adapter model to utilize conditional support connector"
  input SI.Force f
    "External support force (must be computed via force balance in model where InternalSupport is used; = flange.f)";
  SI.Position s "External support position (= flange.s)";
  Flange_a flange
    "Internal support flange (must be connected to the conditional support connector for useSupport=true and to conditional fixed model for useSupport=false)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  flange.f = f;
  flange.s = s;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-200,80},{200,40}},
              textColor={0,0,255},
              textString="%name"),Rectangle(
              extent={{-20,20},{20,-20}},
              lineColor={0,127,0},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
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
Variable <strong>f</strong> is defined as <strong>input</strong> and must be provided when using
this component as a modifier (computed via a force balance in
the model where InternalSupport is used). Usually, model InternalSupport is
utilized via the partial models:
</p>

<blockquote>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport\">
PartialElementaryOneFlangeAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport\">
PartialElementaryTwoFlangesAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">
PartialElementaryRotationalToTranslational</a>.
</blockquote>

<p>
Note, the support position can always be accessed as internalSupport.s, and
the support force can always be accessed as internalSupport.f.
</p>
</html>"));
end InternalSupport;

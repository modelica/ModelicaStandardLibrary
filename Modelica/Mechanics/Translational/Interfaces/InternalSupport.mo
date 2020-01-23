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
This is an adapter model to utilize a&nbsp;conditional
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.Support\">support connector</a>
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
Variable <strong>f</strong> is defined as <strong>input</strong>. It must be
provided as a&nbsp;modifier and computed via a&nbsp;force balance when using this
model in textually defined components.
This approach of internal support is utilized, e.g., via the following partial models:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>

<p>
Note, the support position can always be accessed as internalSupport.s, and
the support force can always be accessed as internalSupport.f.
</p>
</html>"));
end InternalSupport;

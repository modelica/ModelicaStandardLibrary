within Modelica.Mechanics.Translational.Interfaces;
connector Support "Support/housing flange of a one-dimensional translational component"
  extends Flange;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
              extent={{-60,60},{60,-60}},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),           Text(
              extent={{-160,110},{40,50}},
              textColor={0,127,0},
              textString="%name"),Rectangle(
              extent={{-40,-40},{40,40}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-90,-90},{90,90}},
              lineColor={0,127,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),Rectangle(
          extent={{-150,150},{150,-150}},
          fillColor={175,190,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),    Rectangle(
              extent={{-90,-90},{90,90}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This is a connector for 1-dim. translational mechanical systems and models
the support or housing of a shaft.
The following variables are defined in this connector:
</p>

<blockquote><pre>
s: Absolute position of the support/housing in [m].
f: Reaction force in the support/housing in [N].
</pre></blockquote>

<p>
The support connector is usually defined as conditional connector. It is most convenient to utilize it
</p>
<ul>
<li> For models to be build graphically (i.e., the model is build up by drag-and-drop
     from elementary components):<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>.<br>&nbsp;</li>
<li> For models to be build textually (i.e., elementary models):<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2\">PartialElementaryOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>
</html>"));
end Support;

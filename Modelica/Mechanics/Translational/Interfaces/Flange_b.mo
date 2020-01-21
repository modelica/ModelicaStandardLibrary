within Modelica.Mechanics.Translational.Interfaces;
connector Flange_b
  "One-dimensional translational flange (right, flange axis directed OUT OF cut plane)"
  extends Flange;

  annotation (
    defaultComponentName="flange_b",
    Documentation(info="<html>
<p>
This is a connector for 1-dim. translational mechanical systems which represents
a mechanical flange. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
OUT OF the cut plane. All vectors in the cut plane are resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-40,-40},{40,40}},
          lineColor={0,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-40,110},{160,50}},
          textColor={0,127,0},
          textString="%name")}));
end Flange_b;

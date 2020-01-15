within Modelica.Mechanics.Translational.Interfaces;
connector Flange "One-dimensional translational flange"

  SI.Position s "Absolute position of flange";
  flow SI.Force f "Cut force directed into flange";
  annotation (
    Documentation(info="<html>
<p>
This is a connector for 1D translational mechanical systems.
It has no icon definition and is only used by inheritance from
flange connectors to define different icons.
</p>
<p>
The following variables are defined in this connector:
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"));
end Flange;

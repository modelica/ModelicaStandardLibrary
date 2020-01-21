within Modelica.Mechanics.Rotational.Interfaces;
connector Flange "One-dimensional rotational flange"

  SI.Angle phi "Absolute rotation angle of flange";
  flow SI.Torque tau "Cut torque in the flange";
  annotation (
    Documentation(info="<html>
<p>
This is a connector for 1D rotational mechanical systems.
It has no icon definition and is only used by inheritance from
flange connectors to define different icons.
</p>
<p>
The following variables are defined in this connector:
</p>

<blockquote><pre>
phi: Absolute rotation angle of the flange in [rad].
tau: Cut-torque in the flange in [Nm].
</pre></blockquote>
</html>"));
end Flange;

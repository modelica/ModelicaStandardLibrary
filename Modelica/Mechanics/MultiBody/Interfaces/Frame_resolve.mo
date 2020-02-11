within Modelica.Mechanics.MultiBody.Interfaces;
connector Frame_resolve
  "Coordinate system fixed to the component used to express in which coordinate system a vector is resolved (non-filled rectangular icon)"
  extends Frame;

  annotation (defaultComponentName="frame_resolve",
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Rectangle(
            extent={{-10,10},{10,-10}},
            lineColor={95,95,95},
            pattern=LinePattern.Dot), Rectangle(
            extent={{-30,100},{30,-100}},
            lineColor={95,95,95},
            pattern=LinePattern.Dot,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.16), graphics={Text(
            extent={{-140,-50},{140,-90}},
            textString="%name"), Rectangle(
            extent={{-12,40},{12,-40}},
            lineColor={95,95,95},
            pattern=LinePattern.Dot,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This coordinate system is used to
express in which coordinate system a vector is resolved.
A component that uses a Frame_resolve connector has to set the
cut-force and cut-torque of this frame to zero. When connecting
from a Frame_resolve connector to another frame connector,
by default the connecting line has line style \"dotted\".
This component has a non-filled rectangular icon.
</p>
</html>"));
end Frame_resolve;

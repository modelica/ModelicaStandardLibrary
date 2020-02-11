within Modelica.Mechanics.MultiBody.Interfaces;
connector Frame
  "Coordinate system fixed to the component with one cut-force and cut-torque (no icon)"

  SI.Position r_0[3]
    "Position vector from world frame to the connector frame origin, resolved in world frame";
  Frames.Orientation R
    "Orientation object to rotate the world frame into the connector frame";
  flow SI.Force f[3] "Cut-force resolved in connector frame" annotation (
      unassignedMessage="All Forces cannot be uniquely calculated.
The reason could be that the mechanism contains
a planar loop or that joints constrain the
same motion. For planar loops, use for one
revolute joint per loop the joint
Joints.RevolutePlanarLoopConstraint instead of
Joints.Revolute.");
  flow SI.Torque t[3] "Cut-torque resolved in connector frame";
  annotation (Documentation(info="<html>
<p>
Basic definition of a coordinate system that is fixed to a mechanical
component. In the origin of the coordinate system the cut-force
and the cut-torque is acting. This component has no icon definition
and is only used by inheritance from frame connectors to define
different icons.
</p>
</html>"));
end Frame;

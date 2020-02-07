within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialGravityAcceleration "Interface for the gravity function used in the World object"
  extends Modelica.Icons.Function;
   input SI.Position r[3]
    "Position vector from world frame to actual point, resolved in world frame";
   output SI.Acceleration gravity[3]
    "Gravity acceleration at position r, resolved in world frame";
  annotation (Documentation(info="<html>
<p>
This partial function defines the interface to the gravity function
used in the World object. All gravity field functions must inherit
from this function. The input to the function is the absolute position
vector of a point in the gravity field, whereas the output is the
gravity acceleration at this point, resolved in the world frame.
</p>
</html>"));
end partialGravityAcceleration;

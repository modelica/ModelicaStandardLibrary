within Modelica.Mechanics.MultiBody.Types;
type RotationSequence = Modelica.Icons.TypeInteger[3] (min={1,1,1}, max={3,3,3})
  "Sequence of planar frame rotations with choices" annotation (
  preferredView="text",
  Evaluate=true,
  choices(
    choice={1,2,3} "{1,2,3} \"Cardan/Tait-Bryan angles\"",
    choice={3,1,3} "{3,1,3} \"Euler angles\"",
    choice={3,2,1} "{3,2,1}"));

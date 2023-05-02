within ModelicaServices.AnimationInterface.Frames;
record Orientation
  "Orientation object defining rotation from a frame 1 into a frame 2"
  extends Icons.Record;
  Real T[3, 3] "Transformation matrix from world frame to local frame";
  Types.AngularVelocity w[3]
    "Absolute angular velocity of local frame, resolved in local frame";
end Orientation;

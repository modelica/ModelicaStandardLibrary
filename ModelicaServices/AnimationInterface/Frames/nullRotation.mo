within ModelicaServices.AnimationInterface.Frames;
function nullRotation
  "Return orientation object that does not rotate a frame"
  extends Icons.Function;
  output Orientation R
    "Orientation object such that frame 1 and frame 2 are identical";
algorithm
  R := Orientation(T=identity(3),w= zeros(3));
end nullRotation;

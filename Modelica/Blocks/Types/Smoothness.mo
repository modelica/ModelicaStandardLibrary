within Modelica.Blocks.Types;
type Smoothness = enumeration(
    LinearSegments "Table points are linearly interpolated",
    ContinuousDerivative
      "Table points are interpolated (by Akima splines) such that the first derivative is continuous",
    ConstantSegments
      "Table points are not interpolated, but the value from the previous abscissa point is returned",
    MonotoneContinuousDerivative1
      "Table points are interpolated (by Fritsch-Butland splines) such that the monotonicity is preserved and the first derivative is continuous",
    MonotoneContinuousDerivative2
      "Table points are interpolated (by Steffen splines) such that the monotonicity is preserved and the first derivative is continuous",
    ModifiedContinuousDerivative
      "Table points are interpolated (by modified Akima splines) such that the first derivative is continuous and shortcomings of the original Akima method are avoided")
  "Enumeration defining the smoothness of table interpolation";

within Modelica.Blocks.Types;
type Extrapolation = enumeration(
    HoldLastPoint
    "Hold the first/last table point outside of the table scope",
    LastTwoPoints
    "Extrapolate by using the derivative at the first/last table points outside of the table scope",
    Periodic
           "Repeat the table scope periodically",
    NoExtrapolation
                  "Extrapolation triggers an error")
"Enumeration defining the extrapolation of table interpolation";

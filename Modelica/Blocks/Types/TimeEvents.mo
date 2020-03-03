within Modelica.Blocks.Types;
type TimeEvents = enumeration(
    Always
         "Always generate time events at interval boundaries",
    AtDiscontinuities
                    "Generate time events at discontinuities (defined by duplicated sample points)",
    NoTimeEvents
               "No time events at interval boundaries")
"Enumeration defining the time event handling of time table interpolation";

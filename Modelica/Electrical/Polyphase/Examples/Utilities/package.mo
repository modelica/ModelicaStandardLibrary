within Modelica.Electrical.Polyphase.Examples;
package Utilities "Utilities for Examples"
  extends Icons.UtilitiesPackage;

type Connection = enumeration(
    Series   "Subsystems connected in series",
    Parallel   "Subsystems connected in parallel")
  "Enumeration defining the connection of subsystems";

end Utilities;

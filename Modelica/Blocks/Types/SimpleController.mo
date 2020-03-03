within Modelica.Blocks.Types;
type SimpleController = enumeration(
    P
     "P controller",
    PI
      "PI controller",
    PD
      "PD controller",
    PID
       "PID controller")
 "Enumeration defining P, PI, PD, or PID simple controller type" annotation (
  Evaluate=true);

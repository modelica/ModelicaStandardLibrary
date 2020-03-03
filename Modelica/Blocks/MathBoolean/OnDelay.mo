within Modelica.Blocks.MathBoolean;
block OnDelay
  "Delay a rising edge of the input, but do not delay a falling edge."
      extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
      parameter SI.Time delayTime "Delay time";

protected
      Boolean delaySignal(start=false,fixed=true);
      discrete SI.Time t_next;
initial equation
      pre(u) = false;
      pre(t_next) = time - 1;
algorithm
      when initial() then
         delaySignal := u;
         t_next := time - 1;
      elsewhen u then
         delaySignal := true;
         t_next := time + delayTime;
      elsewhen not u then
         delaySignal := false;
         t_next := time - 1;
      end when;
equation
      if delaySignal then
         y = time >= t_next;
      else
         y = false;
      end if;
      annotation (Icon(graphics={
          Text(
            extent={{-250,-120},{250,-150}},
            textString="%delayTime s"),
          Line(points={{-80,-66},{-60,-66},{-60,-22},{38,-22},{38,-66},{66,-66}}),
          Line(points={{-80,32},{-4,32},{-4,76},{38,76},{38,32},{66,32}},
              color={255,0,255})}),
                                 Documentation(info="<html>
<p>
A rising edge of the Boolean input u gives a delayed output.
A falling edge of the input is immediately given to the output.
</p>

<p>
Simulation results of a typical example with a delay time of 0.1 s
is shown in the next figure.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay1.png\"
     alt=\"OnDelay1.png\">
<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay2.png\"
     alt=\"OnDelay2.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
end OnDelay;

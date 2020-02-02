within Modelica.Electrical.Polyphase.Interfaces;
connector Plug "Polyphase electrical plug with m pins"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Electrical.Analog.Interfaces.Pin pin[m] "Pins of the plug";

  annotation (Documentation(info="<html>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-100,-99},{100,-179}},
          textColor={0,0,255},
          textString="%name")}));
end Plug;

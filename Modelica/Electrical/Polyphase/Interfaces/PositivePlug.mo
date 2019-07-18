within Modelica.Electrical.Polyphase.Interfaces;
connector PositivePlug "Positive polyphase electrical plug with m pins"
  extends Plug;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</html>"));
end PositivePlug;

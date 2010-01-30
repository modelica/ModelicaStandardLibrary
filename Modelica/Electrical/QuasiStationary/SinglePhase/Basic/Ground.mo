within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model Ground "Electrical ground"

  QuasiStationary.SinglePhase.Interfaces.PositivePin pin 
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
equation
  pin.v = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-60,50},{60,50}}),
        Line(points={{-40,30},{40,30}}),
        Line(points={{-20,10},{20,10}}),
        Line(points={{0,90},{0,50}}),
        Text(extent={{100,-40},{-100,0}}, textString=
                                            "%name")}),Diagram(graphics),
    Documentation(info="<html>
<p>
Ground of a single phase circuit. The potential at the ground node is zero. 
Every electrical circuit, e.g. a series resonance
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          example</a>, has to contain at least one ground object. 
</p>
 
</html>"));
end Ground;

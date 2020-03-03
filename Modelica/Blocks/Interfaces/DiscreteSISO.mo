within Modelica.Blocks.Interfaces;
partial block DiscreteSISO
  "Single Input Single Output discrete control block"

  extends DiscreteBlock;

  Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one input and one output signal
which are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
end DiscreteSISO;

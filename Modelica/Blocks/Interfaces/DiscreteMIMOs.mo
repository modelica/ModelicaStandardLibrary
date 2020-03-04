within Modelica.Blocks.Interfaces;
partial block DiscreteMIMOs
  "Multiple Input Multiple Output discrete control block"
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  extends DiscreteBlock;

  Modelica.Blocks.Interfaces.RealInput u[n] "Connector of Real input signals"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (Documentation(info="<html>
<p>
Block has a input and a output signal vector
where the signal sizes of the input and output vector are identical.
These signals are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));

end DiscreteMIMOs;

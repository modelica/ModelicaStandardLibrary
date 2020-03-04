within Modelica.Blocks.Interfaces;
partial block DiscreteMIMO
  "Multiple Input Multiple Output discrete control block"

  extends DiscreteBlock;
  parameter Integer nin=1 "Number of inputs";
  parameter Integer nout=1 "Number of outputs";

  Modelica.Blocks.Interfaces.RealInput u[nin] "Connector of Real input signals"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[nout] "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (Documentation(info="<html>
<p>
Block has a input and a output signal vector
which are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
end DiscreteMIMO;

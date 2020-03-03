within Modelica.Blocks.Interfaces;
partial block SIMO "Single Input Multiple Output continuous control block"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer nout=1 "Number of outputs";
  RealInput u "Connector of Real input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

  annotation (Documentation(info="<html>
<p> Block has one continuous Real input signal and a
    vector of continuous Real output signals.</p>

</html>"));
end SIMO;

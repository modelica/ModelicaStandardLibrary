within Modelica.Blocks.Examples.Noise.Utilities;
block WeibullDensity "Calculates the density of a Weibull distribution"
  import distribution = Modelica.Math.Distributions.Weibull.density;
  extends Modelica.Blocks.Icons.Block;

  parameter Real lambda(min=0)
    "Scale parameter of the Weibull distribution";
  parameter Real k(min=0) "Shape parameter of the Weibull distribution";

  Modelica.Blocks.Interfaces.RealInput u "Real input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Density of the input signal according to the Weibull probability density function"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = distribution(u, lambda, k);

  annotation (Icon(graphics={
        Polygon(
          points={{0,94},{-8,72},{8,72},{0,94}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,76},{0,-72}}, color={192,192,192}),
        Line(points={{-86,-82},{72,-82}},
                                      color={192,192,192}),
        Polygon(
          points={{92,-82},{70,-74},{70,-90},{92,-82}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
    Line( points={{-70,-75.953},{-66.5,-75.8975},{-63,-75.7852},{-59.5,
          -75.5674},{-56,-75.1631},{-52.5,-74.4442},{-49,-73.2213},{
          -45.5,-71.2318},{-42,-68.1385},{-38.5,-63.5468},{-35,-57.0467},
          {-31.5,-48.2849},{-28,-37.0617},{-24.5,-23.4388},{-21,-7.8318},
          {-17.5,8.9428},{-14,25.695},{-10.5,40.9771},{-7,53.2797},{
          -3.5,61.2739},{0,64.047},{3.5,61.2739},{7,53.2797},{10.5,
          40.9771},{14,25.695},{17.5,8.9428},{21,-7.8318},{24.5,
          -23.4388},{28,-37.0617},{31.5,-48.2849},{35,-57.0467},{38.5,
          -63.5468},{42,-68.1385},{45.5,-71.2318},{49,-73.2213},{52.5,
          -74.4442},{56,-75.1631},{59.5,-75.5674},{63,-75.7852},{66.5,
          -75.8975},{70,-75.953}},
          smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This block determines the probability density y of a Weibull distribution for the given input signal u
(for details of this density function see
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Math.Distributions.Weibull.density</a>).
</p>

<p>
This block is demonstrated in the example
<a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.Densities\">Examples.NoiseExamples.Densities</a> .
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end WeibullDensity;

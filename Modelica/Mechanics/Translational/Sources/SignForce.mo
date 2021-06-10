within Modelica.Mechanics.Translational.Sources;
model SignForce "Constant force changing sign with speed"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  import Modelica.Constants.pi;
  parameter SI.Force f_nominal
    "Nominal force (if negative, force is acting as load)";
  parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp
    "Type of regularization" annotation(Evaluate=true);
  parameter SI.Velocity v0(final min=Modelica.Constants.eps, start=0.1)
    "Regularization below v0";
  SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
equation
  v = der(s);
  if reg==Modelica.Blocks.Types.Regularization.Exp then
    f = -f_nominal*(2/(1 + Modelica.Math.exp(-v/(0.01*v0)))-1);
  elseif reg==Modelica.Blocks.Types.Regularization.Sine then
    f = -f_nominal*smooth(1, (if abs(v)>=v0 then sign(v) else Modelica.Math.sin(pi/2*v/v0)));
  elseif reg==Modelica.Blocks.Types.Regularization.Linear then
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else (v/v0));
  else//if reg==Modelica.Blocks.Types.Regularization.CoSine
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else sign(v)*(1 - Modelica.Math.cos(pi/2*v/v0)));
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{0,66},{0,-20}}, color={192,192,192}),
          Line(points={{-75,24},{75,24}},
                                        color={192,192,192}),
        Line(points={{-74,-12},{-8,-12},{-6,-10},{6,58},{8,60},{74,60}},
          color={0,0,127})}),
    Documentation(info="<html>
<p>Model of constant force which changes sign with direction of movement.</p>
<p>Please note:<br>
Positive force accelerates in both directions of movement.<br>
Negative force brakes in both directions of movement.</p>
<p>Around zero speed regularization avoids numerical problems.</p>
</html>"));
end SignForce;

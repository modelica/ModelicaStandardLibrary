within Modelica.Mechanics.Rotational.Sources;
model SignTorque "Constant torque changing sign with speed"
  extends Rotational.Interfaces.PartialTorque;
  import Modelica.Constants.pi;
  parameter SI.Torque tau_nominal
    "Nominal torque (if negative, torque is acting as load)";
  parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp
    "Type of regularization" annotation(Evaluate=true);
  parameter SI.AngularVelocity w0(final min=Modelica.Constants.eps, start=0.1)
    "Regularization below w0";
  SI.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  SI.Torque tau
    "Accelerating torque acting at flange (= -flange.tau)";
equation
  w = der(phi);
  tau = -flange.tau;
  if reg==Modelica.Blocks.Types.Regularization.Exp then
    tau = tau_nominal*(2/(1 + Modelica.Math.exp(-w/(0.01*w0)))-1);
  elseif reg==Modelica.Blocks.Types.Regularization.Sine then
    tau = tau_nominal*smooth(1, (if abs(w)>=w0 then sign(w) else Modelica.Math.sin(pi/2*w/w0)));
  elseif reg==Modelica.Blocks.Types.Regularization.Linear then
    tau = tau_nominal*(if abs(w)>=w0 then sign(w) else (w/w0));
  else//if reg==Modelica.Blocks.Types.Regularization.CoSine
    tau = tau_nominal*(if abs(w)>=w0 then sign(w) else sign(w)*(1 - Modelica.Math.cos(pi/2*w/w0)));
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
          Text(
            extent={{-120,-50},{120,-20}},
          textString="%tau_nominal"),
          Line(points={{-75,24},{75,24}},
                                        color={192,192,192}),
          Line(points={{0,66},{0,-20}}, color={192,192,192}),
        Line(points={{-74,-12},{-8,-12},{-6,-10},{6,58},{8,60},{48,60}},
          color={0,0,127})}),
    Documentation(info="<html>
<p>Model of constant torque which changes sign with direction of rotation.</p>
<p>Please note:<br>
Positive torque accelerates in both directions of rotation.<br>
Negative torque brakes in both directions of rotation.</p>
<p>Around zero speed regularization avoids numerical problems.</p>
</html>"));
end SignTorque;

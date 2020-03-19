within Modelica.Mechanics.Rotational.Examples.Utilities;
model DirectInertia "Input/output block of a direct inertia model"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Inertia J(min=0)=1 "Inertia";
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=J,
    phi(start=0, fixed=true),
    w(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torqueSource
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput tauDrive(unit="N.m")
    "Accelerating torque acting at flange (= -flange.tau)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Components.TorqueToAngleAdaptor
    torqueToAngle
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
    "Inertia moves with angle phi due to torque tau"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
    "Inertia moves with speed w due to torque tau"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
    "Inertia moves with acceleration a due to torque tau"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
    "Torque to drive the inertia" annotation (Placement(
        transformation(extent={{140,-100},{100,-60}})));
equation
  connect(tauDrive, torqueSource.tau)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(torqueSource.flange, inertia.flange_a)
    annotation (Line(points={{-30,0},{-20,0}}));
  connect(inertia.flange_b, torqueToAngle.flange)
    annotation (Line(points={{0,0},{18,0}}));
  connect(torqueToAngle.phi, phi) annotation (Line(points={{23,8},{40,8},
          {40,80},{110,80}}, color={0,0,127}));
  connect(torqueToAngle.w, w) annotation (Line(points={{23,3},{60,3},{60,
          30},{110,30}}, color={0,0,127}));
  connect(torqueToAngle.a, a) annotation (Line(points={{23,-3},{60,-3},{
          60,-30},{110,-30}}, color={0,0,127}));
  connect(torqueToAngle.tau, tau) annotation (Line(points={{24,-8},{40,-8},
          {40,-80},{120,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{-84,-58},{24,-90}},
                textColor={135,135,135},
                textString="to FMU"),Text(
                extent={{8,96},{92,66}},
                horizontalAlignment=TextAlignment.Right,
          textString="phi"),                            Text(
                extent={{10,46},{94,16}},
                horizontalAlignment=TextAlignment.Right,
          textString="w"),   Text(
                extent={{10,-10},{94,-40}},
                horizontalAlignment=TextAlignment.Right,
                textString="a"),Text(
                extent={{-150,-110},{150,-140}},
                textString="J=%J"),Bitmap(extent={{-96,-42},{64,54}},
            fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/DirectInertia.png"),
          Text( extent={{10,-60},{94,-90}},
                horizontalAlignment=TextAlignment.Right,
          textString="tau")}), Documentation(info="<html>
<p>
A rotational component with pure signal interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
The input torque <code>tauDrive</code> is applied on one side of a rotational
component with inertia whereby the input torque <code>tau</code> is applied
on the other side of it.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Utilities.InverseInertia\">InverseInertia</a>.
</p>
</html>"));
end DirectInertia;

within Modelica.Electrical.Machines.Interfaces;
partial model PartialBasicMachine "Partial model for all machines"
  import Modelica.Constants.pi;
  extends Machines.Icons.TransientMachine;
  parameter SI.Inertia Jr "Rotor's moment of inertia";
  parameter Boolean useSupport=false
    "Enable / disable (=fixed stator) support" annotation (Evaluate=true);
  parameter SI.Inertia Js=Jr "Stator's moment of inertia"
                                 annotation (Dialog(enable=useSupport));
  parameter Boolean useThermalPort=false
    "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Machines.Losses.FrictionParameters frictionParameters
    "Friction loss parameter record" annotation (Dialog(tab="Losses"));
  output SI.Angle phiMechanical(start=0) = flange.phi -
    internalSupport.phi "Mechanical angle of rotor against stator";
  output SI.AngularVelocity wMechanical(
    displayUnit="rev/min",
    start=0) = der(phiMechanical)
    "Mechanical angular velocity of rotor against stator";
  output SI.Torque tauElectrical=inertiaRotor.flange_a.tau
    "Electromagnetic torque";
  output SI.Torque tauShaft=-flange.tau "Shaft torque";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=Jr)
    annotation (Placement(transformation(
        origin={80,0},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
    "Support at which the reaction torque is acting" annotation (Placement(
        transformation(extent={{90,-110},{110,-90}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=Js)
    annotation (Placement(transformation(
        origin={80,-100},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-100})));
  Machines.Losses.Friction friction(final frictionParameters=frictionParameters)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={90,
            -40})));
protected
  Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
    annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
equation
  connect(inertiaRotor.flange_b, flange) annotation (Line(points={{90,0},{
          92,0},{92,0},{100,0}}));
  connect(inertiaStator.flange_b, support)
    annotation (Line(points={{90,-100},{100,-100}}));
  connect(internalSupport, fixed.flange) annotation (Line(
      points={{60,-100},{50,-100}}));
  connect(internalSupport, inertiaStator.flange_a) annotation (Line(
      points={{60,-100},{70,-100}}));
  connect(inertiaRotor.flange_b, friction.flange) annotation (Line(
      points={{90,0},{90,-30}}));
  connect(friction.support, internalSupport) annotation (Line(
      points={{90,-50},{90,-90},{60,-90},{60,-100}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-120},{150,-160}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{80,-80},{120,-120}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          visible=not useSupport,
          points={{80,-100},{120,-100}}),
        Line(
          visible=not useSupport,
          points={{90,-100},{80,-120}}),
        Line(
          visible=not useSupport,
          points={{100,-100},{90,-120}}),
        Line(
          visible=not useSupport,
          points={{110,-100},{100,-120}}),
        Line(
          visible=not useSupport,
          points={{120,-100},{110,-120}})}), Documentation(info="<html>
Base partial model DC machines:
<ul>
<li>main parts of the icon</li>
<li>mechanical shaft</li>
<li>mechanical support</li>
</ul>
Besides the mechanical connector <em>flange</em> (i.e., the shaft) the machines have a second mechanical connector <em>support</em>.<br>
If <em>useSupport</em> = false, it is assumed that the stator is fixed.<br>
Otherwise reaction torque (i.e., air gap torque, minus acceleration torque for stator's moment of inertia) can be measured at <em>support</em>.<br>
One may also fix the shaft and let rotate the stator; parameter Js is only of importance when the stator is rotating.
</html>"));
end PartialBasicMachine;

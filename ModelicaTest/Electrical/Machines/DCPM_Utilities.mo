within ModelicaTest.Electrical.Machines;
package DCPM_Utilities "Utilities for DC_Drives"
  extends Modelica.Icons.UtilitiesPackage;
  model DCPM "Simple DC PM model"
    extends Modelica.Electrical.Machines.Icons.Machine;
    parameter MachineData machineData
      annotation (Placement(transformation(extent={{60,40},{80,60}})));
    output Modelica.Units.SI.Current iA(start=0) = resistor.i
      "Armature current";
    output Modelica.Units.SI.Angle phi(start=0) = shaft.phi "Shaft angle";
    Modelica.Blocks.Interfaces.RealOutput w(start=0, unit="rad/s", displayUnit="1/min")
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,0})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive armature pin"
      annotation (Placement(transformation(extent={{50,90},{70,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative armature pin"
      annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft "Shaft"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=machineData.RA,
        T_ref=293.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,60})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=machineData.LA)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,30})));
    Modelica.Electrical.Analog.Basic.RotationalEMF emf(k=machineData.kPhi)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,0})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=machineData.J)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-30})));
  equation
    connect(resistor.n, inductor.p)
      annotation (Line(points={{-1.77636e-15,50},{0,50},{0,40},{0,40}},color={0,0,255}));
    connect(inductor.n, emf.p)
      annotation (Line(points={{-1.77636e-15,20},{0,20},{0,10}},color={0,0,255}));
    connect(emf.flange, inertia.flange_a)
      annotation (Line(points={{10,0},{40,0}}, color={0,0,0}));
    connect(resistor.p, pin_p)
      annotation (Line(points={{0,70},{0,80},{60,80},{60,100}}, color={0,0,255}));
    connect(emf.n, pin_n)
      annotation (Line(points={{0,-10},{0,-20},{-60,-20},{-60,100}}, color={0,0,255}));
    connect(inertia.flange_b, shaft)
      annotation (Line(points={{60,0},{100,0}}, color={0,0,0}));
    connect(inertia.flange_b, speedSensor.flange)
      annotation (Line(points={{60,0},{80,0},{80,-20}}, color={0,0,0}));
    connect(speedSensor.w, w)
      annotation (Line(points={{80,-41},{80,-60},{-80,-60}, {-80,0},{-110,0}}, color={0,0,127}));
    annotation (
      Icon(graphics={Text(
            extent={{-100,-100},{100,-140}},
            textColor={28,108,200},
            textString="%name")}), Documentation(info="<html>
<p>
Simple model of a DC PM machine, comprising armature resistance, armature inductance, emf (including torque generation), inertia and speed measurement.
</p>
</html>"));
  end DCPM;

  record DriveData "Parameters of the whole drive"
    extends Modelica.Icons.Record;
    import Modelica.Constants.pi;
    replaceable parameter
      ModelicaTest.Electrical.Machines.DCPM_Utilities.MachineData machineData
      annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,
              40},{10,60}})));

    parameter ControllerData controllerData(
      kpI=machineData.LA/(2*Td),
      TiI=machineData.LA/machineData.RA,
      Tsub=2*Td,
      kpw=(machineData.J + JL)/(2*controllerData.Tsub),
      Tiw=4*controllerData.Tsub)
      annotation (Placement(transformation(extent={{-10,0},{10,20}})));
    parameter Modelica.Units.SI.Inertia JL=machineData.J "Load inertia";
    parameter Modelica.Units.SI.Voltage VBat=1.2*machineData.VANominal
      "Battery voltage";
    parameter Modelica.Units.SI.Current IMax=1.5*machineData.IANominal
      "Max. armature current";
    parameter Modelica.Units.SI.Frequency fSwitch=1e3 "Switching frequency";
    parameter Modelica.Units.SI.Time Td=0.5/fSwitch "Dead time of inverter"
      annotation (Dialog(enable=false));
    annotation(defaultComponentPrefixes="parameter", defaultComponentName="driveData",
      Documentation(info="<html>
<p>
The drive parameter record contains the machine parameter record, additional parameters and fills the controller parameter record.
Simulating another machine (with different parameters), the machine parameter record can be redeclared.
</p>
</html>"));
  end DriveData;

  record ControllerData "Controller parameters"
    extends Modelica.Icons.Record;
    parameter Real kpI "Proportional gain of current controller";
    parameter Modelica.Units.SI.Time TiI
      "Integral time constant of current controller";
    parameter Modelica.Units.SI.Time Tsub "Substitute time constant";
    parameter Real kpw "Proportional gain of speed controller";
    parameter Modelica.Units.SI.Time Tiw
      "Integral time constant of speed controller";
    annotation(defaultComponentPrefixes="parameter", defaultComponentName="controllerData",
      Documentation(info="<html>
<p>
The controller parameter record is used in the drive parameters record, and filled in that record (based on the machine parameters).
</p>
</html>"));
  end ControllerData;

  record MachineData "Standard machine parameters"
    extends Modelica.Icons.Record;
    import Modelica.Constants.pi;
    parameter Modelica.Units.SI.Voltage VANominal=100
      "Nominal armature voltage";
    parameter Modelica.Units.SI.Current IANominal=100
      "Nominal armature current";
    parameter Modelica.Units.SI.AngularVelocity wNominal=1425*pi/30
      "Nominal speed";
    parameter Modelica.Units.SI.Resistance RA=0.05 "Armature resistance";
    parameter Modelica.Units.SI.Inductance LA=0.0015 "Armature inductance";
    parameter Modelica.Units.SI.Voltage ViNominal=VANominal - RA*IANominal
      "Nominal induced voltage" annotation (Dialog(enable=false));
    parameter Modelica.Units.SI.ElectricalTorqueConstant kPhi=ViNominal/
        wNominal "Flux constant";
    parameter Modelica.Units.SI.Inertia J=0.29 "Rotor inertia";
    parameter Modelica.Units.SI.Torque tauNominal=kPhi*IANominal
      "Nominal torque" annotation (Dialog(enable=false));
    annotation(defaultComponentPrefixes="parameter", defaultComponentName="machineData",
      Documentation(info="<html>
<p>
The machine parameter record contains all necessary parameters of a DC PM machine.
It is used to parameterize the DCPM model, and it is used in the drive parameter record.
Extending from this record, the parameters of other machines (with different parameters) can be saved.
</p>
</html>"));
  end MachineData;

  record M48V "Real machine 48 V"
    import Modelica.Constants.pi;
    extends ModelicaTest.Electrical.Machines.DCPM_Utilities.MachineData(
      VANominal=48,
      IANominal=25,
      wNominal=3500*pi/30,
      RA=0.24,
      LA=0.004,
      J=0.0008);
    annotation(defaultComponentPrefixes="parameter", defaultComponentName="machineData",
      Documentation(info="<html>
<p>
Machine parameters of a real 48 W / 1 kW DCPM machine.
</p>
</html>"));
  end M48V;
end DCPM_Utilities;

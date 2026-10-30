within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
partial model PartialControlledDCPM
  "Partial controlled DC PM drive with H-bridge from battery"
  extends Modelica.Icons.Example;
  replaceable parameter DriveDataDCPM driveData constrainedby
    ControlledDCDrives.Utilities.DriveDataDCPM "DC machine data"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=driveData.JL)
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-70})));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    TaOperational=driveData.motorData.TaNominal,
    VaNominal=driveData.motorData.VaNominal,
    IaNominal=driveData.motorData.IaNominal,
    wNominal=driveData.motorData.wNominal,
    TaNominal=driveData.motorData.TaNominal,
    Ra=driveData.motorData.Ra,
    TaRef=driveData.motorData.TaRef,
    La=driveData.motorData.La,
    Jr=driveData.motorData.Jr,
    frictionParameters=driveData.motorData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    coreParameters=driveData.motorData.coreParameters,
    strayLoadParameters=driveData.motorData.strayLoadParameters,
    brushParameters=driveData.motorData.brushParameters,
    ia(fixed=true),
    Js=driveData.motorData.Js,
    alpha20a=driveData.motorData.alpha20a)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  DcdcInverter armatureInverter(
    fS=driveData.fS,
    Td=driveData.Td,
    Tmf=driveData.Tmf,
    VMax=driveData.VaMax)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  LimitedPI currentController(
    constantLimits=false,
    k=driveData.kpI,
    Ti=driveData.TiI,
    KFF=driveData.kPhi,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    useFF=true)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Blocks.Math.Gain tau2i(k=1/driveData.kPhi) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,-10})));
  Analog.Sources.ConstantVoltage constantVoltage(V=
        driveData.VBat)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Analog.Basic.Resistor resistor(R=0.05*driveData.VBat/driveData.motorData.IaNominal)
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,50})));
  Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,70})));
equation
  connect(dcpm.flange, loadInertia.flange_a)
    annotation (Line(points={{40,-40},{50,-40}}));
  connect(speedSensor.flange, dcpm.flange)
    annotation (Line(points={{50,-60},{50,-40},{40,-40}}));
  connect(armatureInverter.pin_nMot, dcpm.pin_an)
    annotation (Line(points={{24,-20},{24,-30},{24,-30}},
                                                 color={0,0,255}));
  connect(armatureInverter.pin_pMot, dcpm.pin_ap)
    annotation (Line(points={{36,-20},{36,-30},{36,-30}},
                                                 color={0,0,255}));
  connect(armatureInverter.vDC, currentController.yMaxVar)
    annotation (Line(points={{19,-4},{-28,-4}}, color={0,0,127}));
  connect(armatureInverter.vRef, currentController.y)
    annotation (Line(points={{18,-10},{-29,-10}}, color={0,0,127}));
  connect(armatureInverter.iMot, currentController.u_m) annotation (
      Line(points={{19,-16},{-20,-16},{-20,-30},{-46,-30},{-46,-22}},
        color={0,0,127}));
  connect(speedSensor.w, currentController.feedForward) annotation (Line(
        points={{50,-81},{50,-90},{-40,-90},{-40,-22}},
                                                     color={0,0,127}));
  connect(tau2i.y, currentController.u)
    annotation (Line(points={{-59,-10},{-52,-10}}, color={0,0,127}));
  connect(ground.p, constantVoltage.n)
    annotation (Line(points={{0,80},{20,80}}, color={0,0,255}));
  connect(constantVoltage.n, armatureInverter.pin_nBat) annotation (Line(points
        ={{20,80},{20,20},{24,20},{24,0}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p)
    annotation (Line(points={{40,80},{40,60}}, color={0,0,255}));
  connect(resistor.n, armatureInverter.pin_pBat) annotation (Line(points={{40,
          40},{40,20},{36,20},{36,0}}, color={0,0,255}));
  annotation (Documentation(info="<html>
  <p>This is a partial model of a controlled DC PM drive.</p>
<p>
Electrical power is taken from a battery (constant voltage with inner resistance) and fed to the motor via a DC-DC inverter.
The level of detail of the DC-DC inverter may be chosen from ideal averaging or switching.
The DC-DC inverter is commanded by the current controller.
The current controller is parameterized according to the absolute optimum.
</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end PartialControlledDCPM;

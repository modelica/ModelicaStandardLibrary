within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
partial model PartialControlledDCPM
  "Partial controlled DC PM drive with H-bridge from battery"
  extends Modelica.Icons.Example;
  replaceable parameter DriveDataDCPM driveData constrainedby
    ControlledDCDrives.Utilities.DriveDataDCPM "DC machine data"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=driveData.JL)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-60})));
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
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  DcdcInverter armatureInverter(
    fS=driveData.fS,
    Tdv=driveData.Tdv,
    Tdm=driveData.Tdm,
    VMax=driveData.VaMax)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Battery source(
    INominal=driveData.motorData.IaNominal, V0=driveData.VBat)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,80})));
  LimitedPI currentController(
    constantLimits=false,
    k=driveData.kpI,
    Ti=driveData.TiI,
    KFF=driveData.kPhi,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    useFF=true)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.Gain tau2i(k=1/driveData.kPhi) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-40,0})));
equation
  connect(dcpm.flange, loadInertia.flange_a)
    annotation (Line(points={{40,-30},{50,-30}}));
  connect(speedSensor.flange, dcpm.flange)
    annotation (Line(points={{50,-50},{50,-30},{40,-30}}));
  connect(armatureInverter.pin_nMot, dcpm.pin_an)
    annotation (Line(points={{24,-10},{24,-20}}, color={0,0,255}));
  connect(armatureInverter.pin_pMot, dcpm.pin_ap)
    annotation (Line(points={{36,-10},{36,-20}}, color={0,0,255}));
  connect(armatureInverter.vDC, currentController.yMaxVar)
    annotation (Line(points={{19,6},{2,6}},     color={0,0,127}));
  connect(armatureInverter.vRef, currentController.y)
    annotation (Line(points={{18,0},{1,0}},       color={0,0,127}));
  connect(armatureInverter.iMot, currentController.u_m) annotation (
      Line(points={{19,-6},{10,-6},{10,-20},{-16,-20},{-16,-12}},
        color={0,0,127}));
  connect(speedSensor.w, currentController.feedForward) annotation (Line(
        points={{50,-71},{50,-80},{-10,-80},{-10,-12}},
                                                     color={0,0,127}));
  connect(tau2i.y, currentController.u)
    annotation (Line(points={{-29,0},{-22,0}},     color={0,0,127}));
  connect(source.pin_n, armatureInverter.pin_nBat) annotation (Line(points={{24,70},
          {24,10}},                    color={0,0,255}));
  connect(source.pin_p, armatureInverter.pin_pBat) annotation (Line(points={{36,70},
          {36,10}},                    color={0,0,255}));
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
    Diagram(coordinateSystem(extent={{-160,-100},{100,100}})));
end PartialControlledDCPM;

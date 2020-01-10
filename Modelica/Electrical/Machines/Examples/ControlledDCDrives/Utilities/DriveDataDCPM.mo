within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
record DriveDataDCPM
  "Parameters of a controlled DC permanent magnet drive"
  extends Modelica.Icons.Record;
  import Modelica.Electrical.Machines.Thermal.convertResistance;
//Motor
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
    motorData "Motor data" annotation (Dialog(group="Motor"), Placement(
        transformation(extent={{-10,-10},{10,10}})));
  parameter Modelica.SIunits.Resistance Ra=convertResistance(motorData.Ra,
      motorData.TaRef,motorData.alpha20a,motorData.TaNominal)
    "Armature resistance at nominal temperature"
    annotation(Dialog(group="Motor", enable=false));
  parameter Modelica.SIunits.Time Ta=motorData.La/Ra "Armature time constant"
    annotation(Dialog(group="Motor", enable=false));
  parameter Modelica.SIunits.Power PNominal=motorData.ViNominal*motorData.IaNominal
    -motorData.frictionParameters.PRef -motorData.coreParameters.PRef -motorData.strayLoadParameters.PRef
    "Nominal mechanical output"
    annotation(Dialog(group="Motor", enable=false));
  parameter Modelica.SIunits.Torque tauNominal=PNominal/motorData.wNominal
    "Nominal torque"
    annotation(Dialog(group="Motor", enable=false));
  parameter Modelica.SIunits.ElectricalTorqueConstant kPhi=tauNominal/motorData.IaNominal
    "Torque constant"
    annotation(Dialog(group="Motor", enable=false));
  parameter Modelica.SIunits.AngularVelocity w0=motorData.wNominal*motorData.VaNominal/motorData.ViNominal
    "No-load speed"
  annotation(Dialog(group="Motor", enable=false));
//Inverter
  parameter Modelica.SIunits.Frequency fS=2e3 "Switching frequency"
    annotation(Dialog(tab="Inverter", group="Armature inverter"));
  parameter Modelica.SIunits.Voltage VBat=VaMax "DC no-load voltage"
    annotation(Dialog(tab="Inverter", group="Armature inverter"));
  parameter Modelica.SIunits.Time Td=0.5/fS "Dead time of inverter"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
  parameter Modelica.SIunits.Time Tmf=4*Td "Measurement filter time constant"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
  parameter Modelica.SIunits.Time Tsigma=Td + Tmf "Sum of small time constants"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
//Load
  parameter Modelica.SIunits.Inertia JL=motorData.Jr "Load inertia"
    annotation(Dialog(group="Load"));
//Limits
  parameter Modelica.SIunits.Voltage VaMax=1.2*motorData.VaNominal "Maximum Voltage"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter Modelica.SIunits.Current IaMax=1.5*motorData.IaNominal "Maximum current"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter Modelica.SIunits.Torque tauMax=kPhi*IaMax "Maximum torque"
    annotation(Dialog(tab="Controller", group="Limits", enable=false));
  parameter Modelica.SIunits.AngularVelocity wMax=motorData.wNominal*motorData.VaNominal/motorData.ViNominal
    "Maximum speed"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter Modelica.SIunits.AngularAcceleration aMax=tauMax/(JL +motorData.Jr)
    "Maximum acceleration"
    annotation(Dialog(tab="Controller", group="Limits", enable=false));
//Current controller: absolute optimum
  parameter Real kpI=motorData.La/(2*Tsigma) "Proportional gain" annotation (
      Dialog(
      tab="Controller",
      group="Current controller",
      enable=false));
  parameter Modelica.SIunits.Time TiI=Ta "Integral time constant"
    annotation(Dialog(tab="Controller", group="Current controller", enable=false));
  parameter Modelica.SIunits.Time Tsub=2*Tsigma "Substitute time constant"
    annotation(Dialog(tab="Controller", group="Current controller", enable=false));
//Speed controller: symmetrical optimum
  parameter Real kpw=(JL + motorData.Jr)/(2*Tsub) "Proportional gain"
    annotation (Dialog(
      tab="Controller",
      group="Speed controller",
      enable=false));
  parameter Modelica.SIunits.Time Tiw=4*Tsub "Integral time constant"
    annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
  parameter Modelica.SIunits.Time Tfw=Tiw "Filter time constant"
    annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
//Position controller
  parameter Real kpP=1/(16*Tsub) "Proportional gain"
    annotation(Dialog(tab="Controller", group="Position controller", enable=false));
  annotation (
    defaultComponentName="dcpmDriveData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>
Calculates controller parameters of a DC permanent magnet drive:
Current controller according to absolute optimum, speed controller according to symmetric optimum.
</p>
</html>"));
end DriveDataDCPM;

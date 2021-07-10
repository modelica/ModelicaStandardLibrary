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
  parameter SI.Resistance Ra=convertResistance(motorData.Ra,
      motorData.TaRef,motorData.alpha20a,motorData.TaNominal)
    "Armature resistance at nominal temperature"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.Time Ta=motorData.La/Ra "Armature time constant"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.Power PNominal=motorData.ViNominal*motorData.IaNominal
    - motorData.coreParameters.PRef - motorData.frictionParameters.PRef - motorData.strayLoadParameters.PRef
    "Nominal mechanical output"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.Torque tauElNominal=(motorData.ViNominal*motorData.IaNominal - motorData.coreParameters.PRef)/motorData.wNominal
    "Nominal electrical torque"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.Torque tauNominal=PNominal/motorData.wNominal
    "Nominal shaft torque"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.ElectricalTorqueConstant kPhi=motorData.ViNominal/motorData.wNominal
    "Torque constant"
    annotation(Dialog(group="Motor", enable=false));
  parameter SI.AngularVelocity w0(displayUnit="rpm")=motorData.wNominal*motorData.VaNominal/motorData.ViNominal
    "No-load speed"
  annotation(Dialog(group="Motor", enable=false));
//Inverter
  parameter SI.Frequency fS=2e3 "Switching frequency"
    annotation(Dialog(tab="Inverter", group="Armature inverter"));
  parameter SI.Voltage VBat=VaMax "DC no-load voltage"
    annotation(Dialog(tab="Inverter", group="Armature inverter"));
  parameter SI.Time Tdv=0.5/fS "Dead time of inverter voltage"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
  parameter SI.Time Tdm=0.5/fS "Dead time of measurements"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
  parameter SI.Time Tsigma=Tdv + Tdm "Sum of small time constants"
    annotation(Dialog(tab="Inverter", group="Armature inverter", enable=false));
//Load
  parameter SI.Inertia JL=motorData.Jr "Load inertia"
    annotation(Dialog(group="Load"));
//Limits
  parameter SI.Voltage VaMax=1.2*motorData.VaNominal "Maximum voltage"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter SI.Current IaMax=1.5*motorData.IaNominal "Maximum current"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter SI.Torque tauMax=kPhi*IaMax "Maximum electrical torque"
    annotation(Dialog(tab="Controller", group="Limits", enable=false));
  parameter SI.AngularVelocity wMax=w0 "Maximum speed"
    annotation(Dialog(tab="Controller", group="Limits"));
  parameter SI.AngularAcceleration aMax=tauMax/(JL + motorData.Jr)
    "Maximum acceleration"
    annotation(Dialog(tab="Controller", group="Limits", enable=false));
//Current controller: absolute optimum
  parameter Real kpI=Ra*Ta/(2*Tsigma) "Proportional gain" annotation (
      Dialog(
      tab="Controller",
      group="Current controller",
      enable=false));
  parameter SI.Time TiI=Ta "Integral time constant"
    annotation(Dialog(tab="Controller", group="Current controller", enable=false));
  parameter SI.Time Tsub=2*Tsigma "Substitute time constant"
    annotation(Dialog(tab="Controller", group="Current controller", enable=false));
//Speed controller: symmetrical optimum
  parameter Real a=2 "Parameter of the symmetrical optimum"
    annotation (Dialog(
      tab="Controller",
      group="Speed controller"));
  parameter Real kpw=(JL + motorData.Jr)/(a*Tsub) "Proportional gain"
    annotation (Dialog(
      tab="Controller",
      group="Speed controller",
      enable=false));
  parameter SI.Time Tiw=a^2*Tsub "Integral time constant"
    annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
  parameter SI.Time Tfw=Tiw "Filter time constant"
    annotation(Dialog(tab="Controller", group="Speed controller", enable=false));
//Position controller
  parameter Real kpP=1/(16*Tsub) "Proportional gain"
    annotation(Dialog(tab="Controller", group="Position controller"));
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

within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE;
record BaseData "dummy"
  extends Modelica.Icons.Record;
  parameter String Type="BaseData";
  parameter Modelica.Magnetic.FluxTubes.Types.SpecificPower vRef=1.0
    "Specific losses at BRef and fRef";
  parameter SI.MagneticFluxDensity BRef=1.5 "Ref. flux density for spec. losses";
  parameter SI.Frequency fRef=50 "Ref. frequency for spec. losses";
  parameter SI.Density dens = 7600 "Density of material";
  parameter SI.RelativePermeability mu_ri= 1000 "Initial relative permeability";
  // Exponential Extrapolation
  parameter Integer k0                    =     20    "Start of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hpar =  10000.0 "Parameter of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hsat =  100000. "Saturation field strength"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticPolarization  Jsat =   2.0    "Saturation polarization"
    annotation(Dialog(group="Exponential Extrapolation"));
  // Homotopy
  parameter SI.MagneticFieldStrength hH1  =   5000.00 "Start of homotopy"
    annotation(Dialog(group="Homotopy"));
  parameter SI.MagneticFieldStrength hH2  =  20000.00 "End   of homotopy"
    annotation(Dialog(group="Homotopy"));
  // Length of Raw Data
  parameter Integer N    = 6 "Count of nodes"
    annotation(Dialog(tab="Smoothing Splines"));
  // Smoothing Spline coefficients
  parameter Real c3[:](each unit="V.s.m/A2")={0, 0, 0, 0, 0}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c2[:](each unit="V.s/A2")={0, 0, 0, 0, 0}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c1[:](each unit="V.s/(m.A)")={0, 0, 0, 0, 0}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c0[:](each unit="V.s/m2")={0, 0, 0, 0, 0}
    annotation(Dialog(tab="Smoothing Splines"));
  // Raw Data: Magnetic field strength H and Magnetic polarization J
  parameter SI.MagneticFieldStrength HD[:]={0, 0, 0, 0, 0, 0}
    annotation(Dialog(tab="Raw Data"));
  parameter SI.MagneticPolarization  JD[:]={0, 0, 0, 0, 0, 0}
    annotation(Dialog(tab="Raw Data"));
  annotation(defaultComponentPrefixes="parameter",
    defaultComponentName="material",
    Icon(coordinateSystem(preserveAspectRatio=false),
      graphics={Text(extent={{-100,-10},{100,-40}},
        textColor={0,0,255}, textString="%Type"), Text(
          extent={{-100,10},{100,40}},
          textColor={0,0,255},
          textString="SS + EE")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end BaseData;

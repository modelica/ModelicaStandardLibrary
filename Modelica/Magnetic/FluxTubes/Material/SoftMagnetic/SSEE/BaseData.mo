within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE;
record BaseData "CastIron"
  extends Modelica.Icons.Record;
  parameter String Type="CastIron";
  parameter FluxTubes.Types.SpecificPower vRef=25.
    "Specific losses at BRef and fRef";
  parameter SI.MagneticFluxDensity BRef=1.5 "Ref. flux density for spec. losses";
  parameter SI.Frequency fRef=50 "Ref. frequency for spec. losses";
  parameter SI.Density dens = 7500 "Density of material";
  parameter SI.RelativePermeability mu_ri= 155.80 "Initial relative permeability";
  // Exponential Extrapolation
  parameter Integer k0                    =     12    "Start of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hpar =  9901.06 "Parameter of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hsat = 132113.5 "Saturation field strength"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticPolarization  Jsat =  1.27765 "Saturation polarization"
    annotation(Dialog(group="Exponential Extrapolation"));
  // Homotopy
  parameter SI.MagneticFieldStrength hH1  =   5000.00 "Start of homotopy"
    annotation(Dialog(group="Homotopy"));
  parameter SI.MagneticFieldStrength hH2  =  15000.00 "End   of homotopy"
    annotation(Dialog(group="Homotopy"));
  // Length of Raw Data
  parameter Integer N    = 22 "Count of nodes"
    annotation(Dialog(tab="Smoothing Splines"));
  // Smoothing Spline coefficients
  parameter Real c3[:](each unit="V.s.m/A2")={
     1.05287e-10, 3.46651e-10,-1.34759e-10,-4.61913e-10,-1.76527e-10,
    -6.93774e-11, 7.12008e-12, 2.24874e-11, 3.31106e-11, 5.09619e-11,
     2.08923e-11, 2.78107e-12, 6.36022e-13, 8.74410e-14, 7.61594e-14,
     5.22203e-14, 4.77447e-14, 3.63249e-14, 4.27105e-14,-1.86138e-15,
     8.60434e-14}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c2[:](each unit="V.s/A2")={
     0.00000e+00, 6.31721e-08, 2.71163e-07, 1.49880e-07, 1.13056e-08,
    -9.46106e-08,-1.46644e-07,-1.43440e-07,-1.33320e-07,-1.13454e-07,
    -7.52325e-08,-1.25556e-08,-4.21242e-09,-2.30435e-09,-2.04203e-09,
    -1.81355e-09,-1.57856e-09,-1.36371e-09,-1.14576e-09,-8.89495e-10,
    -9.03455e-10}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c1[:](each unit="V.s/(m.A)")={
     1.94531e-04, 2.07166e-04, 2.74033e-04, 4.00345e-04, 4.16464e-04,
     3.99803e-04, 3.39489e-04, 2.95977e-04, 2.54463e-04, 2.05108e-04,
     1.57936e-04, 7.01484e-05, 5.33803e-05, 4.68636e-05, 4.25172e-05,
     3.86616e-05, 3.35735e-05, 2.91601e-05, 2.41411e-05, 2.00706e-05,
     1.55882e-05}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c0[:](each unit="V.s/m2")={
     0.00000e+00, 3.97486e-02, 8.64819e-02, 1.89458e-01, 2.30529e-01,
     3.12862e-01, 4.05816e-01, 4.53464e-01, 4.94709e-01, 5.40533e-01,
     5.85516e-01, 6.89112e-01, 7.49486e-01, 7.99290e-01, 8.43936e-01,
     8.84488e-01, 9.38576e-01, 9.85545e-01, 1.03870e+00, 1.08274e+00,
     1.12733e+00}
    annotation(Dialog(tab="Smoothing Splines"));
  // Raw Data: Magnetic field strength H and Magnetic polarization J
  parameter SI.MagneticFieldStrength HD[:]={
         0.00,   200.00,   400.00,   700.00,   800.00,  1000.00,  1250.00,
      1400.00,  1550.00,  1750.00,  2000.00,  3000.00,  4000.00,  5000.00,
      6000.00,  7000.00,  8500.00, 10000.00, 12000.00, 14000.00, 16500.00,
     20000.00}
    annotation(Dialog(tab="Raw Data"));
  parameter SI.MagneticPolarization  JD[:]={
      0.00000,  0.03975,  0.08648,  0.18946,  0.23053,  0.31286,  0.40582,
      0.45346,  0.49471,  0.54053,  0.58552,  0.68911,  0.74949,  0.79929,
      0.84394,  0.88449,  0.93858,  0.98555,  1.03870,  1.08274,  1.12733,
      1.17451}
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

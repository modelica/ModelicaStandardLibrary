within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE;
record BaseData "M270-50A"
  extends Modelica.Icons.Record;
  parameter String Type="M270-50A";
  parameter Modelica.Magnetic.FluxTubes.Types.SpecificPower vRef=2.7
    "Specific losses at BRef and fRef";
  parameter SI.MagneticFluxDensity BRef=1.5 "Ref. flux density for spec. losses";
  parameter SI.Frequency fRef=50 "Ref. frequency for spec. losses";
  parameter SI.Density dens = 7600 "Density of material";
  parameter SI.RelativePermeability mu_ri= 1902.23 "Initial relative permeability";
  // Exponential Extrapolation
  parameter Integer k0                    =     23    "Start of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hpar = 10284.44 "Parameter of EE"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticFieldStrength Hsat = 129186.5 "Saturation field strength"
    annotation(Dialog(group="Exponential Extrapolation"));
  parameter SI.MagneticPolarization  Jsat =  1.96017 "Saturation polarization"
    annotation(Dialog(group="Exponential Extrapolation"));
  // Homotopy
  parameter SI.MagneticFieldStrength hH1  =   5000.00 "Start of homotopy"
    annotation(Dialog(group="Homotopy"));
  parameter SI.MagneticFieldStrength hH2  =  20000.00 "End   of homotopy"
    annotation(Dialog(group="Homotopy"));
  // Length of Raw Data
  parameter Integer N    = 33 "Count of nodes"
    annotation(Dialog(tab="Smoothing Splines"));
  // Smoothing Spline coefficients
  parameter Real c3[:](each unit="V.s.m/A2")={
     2.27864e-06, 2.32901e-06, 1.40801e-06,-6.86202e-07,-3.20815e-06,
    -5.32239e-06,-4.53197e-07, 1.96980e-07, 9.85862e-07, 6.20767e-07,
     2.48655e-07, 1.72769e-07, 1.06935e-07, 6.59337e-08, 3.23798e-08,
     8.34756e-09, 1.51137e-09, 2.61362e-10, 5.69454e-11, 2.38477e-11,
     9.55963e-12, 5.40335e-12, 2.43257e-12, 4.58038e-13, 4.98279e-14,
     4.90381e-14, 1.11934e-14, 9.99504e-15, 4.62001e-15, 1.65527e-14,
     6.74648e-15, 2.89091e-14}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c2[:](each unit="V.s/A2")={
     0.00000e+00, 6.84949e-05, 1.38361e-04, 1.80685e-04, 1.60156e-04,
     6.47927e-05,-9.58308e-05,-1.09426e-04,-1.03534e-04,-7.38923e-05,
    -5.15038e-05,-3.42036e-05,-2.12643e-05,-1.31499e-05,-8.30411e-06,
    -3.43640e-06,-9.64732e-07,-2.78886e-07,-8.49613e-08,-4.17113e-08,
    -2.38917e-08,-1.67094e-08,-8.62512e-09,-4.92342e-09,-1.49179e-09,
    -1.11839e-09,-7.50541e-10,-5.83338e-10,-4.49504e-10,-3.90539e-10,
    -1.92032e-10,-1.33433e-10}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c1[:](each unit="V.s/(m.A)")={
     2.38915e-03, 3.07546e-03, 5.14389e-03, 8.34067e-03, 1.17396e-02,
     1.39685e-02, 1.36562e-02, 1.16038e-02, 9.48040e-03, 7.70222e-03,
     6.19471e-03, 4.20700e-03, 2.82228e-03, 1.95181e-03, 1.42622e-03,
     8.37897e-04, 4.03512e-04, 2.15398e-04, 1.25410e-04, 9.33406e-05,
     7.70005e-05, 6.68324e-05, 5.41976e-05, 4.73252e-05, 3.13042e-05,
     2.47842e-05, 2.01111e-05, 1.34694e-05, 8.85949e-06, 5.28571e-06,
     2.95690e-06, 2.01459e-06}
    annotation(Dialog(tab="Smoothing Splines"));
  parameter Real c0[:](each unit="V.s/m2")={
     0.00000e+00, 2.62311e-02, 6.61610e-02, 1.33009e-01, 2.33471e-01,
     3.62395e-01, 5.04051e-01, 6.30570e-01, 7.35587e-01, 8.21194e-01,
     9.04189e-01, 1.02325e+00, 1.10965e+00, 1.16916e+00, 1.21006e+00,
     1.26475e+00, 1.32200e+00, 1.36619e+00, 1.40636e+00, 1.43359e+00,
     1.45462e+00, 1.47255e+00, 1.50240e+00, 1.52799e+00, 1.62260e+00,
     1.69227e+00, 1.74801e+00, 1.83092e+00, 1.88031e+00, 1.91022e+00,
     1.92617e+00, 1.93328e+00}
    annotation(Dialog(tab="Smoothing Splines"));
  // Raw Data: Magnetic field strength H and Magnetic polarization J
  parameter SI.MagneticFieldStrength HD[:]={
         0.00,    10.02,    20.02,    30.04,    40.01,    49.92,    59.98,
        69.98,    79.95,    89.97,   101.99,   125.19,   150.15,   175.44,
       199.94,   250.05,   348.75,   500.01,   747.34,  1000.51,  1249.58,
      1500.02,  1998.74,  2505.98,  5003.32,  7501.24, 10001.65, 14980.88,
     19444.24, 23698.52, 27696.00, 30591.27, 32129.82}
    annotation(Dialog(tab="Raw Data"));
  parameter SI.MagneticPolarization  JD[:]={
      0.00000,  0.02357,  0.06234,  0.12779,  0.22774,  0.35715,  0.50714,
      0.62863,  0.73381,  0.81804,  0.90102,  1.02044,  1.10685,  1.16639,
      1.20730,  1.26200,  1.31927,  1.36347,  1.40364,  1.43087,  1.45190,
      1.46983,  1.49968,  1.52527,  1.61988,  1.68955,  1.74529,  1.82820,
      1.87759,  1.90750,  1.92345,  1.93056,  1.93345}
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

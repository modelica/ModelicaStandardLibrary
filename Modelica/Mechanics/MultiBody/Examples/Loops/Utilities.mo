within Modelica.Mechanics.MultiBody.Examples.Loops;
package Utilities "Utility models for Examples.Loops"
  extends Modelica.Icons.Library;

  model Cylinder "Cylinder with rod and crank of a combustion engine"
    import SI = Modelica.SIunits;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Length cylinderTopPosition=0.42
      "Length from crank shaft to end of cylinder.";
    parameter SI.Length pistonLength=0.1 "Length of cylinder";
    parameter SI.Length rodLength=0.2 "Length of rod";
    parameter SI.Length crankLength=0.2 "Length of crank shaft in x direction";
    parameter SI.Length crankPinOffset=0.1
      "Offset of crank pin from center axis";
    parameter SI.Length crankPinLength=0.1
      "Offset of crank pin from center axis";
    parameter SI.Angle cylinderInclination=0 "Inclination of cylinder";
    parameter SI.Angle crankAngleOffset=0 "Offset for crank angle";
    parameter SI.Length cylinderLength=cylinderTopPosition - (pistonLength +
        rodLength - crankPinOffset) "Maximum length of cylinder volume";

    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Piston(
      diameter=0.1,
      r={0,pistonLength,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(
          origin={14.5,69.5},
          extent={{10.5,-30.5},{-10.5,30.5}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Rod(
      widthDirection={1,0,0},
      height=0.06,
      color={0,0,200},
      width=0.02,
      r_shape={0,-0.02,0},
      r={0,rodLength,0},
      animation=animation) annotation (Placement(transformation(
          origin={14,8},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Joints.Revolute B2(
      n={1,0,0},
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (Placement(transformation(extent={{4,
              25},{24,45}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-crankPinOffset,0},
      animation=animation)
      annotation (Placement(transformation(
          origin={40.5,-74},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank3(
      r_shape={-0.01,0,0},
      length=0.12,
      diameter=0.03,
      r={crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(extent={{4.5,
              -60},{24.5,-40}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank1(
      diameter=0.05,
      r_shape={-0.01,0,0},
      length=0.12,
      r={crankLength - crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(extent={{-50,
              -100},{-30,-80}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,crankPinOffset,0},
      animation=animation) annotation (Placement(transformation(
          origin={-10,-76},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Joints.RevolutePlanarLoopConstraint B1(
      n={1,0,0},
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (Placement(transformation(extent={{4,
              -27},{24,-7}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(r={crankPinLength/2,0,0}, animation=
          false) annotation (Placement(transformation(extent={{-6,-46},{14,-26}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Prismatic Cylinder(useAxisFlange=true,
      s(start=-0.3),
      n={0,-1,0},
      boxWidth=0.02) annotation (Placement(transformation(
          origin={14,99},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (Placement(transformation(extent={{0,120},{20,140}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      n_y={0,cos(cylinderInclination),sin(cylinderInclination)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}}, rotation=
             0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle1(
      n_y={0,cos(crankAngleOffset),sin(crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{-90,-100},{-70,-80}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle2(
      n_y={0,cos(-crankAngleOffset),sin(-crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{60,-100},{80,-80}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation CylinderTop(r={0,cylinderTopPosition,0},
        animation=false) annotation (Placement(transformation(
          origin={-30,71},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    GasForce gasForce(L=cylinderLength, d=0.1)
      annotation (Placement(transformation(
          origin={50,107},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={
              {-116,114},{-84,146}}, rotation=0)));
    Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={
              {84,114},{116,146}}, rotation=0)));
    Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{
              -116,-106},{-84,-74}}, rotation=0)));
    Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,
              -106},{116,-74}}, rotation=0)));
  equation
    connect(B1.frame_a, Mid.frame_b) annotation (Line(
        points={{4,-17},{-6,-17},{-6,-29},{22,-29},{22,-36},{14,-36}},
        color={95,95,95},
        thickness=0.5));
    connect(Rod.frame_a, B1.frame_b) annotation (Line(
        points={{14,-2},{14,-9},{30,-9},{30,-17},{24,-17}},
        color={95,95,95},
        thickness=0.5));
    connect(Cylinder.frame_b, Piston.frame_b) annotation (Line(
        points={{14,89},{14,80},{14.5,80}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank1.frame_a, CrankAngle1.frame_b)
      annotation (Line(
        points={{-50,-90},{-70,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(B2.frame_a, Piston.frame_a) annotation (Line(
        points={{4,35},{-6,35},{-6,49},{14.5,49},{14.5,59}},
        color={95,95,95},
        thickness=0.5));
    connect(Rod.frame_b, B2.frame_b) annotation (Line(
        points={{14,18},{14,23},{32,23},{32,35},{24,35}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank4.frame_b, CrankAngle2.frame_a) annotation (Line(
        points={{40.5,-84},{40.5,-90},{60,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(Cylinder.support, gasForce.flange_b) annotation (Line(points={{20,103},
            {34,103},{34,117},{50,117}},      color={0,191,0}));
    connect(Cylinder.axis, gasForce.flange_a)
      annotation (Line(points={{20,91},{50,91},{50,97}}, color={0,191,0}));
    connect(CylinderInclination.frame_b, CylinderTop.frame_a)
      annotation (Line(points={{-40,40},{-30,40},{-30,61}}));
    connect(Crank1.frame_b, Crank2.frame_a) annotation (Line(
        points={{-30,-90},{-10,-90},{-10,-86}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (Line(
        points={{24.5,-50},{40.5,-50},{40.5,-64}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank3.frame_a, Crank2.frame_b) annotation (Line(
        points={{4.5,-50},{-10,-50},{-10,-66}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank2.frame_b, Mid.frame_a) annotation (Line(
        points={{-10,-66},{-10,-36},{-6,-36}},
        color={95,95,95},
        thickness=0.5));
    connect(CylinderTop.frame_b, Cylinder.frame_a) annotation (Line(
        points={{-30,81},{-30,120},{14,120},{14,109}},
        color={95,95,95},
        thickness=0.5));
    connect(CylinderInclination.frame_a, cylinder_a) annotation (Line(
        points={{-60,40},{-80,40},{-80,130},{-100,130}},
        color={95,95,95},
        thickness=0.5));
    connect(Mounting.frame_a, cylinder_a) annotation (Line(
        points={{0,130},{-100,130}},
        color={95,95,95},
        thickness=0.5));
    connect(Mounting.frame_b, cylinder_b) annotation (Line(
        points={{20,130},{100,130}},
        color={95,95,95},
        thickness=0.5));
    connect(CrankAngle1.frame_a, crank_a) annotation (Line(
        points={{-90,-90},{-100,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(CrankAngle2.frame_b, crank_b) annotation (Line(
        points={{80,-90},{100,-90}},
        color={95,95,95},
        thickness=0.5));

    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-150},{100,150}},
          grid={1,1}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-150},{100,150}},
          grid={1,1}), graphics={
          Polygon(
            points={{-60,-50},{-60,100},{60,100},{60,-52},{100,-52},{100,150},{
                -100,150},{-100,-50},{-60,-50}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,89},{58,13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-60,81},{60,75}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,67},{60,61}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,55},{60,49}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,11},{-42,23},{38,23},{56,11},{-60,11}},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Ellipse(
            extent={{-6,41},{2,33}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-40,-129},{40,-49}}, lineColor={192,192,192}),
          Line(
            points={{0,-90},{26,-58},{-2,37}},
            color={0,0,0},
            thickness=1),
          Text(
            extent={{-150,-124},{164,-186}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{-100,-90},{100,-91}},
            color={0,0,0},
            thickness=0.5)}));
  end Cylinder;

  model GasForce "Simple gas force computation for combustion engine"
    import SI = Modelica.SIunits;

    extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Diameter d "Diameter of cylinder";
    parameter SIunits.Volume k0=0.01
      "Volume V = k0 + k1*(1-x), with x = 1 + s_rel/L";
    parameter SIunits.Volume k1=1
      "Volume V = k0 + k1*(1-x), with x = 1 + s_rel/L";
    parameter SIunits.HeatCapacity k=1 "Gas constant (p*V = k*T)";
    constant Real pi=Modelica.Constants.pi;

    // Only for compatibility reasons
    Real x "Normalized position of cylinder";
    Real y "Normalized relative movement (= -s_rel/L)";
    SI.Density dens;
    Modelica.SIunits.Conversions.NonSIunits.Pressure_bar press
      "cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel;
  protected
    constant SI.Mass unitMass=1;
    Modelica.SIunits.Pressure p;
  equation
    y = -s_rel/L;
    x = 1 + s_rel/L;
    v_rel = der(s_rel);

    press = p/1e5;
    p = (if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3 +
      151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 + 14761814
      *x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4 +
      14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4))*1e5;

    f = -1.0E5*press*pi*d^2/4;

    V = k0 + k1*(1 - x);
    dens = unitMass/V;
    (p/1e5)*V = k*T;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,50},{-20,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Rectangle(
            extent={{-90,10},{-40,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{60,2},{54,2},{0,2},{0,10},{-20,0},{0,-10},{0,-4},{60,-4},{
                60,2}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,120},{100,60}},
            textString="%name",
            lineColor={0,0,255})}),                         Diagram(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,50},{-20,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Rectangle(
            extent={{-90,10},{-40,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{60,2},{54,2},{0,2},{0,10},{-20,0},{0,-10},{0,-4},{60,-4},{
                60,2}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,120},{100,60}},
            textString="%name",
            lineColor={0,0,255})}));
  end GasForce;

  model GasForce2 "Rough approximation of gas force in a cylinder"
    import SI = Modelica.SIunits;

    extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Length d "diameter of cylinder";
    parameter SIunits.Volume k0=0.01
      "Volume V = k0 + k1*(1-x), with x = 1 - s_rel/L";
    parameter SIunits.Volume k1=1
      "Volume V = k0 + k1*(1-x), with x = 1 - s_rel/L";
    parameter SIunits.HeatCapacity k=1 "Gas constant (p*V = k*T)";

  /*
  parameter Real k0=0.01;
  parameter Real k1=1;
  parameter Real k=1;
*/
    constant Real pi=Modelica.Constants.pi;
    Real x "Normalized position of cylinder (= 1 - s_rel/L)";
    SI.Density dens;
    Modelica.SIunits.AbsolutePressure press "Cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel;

  protected
    Modelica.SIunits.SpecificHeatCapacity R_air = Modelica.Constants.R/0.0289651159;
  equation
    x = 1 - s_rel/L;
    v_rel = der(s_rel);

    press = 1.0E5*(if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3 +
      151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 + 14761814
      *x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4 +
      14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4));

    f = -press*pi*d^2/4;

    V = k0 + k1*(1 - x);
    dens = press/(R_air*T);
    press*V = k*T;

    assert(s_rel >= -1.e-12, "flange_b.s - flange_a.s (= " + String(s_rel) +
                             ") >= 0 required for GasForce component.\n" +
                             "Most likely, the component has to be flipped.");
    assert(s_rel <= L + 1.e-12, " flange_b.s - flange_a.s (= " + String(s_rel) +
                                " <= L (" + String(L) + ") required for GasForce component.\n" +
                                "Most likely, parameter L is not correct.");
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-13,4},{-16,4},{-65,4},{-65,15},{-90,0},{-65,-15},{-65,-4},
                {-13,-4},{-13,4}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,120},{100,60}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-135,44},{-99,19}},
            lineColor={128,128,128},
            textString="a"),
          Text(
            extent={{97,40},{133,15}},
            lineColor={128,128,128},
            textString="b"),
          Polygon(
            points={{12,4},{70,4},{65,4},{65,15},{90,0},{65,-15},{65,-4},{12,-4},
                {12,4}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),               Diagram(
          coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,120},{100,60}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{12,5},{70,5},{65,5},{65,16},{90,1},{65,-14},{65,-3},{12,-3},
                {12,5}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-13,5},{-16,5},{-65,5},{-65,16},{-90,1},{-65,-14},{-65,-3},
                {-13,-3},{-13,5}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
The gas force in a cylinder is computed as function of the relative
distance of the two flanges. It is required that s_rel = flange_b.s - flange_a.s
is in the range
</p>
<pre>
    0 &le; s_rel &le; L
</pre>
<p>
where the parameter L is the length
of the cylinder. If this assumption is not fulfilled, an error occurs.
</p>
</html>"));
  end GasForce2;

  model CylinderBase "One cylinder with analytic handling of kinematic loop"
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Length cylinderTopPosition=0.42
      "Length from crank shaft to end of cylinder.";
    parameter SI.Length crankLength=0.14 "Length of crank shaft in x direction";
    parameter SI.Length crankPinOffset=0.05
      "Offset of crank pin from center axis";
    parameter SI.Length crankPinLength=0.1
      "Offset of crank pin from center axis";
    parameter Cv.NonSIunits.Angle_deg cylinderInclination=0
      "Inclination of cylinder";
    parameter Cv.NonSIunits.Angle_deg crankAngleOffset=0
      "Offset for crank angle";
    parameter SI.Length pistonLength=0.1 " Length of cylinder"
      annotation (Dialog(group="Piston"));
    parameter SI.Length pistonCenterOfMass=pistonLength/2
      " Distance from frame_a to center of mass of piston"
      annotation (Dialog(group="Piston"));
    parameter SI.Mass pistonMass(min=0) = 6 " Mass of piston"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_11(min=0) = 0.0088
      " Inertia 11 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_22(min=0) = 0.0076
      " Inertia 22 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_33(min=0) = 0.0088
      " Inertia 33 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));

    parameter SI.Length rodLength=0.175 " Length of rod"
      annotation (Dialog(group="Rod"));
    parameter SI.Length rodCenterOfMass=rodLength/2
      " Distance from frame_a to center of mass of piston"
      annotation (Dialog(group="Rod"));
    parameter SI.Mass rodMass(min=0) = 1 " Mass of rod"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_11(min=0) = 0.006
      " Inertia 11 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_22(min=0) = 0.0005
      " Inertia 22 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_33(min=0) = 0.006
      " Inertia 33 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    final parameter SI.Length cylinderLength=cylinderTopPosition - (
        pistonLength + rodLength - crankPinOffset)
      "Maximum length of cylinder volume";

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(animation=false, r={crankLength -
          crankPinLength/2,crankPinOffset,0})
      annotation (Placement(transformation(extent={{-44,-30},{-24,-10}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (Placement(transformation(extent={{-3,90},{17,110}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=cylinderInclination) annotation (Placement(transformation(extent={{
              -44,30},{-24,50}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle(
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=crankAngleOffset) annotation (Placement(transformation(extent={{-84,
              -80},{-64,-60}}, rotation=0)));
    Joints.Assemblies.JointRRP jointRRP(
      n_a={1,0,0},
      n_b={0,-1,0},
      rRod1_ia={0,rodLength,0},
      animation=false,
      rRod2_ib=-{0,pistonLength,0},
      s_offset=-cylinderTopPosition)
      annotation (Placement(transformation(
          origin={0,12},
          extent={{-20,20},{20,-20}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyShape Rod(
      animation=animation,
      r={0,rodLength,0},
      r_CM={0,rodLength/2,0},
      shapeType="2",
      lengthDirection={1,0,0},
      widthDirection={0,0,-1},
      length=rodLength/1.75,
      width=rodLength/1.75,
      height=rodLength/1.75,
      color={155,155,155},
      extra=1,
      r_shape={0,0,0},
      animateSphere=false,
      m=rodMass,
      I_11=rodInertia_11,
      I_22=rodInertia_22,
      I_33=rodInertia_33) annotation (Placement(transformation(
          origin={49,9},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyShape Piston(
      animation=animation,
      r={0,pistonLength,0},
      r_CM={0,pistonLength/2,0},
      shapeType="3",
      length=0.08,
      width=0.08,
      height=0.08,
      extra=1,
      lengthDirection={1,0,0},
      widthDirection={0,0,-1},
      color={180,180,180},
      animateSphere=false,
      m=pistonMass,
      I_11=pistonInertia_11,
      I_22=pistonInertia_22,
      I_33=pistonInertia_33) annotation (Placement(transformation(
          origin={50,50},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    GasForce gasForce(L=cylinderLength, d=0.1)
      annotation (Placement(transformation(
          origin={-1,70},
          extent={{-10,-10},{10,10}},
          rotation=180)));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Crank(animation=false, r={crankLength,0,0})
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
            rotation=0)));
    Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={
              {-116,84},{-84,116}}, rotation=0)));
    Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={
              {84,84},{116,116}}, rotation=0)));
    Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{
              -116,-116},{-84,-84}}, rotation=0)));
    Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,
              -116},{116,-84}}, rotation=0)));
  equation

    connect(jointRRP.frame_ia, Rod.frame_a) annotation (Line(
        points={{20,-4},{49,-4},{49,-1}},
        color={95,95,95},
        thickness=0.5));
    connect(Mid.frame_b, jointRRP.frame_a) annotation (Line(
        points={{-24,-20},{-1.22465e-015,-20},{-1.22465e-015,-8}},
        color={95,95,95},
        thickness=0.5));
    connect(gasForce.flange_a, jointRRP.axis)
      annotation (Line(points={{9,70},{16,70},{16,32}}, color={0,191,0}));
    connect(jointRRP.bearing, gasForce.flange_b) annotation (Line(points={{8,32},{
            8,52},{-20,52},{-20,70},{-11,70}},  color={0,191,0}));
    connect(jointRRP.frame_ib, Piston.frame_b) annotation (Line(
        points={{20,28},{30,28},{30,70},{50,70},{50,60}},
        color={95,95,95},
        thickness=0.5));
    connect(jointRRP.frame_b, CylinderInclination.frame_b) annotation (Line(
        points={{1.22465e-015,32},{1,32},{1,40},{-24,40}},
        color={95,95,95},
        thickness=0.5));
    connect(CrankAngle.frame_b, Mid.frame_a) annotation (Line(
        points={{-64,-70},{-56,-70},{-56,-20},{-44,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_a, CylinderInclination.frame_a) annotation (Line(
        points={{-100,100},{-70,100},{-70,40},{-44,40}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_a, Mounting.frame_a) annotation (Line(
        points={{-100,100},{-3,100}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_b, Mounting.frame_b) annotation (Line(
        points={{100,100},{17,100}},
        color={95,95,95},
        thickness=0.5));
    connect(CrankAngle.frame_a, crank_a) annotation (Line(
        points={{-84,-70},{-89.5,-70},{-89.5,-100},{-100,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(crank_a, Crank.frame_a) annotation (Line(
        points={{-100,-100},{-10,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank.frame_b, crank_b) annotation (Line(
        points={{10,-100},{100,-100}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{-60,-61},{-60,64},{60,64},{60,-61},{100,-61},{100,114},{-100,
                114},{-100,-61},{-60,-61}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,63},{58,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-60,55},{60,49}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,41},{60,35}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,29},{60,23}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-57,-13},{-39,-1},{41,-1},{59,-13},{-57,-13}},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Ellipse(
            extent={{-6,15},{2,7}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-41,-139},{39,-59}}, lineColor={192,192,192}),
          Line(
            points={{-1,-99},{25,-67},{-2,10}},
            color={0,0,0},
            thickness=1),
          Text(
            extent={{-156,178},{158,116}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{-100,-99},{100,-100}},
            color={0,0,0},
            thickness=0.5)}));
  end CylinderBase;

  model Cylinder_analytic_CAD
    "One cylinder with analytic handling of kinematic loop and CAD visualization"
    extends CylinderBase;
    Visualizers.FixedShape CrankShape(
      animation=animation,
      shapeType="1",
      lengthDirection={1,0,0},
      extra=1,
      widthDirection={0,1,0},
      length=crankPinOffset/0.5,
      width=crankPinOffset/0.5,
      height=crankPinOffset/0.5,
      r_shape={crankLength - crankPinLength/2 - 0.002,0,0})
      annotation (Placement(transformation(
          origin={-10,-70},
          extent={{10,10},{-10,-10}},
          rotation=180)));
  equation

    connect(CrankShape.frame_a, CrankAngle.frame_b)
      annotation (Line(
        points={{-20,-70},{-64,-70}},
        color={95,95,95},
        thickness=0.5));
    annotation (                                           Diagram(
          coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end Cylinder_analytic_CAD;

  model EngineV6_analytic "V6 engine with analytic loop handling"
    import SI = Modelica.SIunits;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    replaceable model Cylinder = Cylinder_analytic_CAD constrainedby
      CylinderBase "Cylinder type"
         annotation (choices(choice(redeclare model Cylinder =
            Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic_CAD
            "Analytic loop handling + CAD animation"),
                                                     choice(redeclare model
            Cylinder =
              Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic
            "Analytic loop handling + standard animation")));

    Cylinder cylinder1(
      crankAngleOffset=-30,
      cylinderInclination=-30,
      animation=animation) annotation (Placement(transformation(extent={{-90,
              -10},{-70,10}}, rotation=0)));
    Cylinder cylinder2(
      crankAngleOffset=90,
      cylinderInclination=30,
      animation=animation) annotation (Placement(transformation(extent={{-60,
              -10},{-40,10}}, rotation=0)));
    Cylinder cylinder3(
      cylinderInclination=-30,
      animation=animation,
      crankAngleOffset=210)
                           annotation (Placement(transformation(extent={{-30,
              -10},{-10,10}}, rotation=0)));
    Cylinder cylinder4(
      cylinderInclination=30,
      animation=animation,
      crankAngleOffset=210)
                           annotation (Placement(transformation(extent={{0,-10},
              {20,10}}, rotation=0)));
    Cylinder cylinder5(
      cylinderInclination=-30,
      animation=animation,
      crankAngleOffset=90) annotation (Placement(transformation(extent={{30,-10},
              {50,10}}, rotation=0)));
    Cylinder cylinder6(
      cylinderInclination=30,
      animation=animation,
      crankAngleOffset=-30)
                           annotation (Placement(transformation(extent={{60,-10},
              {80,10}}, rotation=0)));
    Joints.Revolute bearing(useAxisFlange=true,
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.06,
      animation=true) annotation (Placement(transformation(extent={{-90,-40},{
              -70,-60}}, rotation=0)));
    Parts.BodyShape crank(
      animation=false,
      r_CM={6*0.1/2,0,0},
      I_22=1.e-5,
      I_33=1.e-5,
      m=6*30,
      I_11=0.1) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));
    Interfaces.Frame_a frame_a
      annotation (Placement(transformation(
          origin={0,-101},
          extent={{-16,-16},{16,16}},
          rotation=270)));
  equation
    connect(cylinder1.crank_b, cylinder2.crank_a)
      annotation (Line(
        points={{-70,-10},{-60,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder2.cylinder_a, cylinder1.cylinder_b) annotation (Line(
        points={{-60,10},{-70,10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder3.cylinder_a, cylinder2.cylinder_b) annotation (Line(
        points={{-30,10},{-40,10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder3.crank_a, cylinder2.crank_b)
      annotation (Line(
        points={{-30,-10},{-40,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder3.cylinder_b, cylinder4.cylinder_a) annotation (Line(
        points={{-10,10},{0,10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder3.crank_b, cylinder4.crank_a)
      annotation (Line(
        points={{-10,-10},{0,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder4.cylinder_b, cylinder5.cylinder_a) annotation (Line(
        points={{20,10},{30,10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder4.crank_b, cylinder5.crank_a)
      annotation (Line(
        points={{20,-10},{30,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder5.cylinder_b, cylinder6.cylinder_a) annotation (Line(
        points={{50,10},{60,10}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder5.crank_b, cylinder6.crank_a)
      annotation (Line(
        points={{50,-10},{60,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.frame_b, crank.frame_a)
      annotation (Line(
        points={{-70,-50},{-50,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(crank.frame_b, cylinder1.crank_a) annotation (Line(
        points={{-30,-50},{-24,-50},{-24,-26},{-94,-26},{-94,-10},{-90,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.axis, flange_b) annotation (Line(points={{-80,-60},{-80,-66},
            {90,-66},{90,0},{110,0}}, color={0,0,0}));
    connect(frame_a, bearing.frame_a) annotation (Line(
        points={{0,-101},{0,-81},{-98,-81},{-98,-50},{-90,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.frame_a, cylinder1.cylinder_a) annotation (Line(
        points={{-90,-50},{-98,-50},{-98,10},{-90,10}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-137,160},{137,104}},
            lineColor={0,0,255},
            textString="%name"),
          Bitmap(extent={{-97,75},{99,-39}}, fileName=
                "../../../../Images/MultiBody/Examples/Loops/EngineV6_CAD.png")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end EngineV6_analytic;

  partial model Engine1bBase "Model of one cylinder engine with gas force"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Piston(diameter=0.1, r={0,-0.1,0})
      annotation (Placement(transformation(
          origin={120,53},
          extent={{-10,30},{10,-30}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Rod2(
      widthDirection={1,0,0},
      width=0.02,
      height=0.06,
      color={0,0,200},
      r={0,0.2,0})     annotation (Placement(transformation(
          origin={120,10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Joints.Revolute Bearing(useAxisFlange=true,
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.05) annotation (Placement(transformation(extent={{-50,
              -80},{-30,-100}}, rotation=0)));
    inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
          transformation(extent={{-90,-100},{-70,-80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia Inertia(
      stateSelect=StateSelect.always,
      J=0.1,
      w(fixed=true),
      phi(
        fixed=true,
        start=0.001,
        displayUnit="rad"))              annotation (Placement(transformation(
            extent={{-68,-120},{-48,-100}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-0.1,0}) annotation (Placement(transformation(
          origin={75.5,-75},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank3(r={0.1,0,0}, diameter=0.03) annotation (
                                   Placement(transformation(extent={{41.5,-71},
              {61.5,-51}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank1(diameter=0.05, r={0.1,0,0})
      annotation (Placement(transformation(extent={{-16,-100},{4,-80}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,0.1,0})
                  annotation (Placement(transformation(
          origin={30,-76},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(r={0.05,0,0})
      annotation (Placement(transformation(extent={{30,-53},{50,-33}}, rotation=
             0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(                 animation=false, r={0.15,
          0.55,0})
      annotation (Placement(transformation(extent={{-40.5,100},{-20.5,120}},
            rotation=0)));
    Utilities.GasForce2 gasForce(        d=0.1, L=0.35)
      annotation (Placement(transformation(
          origin={119,97},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    connect(world.frame_b, Bearing.frame_a)
      annotation (Line(
        points={{-70,-90},{-50,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank2.frame_a, Crank1.frame_b) annotation (Line(
        points={{30,-86},{30,-90},{4,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank2.frame_b, Crank3.frame_a) annotation (Line(
        points={{30,-66},{30,-61},{41.5,-61}},
        color={95,95,95},
        thickness=0.5));
    connect(Bearing.frame_b, Crank1.frame_a) annotation (Line(
        points={{-30,-90},{-16,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, cylPosition.frame_a) annotation (Line(
        points={{-70,-90},{-60,-90},{-60,110},{-40.5,110}},
        color={95,95,95},
        thickness=0.5));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (Line(
        points={{61.5,-61},{75,-61},{75,-65},{75.5,-65}},
        color={95,95,95},
        thickness=0.5));
    connect(Inertia.flange_b, Bearing.axis) annotation (Line(
        points={{-48,-110},{-40,-110},{-40,-100}},
        color={0,0,0}));
    connect(Mid.frame_a, Crank2.frame_b) annotation (Line(
        points={{30,-43},{23,-43},{23,-61},{30,-61},{30,-66}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-120},{150,120}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
The combustion is not modelled. The \"inertia\" component at the lower
left part is the output inertia of the engine driving the gearbox.
The angular velocity of the output inertia has a start value of 10 rad/s
in order to demonstrate the movement of the engine.
</p>
<p>
The engine is modeled solely by revolute and prismatic joints.
Since this results in a <b>planar</b> loop there is the well known
difficulty that the cut-forces perpendicular to the loop cannot be
uniquely computed, as well as the cut-torques within the plane.
This ambiguity is resolved by using the option <b>planarCutJoint</b>
in the <b>Advanced</b> menu of one revolute joint in every planar loop
(here: joint B1). This option sets the cut-force in direction of the
axis of rotation, as well as the cut-torques perpendicular to the axis
of rotation at this joint to zero and makes the problem mathematically
well-formed.
</p>
<p>
An animation of this example is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Engine.png\" ALT=\"model Examples.Loops.Engine\">
</p>
</html>"));
  end Engine1bBase;
end Utilities;

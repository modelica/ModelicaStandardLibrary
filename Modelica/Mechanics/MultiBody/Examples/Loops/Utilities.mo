within Modelica.Mechanics.MultiBody.Examples.Loops;
package Utilities "Utility classes for examples of kinematic loops"
  extends Modelica.Icons.UtilitiesPackage;

  model Cylinder "Cylinder with rod and crank of a combustion engine"
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
    parameter SI.Angle cylinderInclinationAngle=0 "Inclination of cylinder";
    parameter SI.Angle crankAngleOffset=0 "Offset for crank angle";
    parameter SI.Length cylinderLength=cylinderTopPosition - (pistonLength +
        rodLength - crankPinOffset) "Maximum length of cylinder volume";

    Modelica.Mechanics.MultiBody.Parts.BodyCylinder piston(
      diameter=0.1,
      r={0,pistonLength,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(
          origin={20,30},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox connectingRod(
      widthDirection={1,0,0},
      height=0.06,
      color={0,0,200},
      width=0.02,
      r_shape={0,-0.02,0},
      r={0,rodLength,0},
      animation=animation) annotation (Placement(transformation(
          origin={60,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Joints.Revolute b2(
      n={1,0,0},
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (Placement(transformation(extent={{30,0},{50,20}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-crankPinOffset,0},
      animation=animation)
      annotation (Placement(transformation(
          origin={50,-70},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank3(
      r_shape={-0.01,0,0},
      length=0.12,
      diameter=0.03,
      r={crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(extent={{10.5,-60},{30.5,-40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank1(
      diameter=0.05,
      r_shape={-0.01,0,0},
      length=0.12,
      r={crankLength - crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,crankPinOffset,0},
      animation=animation) annotation (Placement(transformation(
          origin={-10,-70},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Joints.RevolutePlanarLoopConstraint b1(
      n={1,0,0},
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (Placement(transformation(extent={{30,-20},{50,-40}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(r={crankPinLength/2,0,0}, animation=
          false) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(useAxisFlange=true,
      s(start=-0.3),
      n={0,-1,0},
      boxWidth=0.02) annotation (Placement(transformation(
          origin={20,60},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation mounting(r={crankLength,0,0}, animation=
          false) annotation (Placement(transformation(extent={{0,90},{20,110}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation cylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      n_y={0,Modelica.Math.cos(cylinderInclinationAngle),Modelica.Math.sin(cylinderInclinationAngle)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle1(
      n_y={0,Modelica.Math.cos(crankAngleOffset),Modelica.Math.sin(crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle2(
      n_y={0,Modelica.Math.cos(-crankAngleOffset),Modelica.Math.sin(-crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylinderTop(r={0,cylinderTopPosition,0},
        animation=false) annotation (Placement(transformation(
          origin={-30,60},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    GasForce2 gasForce(L=cylinderLength, d=0.1)
      annotation (Placement(transformation(
          origin={50,60},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={{-116,84},{-84,116}})));
    Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={{84,84},{116,116}})));
    Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{-116,-116},{-84,-84}})));
    Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,-116},{116,-84}})));
  equation
    connect(b1.frame_a, mid.frame_b) annotation (Line(
        points={{30,-30},{20,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(connectingRod.frame_a, b1.frame_b) annotation (Line(
        points={{60,-20},{60,-30},{50,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder.frame_b, piston.frame_b) annotation (Line(
        points={{20,50},{20,40}},
        color={95,95,95},
        thickness=0.5));
    connect(crank1.frame_a, crankAngle1.frame_b)
      annotation (Line(
        points={{-50,-90},{-70,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(b2.frame_a, piston.frame_a) annotation (Line(
        points={{30,10},{20,10},{20,20}},
        color={95,95,95},
        thickness=0.5));
    connect(connectingRod.frame_b, b2.frame_b) annotation (Line(
        points={{60,0},{60,10},{50,10}},
        color={95,95,95},
        thickness=0.5));
    connect(crank4.frame_b, crankAngle2.frame_a) annotation (Line(
        points={{50,-80},{50,-90},{70,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinderInclination.frame_b, cylinderTop.frame_a)
      annotation (Line(
        points={{-50,40},{-30,40},{-30,50}},
        color={95,95,95},
        thickness=0.5));
    connect(crank1.frame_b, crank2.frame_a) annotation (Line(
        points={{-30,-90},{-10,-90},{-10,-80}},
        color={95,95,95},
        thickness=0.5));
    connect(crank3.frame_b, crank4.frame_a) annotation (Line(
        points={{30.5,-50},{50,-50},{50,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(crank3.frame_a, crank2.frame_b) annotation (Line(
        points={{10.5,-50},{-10,-50},{-10,-60}},
        color={95,95,95},
        thickness=0.5));
    connect(crank2.frame_b, mid.frame_a) annotation (Line(
        points={{-10,-60},{-10,-30},{0,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinderTop.frame_b, cylinder.frame_a) annotation (Line(
        points={{-30,70},{-30,80},{20,80},{20,70}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinderInclination.frame_a, cylinder_a) annotation (Line(
        points={{-70,40},{-80,40},{-80,100},{-100,100}},
        color={95,95,95},
        thickness=0.5));
    connect(mounting.frame_a, cylinder_a) annotation (Line(
        points={{0,100},{-100,100}},
        color={95,95,95},
        thickness=0.5));
    connect(mounting.frame_b, cylinder_b) annotation (Line(
        points={{20,100},{100,100}},
        color={95,95,95},
        thickness=0.5));
    connect(crankAngle1.frame_a, crank_a) annotation (Line(
        points={{-90,-90},{-100,-90},{-100,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(crankAngle2.frame_b, crank_b) annotation (Line(
        points={{90,-90},{100,-90},{100,-100}},
        color={95,95,95},
        thickness=0.5));

    connect(cylinder.axis, gasForce.flange_b) annotation (Line(points={{26,52},{30,52},{30,50},{50,50}},
                                                                                         color={0,127,0}));
    connect(cylinder.support, gasForce.flange_a) annotation (Line(points={{26,64},{30,64},{30,70},{50,70}},     color={0,127,0}));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,160},{150,120}},
            textString="%name",
            textColor={0,0,255}),
          Line(
            points={{-100,-100},{100,-100}},
            thickness=0.5),
          Polygon(
            points={{-60,-60},{-60,64},{60,64},{60,-60},{100,-60},{100,114},{-100,114},{-100,-60},{-60,-60}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,53},{58,-23}},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-60,45},{60,39}},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,31},{60,25}},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,19},{60,13}},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-57,-23},{-40,-11},{40,-11},{57,-23},{-57,-23}},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Ellipse(
            extent={{-8,6},{4,-6}},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-40,-140},{40,-60}}, lineColor={192,192,192}),
          Line(
            points={{0,-100},{26,-70},{-2,0}},
            thickness=1)}),   Documentation(info="<html>
<p>
Cylinder with rod and crank of a combustion engine.
Used as submodel in <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">Loops.EngineV6</a>.
</p>
</html>"));
  end Cylinder;

  model GasForce2 "Rough approximation of gas force in a combustion engine's cylinder"
    import Modelica.Constants.pi;

    extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Length d "Diameter of cylinder";
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
    Real x "Normalized position of cylinder (= 1 - s_rel/L)";
    SI.Density dens;
    Modelica.SIunits.AbsolutePressure press "Cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel "Relative piston velocity (<0: compression;  >0: expansion)";

  protected
    constant Modelica.SIunits.SpecificHeatCapacity R_air = Modelica.Constants.R/0.0289651159;
  equation
    x = 1 - s_rel/L;
    v_rel = der(s_rel);

    press = 1e5 * (
      if v_rel < 0 then (
        if x < 0.986061 then 177.4132*x^4 - 287.2189*x^3 + 151.8252*x^2 - 24.9973*x + 2.4
        else 2836360*x^4 - 10569296*x^3 + 14761814*x^2 - 9158505*x + 2129670)
      else (
        if x > 0.933 then -3929704*x^4 + 14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495
        else 145.930*x^4 - 131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4));

    f = -press*pi*d^2/4;

    V = k0 + k1*(1 - x);
    dens = press/(R_air*T);
    press*V = k*T;

    assert(s_rel >= -1e-12, "flange_b.s - flange_a.s (= " + String(s_rel,
      significantDigits=14) + ") >= 0 required for GasForce2 component.\n" +
      "Most likely, the component has to be flipped.");
    assert(s_rel <= L + 1e-12, " flange_b.s - flange_a.s (= " + String(s_rel,
      significantDigits=14) + ") <= L (= " + String(L, significantDigits=14) +
      ") required for GasForce2 component.\n" +
      "Most likely, parameter L is not correct.");
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-50,4},{-65,4},{-65,15},{-90,0},{-65,-15},{-65,-4},{-50,-4},{-50,4}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-135,44},{-99,19}},
            textColor={128,128,128},
            textString="a"),
          Text(
            extent={{97,40},{133,15}},
            textColor={128,128,128},
            textString="b"),
          Polygon(
            points={{50,4},{70,4},{65,4},{65,15},{90,0},{65,-15},{65,-4},{50,-4},{50,4}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,100},{150,60}},
            textString="%name",
            textColor={0,0,255}),
          Line(points={{-50,-100},{30,-100}}),
          Polygon(
                points={{60,-100},{30,-90},{30,-110},{60,-100}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
          Polygon(
            points={{-30,-22},{-13.9727,-29.1797},{10,-30},{54,-32},{70,-30},{70,-26},{48,-22},{14,-16},{-4,-8},{-18,4},{-24,22},{-28,38},{-30,28},{-32,8},{-32,-4},{-30,-22}},
            lineColor={95,95,95},
            smooth=Smooth.Bezier),
          Line(points={{-46,-40},{76,-40}}, color={135,135,135}),
          Line(points={{-40,-46},{-40,40}}, color={135,135,135}),
          Text(extent={{-140,-60},{140,-90}}, textString="L=%L")}),
      Diagram(
          coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-90,50},{90,-50}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
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
The gas force in a cylinder of a combustion engine is computed as function of the relative
distance of the two flanges. It is required that s_rel&nbsp;=&nbsp;flange_b.s&nbsp;-&nbsp;flange_a.s
is in the range
</p>
<blockquote><pre>
0 &le; s_rel &le; L,
</pre></blockquote>
<p>
where the parameter&nbsp;L is the length of the cylinder.
If this assumption is not fulfilled, an error occurs.
The resulting approximation of the gas pressure is shown in
the following figure and depends on both s_rel and
the relative velocity v_rel&nbsp;=&nbsp;der(s_rel).
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/gasForceCycle.png\"
alt=\"model Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.GasForce2\">
</blockquote>
</html>"));
  end GasForce2;

  model CylinderBase "One cylinder with analytic handling of kinematic loop"
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Length cylinderTopPosition=0.42
      "Length from crank shaft to end of cylinder.";
    parameter SI.Length crankLength=0.14 "Length of crank shaft in x direction";
    parameter SI.Length crankPinOffset=0.05
      "Offset of crank pin from center axis";
    parameter SI.Length crankPinLength=0.1
      "Offset of crank pin from center axis";
    parameter Cv.NonSIunits.Angle_deg cylinderInclinationAngle=0
      "Inclination of cylinder";
    parameter Cv.NonSIunits.Angle_deg crankAngleOffset=0
      "Offset for crank angle";
    parameter SI.Length pistonLength=0.1 "Length of cylinder"
      annotation (Dialog(group="Piston"));
    parameter SI.Length pistonCenterOfMass=pistonLength/2
      "Distance from frame_a to center of mass of piston"
      annotation (Dialog(group="Piston"));
    parameter SI.Mass pistonMass(min=0) = 6 "Mass of piston"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_11(min=0) = 0.0088
      "Inertia 11 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_22(min=0) = 0.0076
      "Inertia 22 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));
    parameter SI.Inertia pistonInertia_33(min=0) = 0.0088
      "Inertia 33 of piston with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Piston"));

    parameter SI.Length rodLength=0.175 "Length of rod"
      annotation (Dialog(group="Rod"));
    parameter SI.Length rodCenterOfMass=rodLength/2
      "Distance from frame_a to center of mass of piston"
      annotation (Dialog(group="Rod"));
    parameter SI.Mass rodMass(min=0) = 1 "Mass of rod"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_11(min=0) = 0.006
      "Inertia 11 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_22(min=0) = 0.0005
      "Inertia 22 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    parameter SI.Inertia rodInertia_33(min=0) = 0.006
      "Inertia 33 of rod with respect to center of mass frame, parallel to frame_a"
      annotation (Dialog(group="Rod"));
    final parameter SI.Length cylinderLength=cylinderTopPosition - (
        pistonLength + rodLength - crankPinOffset)
      "Maximum length of cylinder volume";

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(animation=false, r={crankLength -
          crankPinLength/2,crankPinOffset,0})
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation mounting(r={crankLength,0,0}, animation=
          false) annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation cylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=cylinderInclinationAngle) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle(
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=crankAngleOffset) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,-70})));
    Joints.Assemblies.JointRRP jointRRP(
      n_a={1,0,0},
      n_b={0,-1,0},
      rRod1_ia={0,rodLength,0},
      animation=false,
      rRod2_ib=-{0,pistonLength,0},
      s_offset=-cylinderTopPosition)
      annotation (Placement(transformation(
          origin={0,0},
          extent={{-20,20},{20,-20}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyShape connectingRod(
      animation=animation,
      r={0,rodLength,0},
      r_CM={0,rodLength/2,0},
      shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/rod.dxf",
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
          origin={50,0},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyShape piston(
      animation=animation,
      r={0,pistonLength,0},
      r_CM={0,pistonLength/2,0},
      shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf",
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
          origin={50,30},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    GasForce2 gasForce(L=cylinderLength, d=0.1)
      annotation (Placement(transformation(
          origin={10,60},
          extent={{10,10},{-10,-10}},
          rotation=180)));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation crank(animation=false, r={crankLength,0,0})
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={{-116,84},
              {-84,116}})));
    Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={{84,84},
              {116,116}})));
    Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{-116,
              -116},{-84,-84}})));
    Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,-116},
              {116,-84}})));
  equation

    connect(jointRRP.frame_ia, connectingRod.frame_a) annotation (Line(
        points={{20,-16},{50,-16},{50,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(mid.frame_b, jointRRP.frame_a) annotation (Line(
        points={{-40,-30},{-1.33227e-015,-30},{-1.33227e-015,-20}},
        color={95,95,95},
        thickness=0.5));
    connect(jointRRP.frame_ib, piston.frame_b) annotation (Line(
        points={{20,16},{30,16},{30,50},{50,50},{50,40}},
        color={95,95,95},
        thickness=0.5));
    connect(jointRRP.frame_b, cylinderInclination.frame_b) annotation (Line(
        points={{1.22125e-015,20},{0,20},{0,30},{-40,30}},
        color={95,95,95},
        thickness=0.5));
    connect(crankAngle.frame_b, mid.frame_a) annotation (Line(
        points={{-70,-60},{-70,-30},{-60,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_a, cylinderInclination.frame_a) annotation (Line(
        points={{-100,100},{-70,100},{-70,30},{-60,30}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_a, mounting.frame_a) annotation (Line(
        points={{-100,100},{-10,100}},
        color={95,95,95},
        thickness=0.5));
    connect(cylinder_b, mounting.frame_b) annotation (Line(
        points={{100,100},{10,100}},
        color={95,95,95},
        thickness=0.5));
    connect(crankAngle.frame_a, crank_a) annotation (Line(
        points={{-70,-80},{-70,-100},{-100,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(crank_a, crank.frame_a) annotation (Line(
        points={{-100,-100},{-10,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(crank.frame_b, crank_b) annotation (Line(
        points={{10,-100},{100,-100}},
        color={95,95,95},
        thickness=0.5));
    connect(gasForce.flange_a, jointRRP.bearing) annotation (Line(points={{0,60},{0,40},{8,40},{8,20}}, color={0,127,0}));
    connect(gasForce.flange_b, jointRRP.axis) annotation (Line(points={{20,60},{20,40},{16,40},{16,20}}, color={0,127,0}));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{-60,-60},{-60,64},{60,64},{60,-60},{100,-60},{100,114},{-100,114},{-100,-60},{-60,-60}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-58,53},{58,-23}},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-60,45},{60,39}},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,31},{60,25}},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,19},{60,13}},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-57,-23},{-40,-11},{40,-11},{57,-23},{-57,-23}},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Ellipse(
            extent={{-8,6},{4,-6}},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-40,-140},{40,-60}}, lineColor={192,192,192}),
          Line(
            points={{0,-100},{26,-70},{-2,0}},
            thickness=1),
          Text(
            extent={{-150,160},{150,120}},
            textString="%name",
            textColor={0,0,255}),
          Line(
            points={{-100,-100},{100,-100}},
            thickness=0.5)}), Documentation(info="<html>
<p>
Slider-crank mechanism with analytic handling of kinematic loop to model one cylinder in an engine.
</p>
</html>"));
  end CylinderBase;

  model Cylinder_analytic_CAD
    "One cylinder with analytic handling of kinematic loop and CAD visualization"
    extends CylinderBase;
    Visualizers.FixedShape crankShape(
      animation=animation,
      shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/crank.dxf",
      lengthDirection={1,0,0},
      extra=1,
      widthDirection={0,1,0},
      length=crankPinOffset/0.5,
      width=crankPinOffset/0.5,
      height=crankPinOffset/0.5,
      r_shape={crankLength - crankPinLength/2 - 0.002,0,0})
      annotation (Placement(transformation(
          origin={-90,-30},
          extent={{-10,10},{10,-10}},
          rotation=180)));
  equation

    connect(crankShape.frame_a, crankAngle.frame_b)
      annotation (Line(
        points={{-80,-30},{-70,-30},{-70,-60}},
        color={95,95,95},
        thickness=0.5));
    annotation (Documentation(info="<html>
<p>
Slider-crank mechanism with analytic handling of kinematic loop to model one cylinder in an engine.
</p>
</html>"));
  end Cylinder_analytic_CAD;

  model EngineV6_analytic "V6 engine with analytic loop handling"
    parameter Boolean animation=true "= true, if animation shall be enabled";
    replaceable model Cylinder = Cylinder_analytic_CAD constrainedby
      CylinderBase "Cylinder type"
         annotation(Documentation(info="<html>
<p>
Model of one cylinder of an engine with analytic loop handling of the slider crank mechanism.
</p>
</html>"));

    Cylinder cylinder1(
      crankAngleOffset=-30,
      cylinderInclinationAngle=-30,
      animation=animation) annotation (Placement(transformation(extent={{-90,
              -10},{-70,10}})));
    Cylinder cylinder2(
      crankAngleOffset=90,
      cylinderInclinationAngle=30,
      animation=animation) annotation (Placement(transformation(extent={{-60,
              -10},{-40,10}})));
    Cylinder cylinder3(
      cylinderInclinationAngle=-30,
      animation=animation,
      crankAngleOffset=210)
                           annotation (Placement(transformation(extent={{-30,
              -10},{-10,10}})));
    Cylinder cylinder4(
      cylinderInclinationAngle=30,
      animation=animation,
      crankAngleOffset=210)
                           annotation (Placement(transformation(extent={{0,-10},
              {20,10}})));
    Cylinder cylinder5(
      cylinderInclinationAngle=-30,
      animation=animation,
      crankAngleOffset=90) annotation (Placement(transformation(extent={{30,-10},
              {50,10}})));
    Cylinder cylinder6(
      cylinderInclinationAngle=30,
      animation=animation,
      crankAngleOffset=-30)
                           annotation (Placement(transformation(extent={{60,-10},
              {80,10}})));
    Joints.Revolute bearing(useAxisFlange=true,
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.06,
      animation=true) annotation (Placement(transformation(extent={{-90,-40},{
              -70,-60}})));
    Parts.BodyShape crank(
      animation=false,
      r={0,0,0},
      r_CM={6*0.1/2,0,0},
      I_22=1.e-5,
      I_33=1.e-5,
      m=6*30,
      I_11=0.1) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
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
        points={{-30,-50},{-20,-50},{-20,-30},{-90,-30},{-90,-10}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.axis, flange_b) annotation (Line(points={{-80,-60},{-80,-70},{90,-70},{90,0},{110,0}}));
    connect(frame_a, bearing.frame_a) annotation (Line(
        points={{0,-101},{0,-80},{-98,-80},{-98,-50},{-90,-50}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.frame_a, cylinder1.cylinder_a) annotation (Line(
        points={{-90,-50},{-98,-50},{-98,10},{-90,10}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,145},{150,105}},
            textColor={0,0,255},
            textString="%name"),
          Bitmap(extent={{-97,-39},{99,75}}, fileName=
                "modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_CAD.png")}),
        Documentation(info="<html>
<p>
Model of an engine with 6 cylinders where the algebraic loops of the slider crank mechanisms are
solved analytically.
</p>
</html>"));
  end EngineV6_analytic;

  partial block Engine1Base
    "Base model for one cylinder engine"

    inner Modelica.Mechanics.MultiBody.World world
      annotation (Placement(transformation(extent= {{-100,-100},{-80,-80}})));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder piston(diameter=0.1, r={0,-0.1,0})
      annotation (Placement(transformation(
          origin={90,40},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Mechanics.MultiBody.Parts.BodyBox connectingRod(
      widthDirection={1,0,0},
      width=0.02,
      height=0.06,
      color={0,0,200},
      r={0,-0.2,0})
      annotation (Placement(transformation(
          origin={90,-20},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Joints.Revolute bearing(useAxisFlange=true,
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.05) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      stateSelect=StateSelect.always,
      J=1,
      w(fixed=true,
        start = 10),
      phi(
        fixed=true,
        start=0.0,
        displayUnit="rad")) annotation (Placement(transformation(
            extent={{-60,-60},{-40,-40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank1(diameter=0.05, r={0.1,0,0})
      annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,0.1,0})
      annotation (Placement(transformation(
          origin={0,-80},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank3(r={0.1,0,0}, diameter=0.03) annotation (
                                   Placement(transformation(extent={{40,-76},{60,-56}})));
    Modelica.Mechanics.MultiBody.Parts.BodyBox crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-0.1,0}) annotation (Placement(transformation(
          origin={90,-80},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(r={0.05,0,0})
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=0,
          origin={20,-40})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(
      animation=false,
      r = {0.15,0.45,0})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,40})));
  equation
    connect(world.frame_b, bearing.frame_a)
      annotation (Line(
        points={{-80,-90},{-60,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(crank2.frame_a, crank1.frame_b) annotation (Line(
        points={{-4.44089e-16,-90},{-10,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(bearing.frame_b, crank1.frame_a) annotation (Line(
        points={{-40,-90},{-30,-90}},
        color={95,95,95},
        thickness=0.5));
    connect(world.frame_b, cylPosition.frame_a) annotation (Line(
        points={{-80,-90},{-70,-90},{-70,30}},
        color={95,95,95},
        thickness=0.5));
    connect(crank3.frame_b, crank4.frame_a) annotation (Line(
        points={{60,-66},{90,-66},{90,-70}},
        color={95,95,95},
        thickness=0.5));
    connect(inertia.flange_b, bearing.axis)
      annotation (Line(
        points={{-40,-50},{-30,-50},{-30,-70},{-50,-70},{-50,-80}}));
    connect(crank2.frame_b, crank3.frame_a)
      annotation (Line(
        points={{0,-70},{0,-66},{40,-66}},
        color={95,95,95},
        thickness=0.5));
    connect(crank2.frame_b, mid.frame_a)
      annotation (Line(
        points={{0,-70},{0,-40},{10,-40}},
        color={95,95,95},
        thickness=0.5));
    annotation (
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
Since this results in a <strong>planar</strong> loop there is the well known
difficulty that the cut-forces perpendicular to the loop cannot be
uniquely computed, as well as the cut-torques within the plane.
This ambiguity is resolved by using the option <strong>planarCutJoint</strong>
in the <strong>Advanced</strong> menu of one revolute joint in every planar loop
(here: joint b1). This option sets the cut-force in direction of the
axis of rotation, as well as the cut-torques perpendicular to the axis
of rotation at this joint to zero and makes the problem mathematically
well-formed.
</p>
<p>
An animation of this example is shown in the figure below.
</p><p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</p></html>"));
  end Engine1Base;

  partial block Engine1bBase
    "Base model for one cylinder engine with gas force"
    extends Engine1Base;

    GasForce2 gasForce(d=0.1, L=0.35)
      annotation (Placement(transformation(
        origin={90,80},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  end Engine1bBase;
  annotation (Documentation(info="<html>
<p>
This package contains utility functions used by some of the Loops example models.
</p>
</html>"));
end Utilities;

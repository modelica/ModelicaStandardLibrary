package Utilities "Utility models for Examples.Loops" 
  extends Modelica.Icons.Library;
  
  model Cylinder 
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
      animation=animation) annotation (extent=[45, 80; -16, 59], rotation=270);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Rod(
      widthDirection={1,0,0},
      height=0.06,
      color={0,0,200},
      width=0.02,
      r_shape={0,-0.02,0},
      r={0,rodLength,0},
      animation=animation) annotation (extent=[4, -2; 24, 18], rotation=90);
    Modelica.Mechanics.MultiBody.Joints.Revolute B2(
      n={1,0,0},
      phi_start=0,
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (extent=[4, 25; 24, 45], rotation=0);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-crankPinOffset,0},
      animation=animation) 
      annotation (extent=[30.5, -64; 50.5, -84], rotation=90);
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank3(
      r_shape={-0.01,0,0},
      length=0.12,
      diameter=0.03,
      r={crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[4.5, -60; 24.5, -40], rotation=0);
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank1(
      diameter=0.05,
      r_shape={-0.01,0,0},
      length=0.12,
      r={crankLength - crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[-50, -100; -30, -80], rotation=0);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,crankPinOffset,0},
      animation=animation) annotation (extent=[-20, -86; 0, -66], rotation=90);
    Modelica.Mechanics.MultiBody.Joints.Revolute B1(
      n={1,0,0},
      planarCutJoint=true,
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (extent=[4, -27; 24, -7], rotation=0);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(r={crankPinLength/2,0,0}, animation=
          false) annotation (extent=[-6, -46; 14, -26]);
    Modelica.Mechanics.MultiBody.Joints.ActuatedPrismatic Cylinder(
      s_start=-0.3,
      n={0,-1,0},
      boxWidth=0.02) annotation (extent=[4, 89; 24, 109], rotation=-90);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a crank_a 
      annotation (extent=[-120, -105; -100, -75]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b crank_b 
      annotation (extent=[100, -105; 120, -75]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a cylinder_a 
      annotation (extent=[-120, 115; -100, 145]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b cylinder_b 
      annotation (extent=[100, 115; 120, 145]);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (extent=[0, 120; 20, 140]);
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      n_y={0,cos(cylinderInclination),sin(cylinderInclination)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors) 
      annotation (extent=[-60, 30; -40, 50]);
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle1(
      n_y={0,cos(crankAngleOffset),sin(crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors) 
      annotation (extent=[-90, -100; -70, -80]);
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle2(
      n_y={0,cos(-crankAngleOffset),sin(-crankAngleOffset)},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors) 
      annotation (extent=[60, -100; 80, -80]);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation CylinderTop(r={0,cylinderTopPosition,0},
        animation=false) annotation (extent=[-40, 61; -20, 81], rotation=90);
    GasForce gasForce(L=cylinderLength, d=0.1) 
      annotation (extent=[40, 97; 60, 117], rotation=90);
  equation 
    connect(B1.frame_a, Mid.frame_b) annotation (points=[3, -17; -6, -17; -6, -29;
           22, -29; 22, -36; 15, -36], style(color=0, thickness=2));
    annotation (
      Coordsys(
        extent=[-100, -150; 100, 150],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Polygon(points=[-60, -50; -60, 100; 60, 100; 60, -52; 100, -52; 100,
              150; -100, 150; -100, -50; -60, -50], style(color=0, fillColor=8)),
        Rectangle(extent=[-58, 89; 58, 13], style(gradient=1, fillColor=8)),
        Rectangle(extent=[-60, 81; 60, 75], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 67; 60, 61], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 55; 60, 49], style(color=0, fillColor=0)),
        Polygon(points=[-60, 11; -42, 23; 38, 23; 56, 11; -60, 11], style(
              pattern=0, fillColor=7)),
        Ellipse(extent=[-6, 41; 2, 33], style(color=0, fillColor=0)),
        Ellipse(extent=[-40, -129; 40, -49], style(color=8)),
        Line(points=[0, -90; 26, -58; -2, 37], style(color=0, thickness=4)),
        Text(extent=[-150, -124; 164, -186], string="%name"),
        Line(points=[-100, -90; 100, -91], style(color=0, thickness=2))));
    connect(Mounting.frame_a, cylinder_a) 
      annotation (points=[-1, 130; -110, 130], style(color=0, thickness=2));
    
    connect(Mounting.frame_b, cylinder_b) 
      annotation (points=[21, 130; 110, 130], style(color=0, thickness=2));
    connect(Rod.frame_a, B1.frame_b) annotation (points=[14, -3; 14, -9; 30, -9;
           30, -17; 25, -17], style(color=0, thickness=2));
    connect(Cylinder.frame_b, Piston.frame_b) annotation (points=[14,88; 14,
          81.05; 14.5,81.05],  style(color=0, thickness=2));
    connect(Crank1.frame_a, CrankAngle1.frame_b) 
      annotation (points=[-51, -90; -69, -90], style(color=0, thickness=2));
    connect(B2.frame_a, Piston.frame_a) annotation (points=[3,35; -6,35; -6,49;
          14.5,49; 14.5,57.95],       style(color=0, thickness=2));
    connect(Rod.frame_b, B2.frame_b) annotation (points=[14, 19; 14, 23; 32, 23;
           32, 35; 25, 35], style(color=0, thickness=2));
    connect(CrankAngle1.frame_a, crank_a) 
      annotation (points=[-91, -90; -110, -90], style(color=0, thickness=2));
    connect(Crank4.frame_b, CrankAngle2.frame_a) annotation (points=[40.5, -85;
           40.5, -90; 59, -90], style(color=0, thickness=2));
    connect(CrankAngle2.frame_b, crank_b) 
      annotation (points=[81, -90; 110, -90], style(color=0, thickness=2));
    connect(Cylinder.bearing, gasForce.flange_b) annotation (points=[20, 103;
          34, 103; 34, 117; 50, 117], style(color=58));
    connect(Cylinder.axis, gasForce.flange_a) 
      annotation (points=[20, 91; 50, 91; 50, 97], style(color=58));
    connect(CylinderInclination.frame_b, CylinderTop.frame_a) 
      annotation (points=[-39, 40; -30, 40; -30, 60]);
    connect(CylinderInclination.frame_a, cylinder_a) annotation (points=[-61,
          40; -70, 40; -70, 130; -110, 130], style(color=0, thickness=2));
    connect(Crank1.frame_b, Crank2.frame_a) annotation (points=[-29, -90; -10,
          -90; -10, -87], style(color=0, thickness=2));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (points=[25.5, -50; 40.5,
           -50; 40.5, -63], style(color=0, thickness=2));
    connect(Crank3.frame_a, Crank2.frame_b) annotation (points=[3.5, -50; -10,
          -50; -10, -65], style(color=0, thickness=2));
    connect(Crank2.frame_b, Mid.frame_a) annotation (points=[-10, -65; -10, -36;
           -7, -36], style(color=0, thickness=2));
    connect(CylinderTop.frame_b, Cylinder.frame_a) annotation (points=[-30, 82;
           -30, 120; 14, 120; 14, 110], style(color=0, thickness=2));
  end Cylinder;
  
  model GasForce 
    import SI = Modelica.SIunits;
    
    extends Modelica.Mechanics.Translational.Interfaces.Compliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Length d "diameter of cylinder";
    parameter Real k0=0.01;
    parameter Real k1=1;
    parameter Real k=1;
    constant Real pi=Modelica.Constants.pi;
    constant Real PI=Modelica.Constants.pi;
    // Only for compatibility reasons
    SI.Position x;
    SI.Position y;
    SI.Density dens;
    SI.Pressure press "cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel;
    annotation (Icon(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3,
              fillPattern =                                                  1)),
        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3,
              fillPattern =                                                  1)),
        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60, -4;
               60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")), Diagram(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3,
              fillPattern =                                                  1)),
        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3,
              fillPattern =                                                  1)),
        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60, -4;
               60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")));
    
  equation 
    y = -s_rel/L;
    x = 1 + s_rel/L;
    v_rel = der(s_rel);
    
    press = if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3 +
      151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 + 14761814
      *x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4 +
      14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4);
    
    f = -1.0E5*press*pi*d^2/4;
    
    V = k0 + k1*(1 - x);
    dens = 1/V;
    press*V = k*T;
  end GasForce;
  
  model GasForce2 "Rough approximation of gas force in a cylinder" 
    import SI = Modelica.SIunits;
    
    extends Modelica.Mechanics.Translational.Interfaces.Compliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Length d "diameter of cylinder";
    parameter Real k0=0.01;
    parameter Real k1=1;
    parameter Real k=1;
    constant Real pi=Modelica.Constants.pi;
    constant Real PI=Modelica.Constants.pi;
    SI.Position x;
    SI.Density dens;
    SI.Pressure press "cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel;
    annotation (Icon(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-13,4; -16,4; -65,4; -65,15; -90,0; -65,-15; -65,-4;
              -13,-4; -13,4],
                       style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name"),
        Text(
          extent=[-135,44; -99,19],
          style(color=10),
          string="a"),
        Text(
          extent=[97,40; 133,15],
          style(color=10),
          string="b"),
        Polygon(points=[12,4; 70,4; 65,4; 65,15; 90,0; 65,-15; 65,-4; 12,-4; 12,
              4],      style(
            color=1,
            fillColor=1,
            fillPattern=1))),                               Diagram(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name"),
        Polygon(points=[12,5; 70,5; 65,5; 65,16; 90,1; 65,-14; 65,-3; 12,-3; 12,
              5],      style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-13,5; -16,5; -65,5; -65,16; -90,1; -65,-14; -65,-3;
              -13,-3; -13,5],
                       style(
            color=1,
            fillColor=1,
            fillPattern=1))),
      Coordsys(grid=[1,1], component=[20,20]),
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
    
  equation 
    x = 1 - s_rel/L;
    v_rel = der(s_rel);
    
    press = if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3 +
      151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 + 14761814
      *x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4 +
      14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4);
    
    f = -1.0E5*press*pi*d^2/4;
    
    V = k0 + k1*(1 - x);
    dens = 1/V;
    press*V = k*T;
    
    assert(s_rel >= -1.e-12, "flange_b.s - flange_a.s (= " + String(s_rel) +
                             ") >= 0 required for GasForce component.\n" +
                             "Most likely, the component has to be flipped.");
    assert(s_rel <= L + 1.e-12, " flange_b.s - flange_a.s (= " + String(s_rel) +
                                " <= L (" + String(L) + ") required for GasForce component.\n" +
                                "Most likely, parameter L is not correct.");
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
    parameter SI.Length pistonLength=0.1 "|Piston| Length of cylinder";
    parameter SI.Length pistonCenterOfMass=pistonLength/2 
      "|Piston| Distance from frame_a to center of mass of piston";
    parameter SI.Mass pistonMass(min=0)=6 "|Piston| Mass of piston";
    parameter SI.Inertia pistonInertia_11(min=0)=0.0088 
      "|Piston| Inertia 11 of piston with respect to center of mass frame, parallel to frame_a";
    parameter SI.Inertia pistonInertia_22(min=0)=0.0076 
      "|Piston| Inertia 22 of piston with respect to center of mass frame, parallel to frame_a";
    parameter SI.Inertia pistonInertia_33(min=0)=0.0088 
      "|Piston| Inertia 33 of piston with respect to center of mass frame, parallel to frame_a";
    
    parameter SI.Length rodLength=0.175 "|Rod| Length of rod";
    parameter SI.Length rodCenterOfMass=rodLength/2 
      "|Rod| Distance from frame_a to center of mass of piston";
    parameter SI.Mass rodMass(min=0)=1 "|Rod| Mass of rod";
    parameter SI.Inertia rodInertia_11(min=0)=0.006 
      "|Rod| Inertia 11 of rod with respect to center of mass frame, parallel to frame_a";
    parameter SI.Inertia rodInertia_22(min=0)=0.0005 
      "|Rod| Inertia 22 of rod with respect to center of mass frame, parallel to frame_a";
    parameter SI.Inertia rodInertia_33(min=0)=0.006 
      "|Rod| Inertia 33 of rod with respect to center of mass frame, parallel to frame_a";
    final parameter SI.Length cylinderLength=cylinderTopPosition - (
        pistonLength + rodLength - crankPinOffset) 
      "Maximum length of cylinder volume";
    
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(animation=false, r={crankLength -
          crankPinLength/2,crankPinOffset,0}) 
      annotation (extent=[-44, -30; -24, -10]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a crank_a 
      annotation (extent=[-120, -115; -100, -85]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b crank_b 
      annotation (extent=[100, -115; 120, -85]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a cylinder_a 
      annotation (extent=[-120, 84; -100, 114]);
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b cylinder_b 
      annotation (extent=[100, 84; 120, 114]);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (extent=[-3, 90; 17, 110]);
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=cylinderInclination) annotation (extent=[-44, 30; -24, 50]);
    Modelica.Mechanics.MultiBody.Parts.FixedRotation CrankAngle(
      animation=false,
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
      n={1,0,0},
      angle=crankAngleOffset) annotation (extent=[-84, -80; -64, -60]);
    Joints.Assemblies.JointRRP jointRRP(
      n_a={1,0,0},
      n_b={0,-1,0},
      rRod1_ia={0,rodLength,0},
      animation=false,
      rRod2_ib=-{0,pistonLength,0},
      s_offset=-cylinderTopPosition) 
      annotation (extent=[20, -8; -20, 32], rotation=90);
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
      I_33=rodInertia_33) annotation (extent=[39, -1; 59, 19], rotation=90);
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
      I_33=pistonInertia_33) annotation (extent=[60, 60; 40, 40], rotation=270);
    GasForce gasForce(L=cylinderLength, d=0.1) 
      annotation (extent=[-11, 60; 9, 80], rotation=180);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Polygon(points=[-60, -61; -60, 64; 60, 64; 60, -61; 100, -61; 100, 114;
               -100, 114; -100, -61; -60, -61], style(color=0, fillColor=8)),
        Rectangle(extent=[-58, 63; 58, -13], style(gradient=1, fillColor=8)),
        Rectangle(extent=[-60, 55; 60, 49], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 41; 60, 35], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 29; 60, 23], style(color=0, fillColor=0)),
        Polygon(points=[-57, -13; -39, -1; 41, -1; 59, -13; -57, -13], style(
              pattern=0, fillColor=7)),
        Ellipse(extent=[-6, 15; 2, 7], style(color=0, fillColor=0)),
        Ellipse(extent=[-41, -139; 39, -59], style(color=8)),
        Line(points=[-1, -99; 25, -67; -2, 10], style(color=0, thickness=4)),
        Text(extent=[-156, 178; 158, 116], string="%name"),
        Line(points=[-100, -99; 100, -100], style(color=0, thickness=2))));
    
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Crank(animation=false, r={crankLength,0,0}) 
      annotation (extent=[-10, -110; 10, -90]);
  equation 
    
    connect(Mounting.frame_a, cylinder_a) annotation (points=[-4, 100; -105,
          100; -105, 99; -110, 99], style(color=0, thickness=2));
    connect(Mounting.frame_b, cylinder_b) annotation (points=[18, 100; 100, 100;
           100, 99; 110, 99], style(color=0, thickness=2));
    connect(CylinderInclination.frame_a, cylinder_a) annotation (points=[-45,
          40; -55, 40; -55, 100; -105, 100; -105, 99; -110, 99], style(color=0,
           thickness=2));
    connect(jointRRP.frame_ia, Rod.frame_a) annotation (points=[22,-4; 49,-4;
          49,-2],   style(color=0, thickness=2));
    connect(Mid.frame_b, jointRRP.frame_a) annotation (points=[-23,-20;
          1.34707e-015,-20; 1.34707e-015,-10],   style(color=0, thickness=2));
    connect(gasForce.flange_a, jointRRP.axis) 
      annotation (points=[9,70; 16,70; 16,34],    style(color=58));
    connect(jointRRP.bearing, gasForce.flange_b) annotation (points=[8,34; 8,52;
          -20,52; -20,70; -11,70],        style(color=58));
    connect(jointRRP.frame_ib, Piston.frame_b) annotation (points=[22, 28; 30,
          28; 30, 70; 50, 70; 50, 61], style(color=0, thickness=2));
    connect(jointRRP.frame_b, CylinderInclination.frame_b) annotation (points=[
          -1.34707e-015,34; 1,34; 1,40; -23,40],     style(color=0, thickness=2));
    connect(Crank.frame_b, crank_b) 
      annotation (points=[11, -100; 110, -100], style(color=0, thickness=2));
    connect(Crank.frame_a, crank_a) 
      annotation (points=[-11, -100; -110, -100], style(color=0, thickness=2));
    connect(CrankAngle.frame_b, Mid.frame_a) annotation (points=[-63, -70; -56,
           -70; -56, -20; -45, -20], style(color=0, thickness=2));
    connect(CrankAngle.frame_a, crank_a) annotation (points=[-85, -70; -94, -70;
           -94, -100; -110, -100], style(color=0, thickness=2));
  end CylinderBase;
  
  model Cylinder_analytic_CAD 
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
      annotation (extent=[0, -60; -20, -80], rotation=-180);
  equation 
    
    annotation (Coordsys(grid=[1, 1], component=[20, 20]), Diagram);
    connect(CrankShape.frame_a, CrankAngle.frame_b) 
      annotation (points=[-21, -70; -63, -70], style(color=0, thickness=2));
  end Cylinder_analytic_CAD;
  
  model EngineV6_analytic "V6 engine with analytic loop handling" 
    import SI = Modelica.SIunits;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    replaceable model Cylinder = Cylinder_analytic_CAD extends CylinderBase 
      "Cylinder type";
    /*
annotation (choices(choice(redeclare model Cylinder = 
            Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic_CAD 
          "Analytic loop handling + CAD animation"), choice(redeclare model 
          Cylinder = Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic 
          "Analytic loop handling + standard animation")));
*/
    
    Cylinder cylinder1(
      crankAngleOffset=-30,
      cylinderInclination=-30,
      animation=animation) annotation (extent=[-90, -10; -70, 10]);
    Cylinder cylinder2(
      crankAngleOffset=90,
      cylinderInclination=30,
      animation=animation) annotation (extent=[-60, -10; -40, 10]);
    Cylinder cylinder3(
      crankAngleOffset=-150,
      cylinderInclination=-30,
      animation=animation) annotation (extent=[-30, -10; -10, 10]);
    Cylinder cylinder4(
      crankAngleOffset=-90,
      cylinderInclination=30,
      animation=animation) annotation (extent=[0, -10; 20, 10]);
    Cylinder cylinder5(
      crankAngleOffset=300,
      cylinderInclination=-30,
      animation=animation) annotation (extent=[30, -10; 50, 10]);
    Cylinder cylinder6(
      crankAngleOffset=150,
      cylinderInclination=30,
      animation=animation) annotation (extent=[60, -10; 80, 10]);
    Joints.ActuatedRevolute bearing(
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.06,
      animation=true) annotation (extent=[-90, -40; -70, -60], rotation=0);
    Parts.BodyShape crank(
      animation=false,
      r_CM={6*0.1/2,0,0},
      I_22=1.e-5,
      I_33=1.e-5,
      m=6*30,
      I_11=0.1) annotation (extent=[-50, -60; -30, -40]);
    Interfaces.Frame_a frame_a 
      annotation (extent=[-15, -110; 15, -90], rotation=-90);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
      annotation (extent=[100, -10; 120, 10]);
  equation 
    connect(cylinder1.crank_b, cylinder2.crank_a) 
      annotation (points=[-69, -10; -61, -10], style(color=0, thickness=2));
    connect(cylinder2.cylinder_a, cylinder1.cylinder_b) annotation (points=[-61,
           9.9; -61, 10; -69, 9.9], style(color=0, thickness=2));
    connect(cylinder3.cylinder_a, cylinder2.cylinder_b) annotation (points=[-31,
           9.9; -35, 10; -35, 9.9; -39, 9.9], style(color=0, thickness=2));
    connect(cylinder3.crank_a, cylinder2.crank_b) 
      annotation (points=[-31, -10; -39, -10], style(color=0, thickness=2));
    connect(cylinder3.cylinder_b, cylinder4.cylinder_a) annotation (points=[-9,
           9.9; -5, 10; -5, 9.9; -1, 9.9], style(color=0, thickness=2));
    connect(cylinder3.crank_b, cylinder4.crank_a) 
      annotation (points=[-9, -10; -1, -10], style(color=0, thickness=2));
    connect(cylinder4.cylinder_b, cylinder5.cylinder_a) annotation (points=[21,
           9.9; 25, 10; 29, 9.9], style(color=0, thickness=2));
    connect(cylinder4.crank_b, cylinder5.crank_a) 
      annotation (points=[21, -10; 29, -10], style(color=0, thickness=2));
    connect(cylinder5.cylinder_b, cylinder6.cylinder_a) annotation (points=[51,
           9.9; 55, 10; 59, 9.9], style(color=0, thickness=2));
    connect(cylinder5.crank_b, cylinder6.crank_a) 
      annotation (points=[51, -10; 59, -10], style(color=0, thickness=2));
    annotation (
      Icon(
        Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
        Text(
          extent=[-137, 160; 137, 104],
          style(color=3),
          string="%name"),
        Bitmap(extent=[-97, 75; 99, -39], name=
              "../../../../Images/MultiBody/Examples/Loops/EngineV6_CAD.png")),
      Coordsys(grid=[1, 1], component=[20, 20]),
      Diagram);
    connect(cylinder1.cylinder_a, frame_a) annotation (points=[-91, 9.9; -91,
          10; -100, 10; -100, -80; 0, -80; 0, -100], style(color=0, thickness=2));
    connect(bearing.frame_a, frame_a) annotation (points=[-91, -50; -100, -50;
          -100, -80; 0, -80; 0, -100], style(color=0, thickness=2));
    connect(bearing.frame_b, crank.frame_a) 
      annotation (points=[-69, -50; -51, -50], style(color=0, thickness=2));
    connect(crank.frame_b, cylinder1.crank_a) annotation (points=[-29, -50; -20,
           -50; -20, -26; -95, -26; -95, -10; -91, -10], style(color=0,
          thickness=2));
    connect(bearing.axis, flange_b) annotation (points=[-80, -60; -80, -66; 90,
           -66; 90, 0; 110, 0], style(color=0));
  end EngineV6_analytic;
  
  partial model Engine1bBase "Model of one cylinder engine with gas force" 
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    annotation (
      experiment(StopTime=0.5),
      Diagram,
      Coordsys(
        extent=[-100, -120; 150, 120],
        grid=[1, 1],
        component=[20, 20]),
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
</html>"),
      experimentSetupOutput);
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Piston(diameter=0.1, r={0,-0.1,0}) 
      annotation (extent=[150,43; 90,63],   rotation=270);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Rod2(
      widthDirection={1,0,0},
      width=0.02,
      height=0.06,
      color={0,0,200},
      r={0,0.2,0})     annotation (extent=[110,0; 130,20],   rotation=90);
    Modelica.Mechanics.MultiBody.Joints.ActuatedRevolute Bearing(
      n={1,0,0},
      cylinderLength=0.02,
      cylinderDiameter=0.05) annotation (extent=[-50,-80; -30,-100],  rotation=0);
    inner Modelica.Mechanics.MultiBody.World world annotation (extent=[-90,-100;
          -70,-80]);
    Modelica.Mechanics.Rotational.Inertia Inertia(
      J=0.1,
      w(fixed=true, stateSelect=StateSelect.always),
      phi(
        fixed=true,
        stateSelect=StateSelect.always,
        start=0.001))                    annotation (extent=[-68,-120; -48,-100]);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-0.1,0}) annotation (extent=[65.5,-65; 85.5,-85],     rotation=90);
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank3(r={0.1,0,0}, diameter=0.03) annotation (
      extent=[41.5,-71; 61.5,-51],
      rotation=0,
      style(color=0, thickness=2));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder Crank1(diameter=0.05, r={0.1,0,0}) 
      annotation (extent=[-16,-100; 4,-80],   rotation=0);
    Modelica.Mechanics.MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,0.1,0}) 
                  annotation (extent=[20,-86; 40,-66],   rotation=90);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mid(r={0.05,0,0}) 
      annotation (extent=[30,-53; 50,-33]);
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(                 animation=false, r={0.15,
          0.55,0}) 
      annotation (extent=[-40.5,100; -20.5,120]);
    Utilities.GasForce2 gasForce(        d=0.1, L=0.35) 
      annotation (extent=[109,107; 129,87],rotation=90);
  equation 
    connect(world.frame_b, Bearing.frame_a) 
      annotation (points=[-69,-90; -51,-90],   style(color=0, thickness=2));
    connect(Crank2.frame_a, Crank1.frame_b) annotation (points=[30,-87; 30,-90; 5,
          -90],      style(
        color=0,
        thickness=2,
        fillColor=8,
        fillPattern=1));
    connect(Crank2.frame_b, Crank3.frame_a) annotation (points=[30,-65; 30,-61;
          40.5,-61],   style(
        color=0,
        thickness=2,
        fillColor=8,
        fillPattern=1));
    connect(Bearing.frame_b, Crank1.frame_a) annotation (points=[-29,-90; -17,-90],
         style(
        color=0,
        thickness=2,
        fillColor=8,
        fillPattern=1));
    connect(world.frame_b, cylPosition.frame_a) annotation (points=[-69,-90; -60,
          -90; -60,110; -41.5,110],   style(color=0, thickness=2));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (points=[62.5,-61; 75,-61;
          75,-64; 75.5,-64],          style(color=0, thickness=2));
    connect(Inertia.flange_b, Bearing.axis) annotation (points=[-48,-110; -40,
          -110; -40,-100],
                     style(
        color=0,
        fillColor=7,
        fillPattern=1));
    connect(Mid.frame_a, Crank2.frame_b) annotation (points=[29,-43; 23,-43; 23,
          -61; 30,-61; 30,-65],    style(color=0, thickness=2));
  end Engine1bBase;
end Utilities;

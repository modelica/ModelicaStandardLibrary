package Types "Constants and types with choices, especially to build menus" 
  extends Modelica.Icons.Library;
  annotation (preferedView="info", Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used in the
MultiBody library. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
  
  type Axis = Real[3] "Axis vector with choices for menus" annotation (
    preferedView="text",
    Evaluate=true,
    choices(
      choice={1,0,0} "{1,0,0} \"x axis\"",
      choice={0,1,0} "{0,1,0} \"y axis\"",
      choice={0,0,1} "{0,0,1} \"z axis\"",
      choice={-1,0,0} "{-1,0,0} \"negative x axis\"",
      choice={0,-1,0} "{0,-1,0} \"negative y axis\"",
      choice={0,0,-1} "{0,0,-1} \"negative z axis\""));
  
  type AxisLabel = String "Label of axis with choices for menus" annotation (
      preferedView="text", choices(
      choice="x" "x",
      choice="y" "y",
      choice="z" "z"));
  
  type RotationSequence = Integer[3] (min={1,1,1}, max={3,3,3}) 
    "Sequence of planar frame rotations with choices for menus" annotation (
    preferedView="text",
    Evaluate=true,
    choices(
      choice={1,2,3} "{1,2,3} \"Cardan/Tait-Bryan angles\"",
      choice={3,1,3} "{3,1,3} \"Euler angles\"",
      choice={3,2,1} "{3,2,1}"));
  
  type Color = Integer[3] (min=0, max=255) 
    "RGB representation of color (will be improved with a color editor)" 
    annotation (preferedView="text", choices(
      choice={0,0,0} "{0,0,0}       \"black\"",
      choice={155,0,0} "{155,0,0}     \"dark red\"",
      choice={255,0,0} "{255,0,0 }    \"red\"",
      choice={255,65,65} "{255,65,65}   \"light red\"",
      choice={0,128,0} "{0,128,0}     \"dark green\"",
      choice={0,180,0} "{0,180,0}     \"green\"",
      choice={0,230,0} "{0,230,0}     \"light green\"",
      choice={0,0,200} "{0,0,200}     \"dark blue\"",
      choice={0,0,255} "{0,0,255}     \"blue\"",
      choice={0,128,255} "{0,128,255}   \"light blue\"",
      choice={255,255,0} "{255,255,0}   \"yellow\"",
      choice={255,0,255} "{255,0,255}   \"pink\"",
      choice={100,100,100} "{100,100,100} \"dark grey\"",
      choice={155,155,155} "{155,155,155} \"grey\"",
      choice={255,255,255} "{255,255,255} \"white\""));
  
  type ShapeType = String 
    "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, dxf-file)"
     annotation (preferedView="text", choices(
      choice="box" "\"box\"",
      choice="sphere" "\"sphere\"",
      choice="cylinder" "\"cylinder\"",
      choice="pipecylinder" "\"pipecylinder\"",
      choice="cone" "\"cone\"",
      choice="pipe" "\"pipe\"",
      choice="beam" "\"beam\"",
      choice="gearwheel" "\"gearwheel\"",
      choice="spring" "\"spring\"",
      choice="1" "File \"1.dxf\" in current directory",
      choice="2" "File \"2.dxf\" in current directory",
      choice="3" "File \"3.dxf\" in current directory",
      choice="4" "File \"4.dxf\" in current directory",
      choice="5" "File \"5.dxf\" in current directory",
      choice="6" "File \"6.dxf\" in current directory",
      choice="7" "File \"7.dxf\" in current directory",
      choice="8" "File \"8.dxf\" in current directory",
      choice="9" "File \"9.dxf\" in current directory"));
  
  type AngularVelocity_degs = Real (final quantity="AngularVelocity", final unit
        =    "deg/s");
  
  type AngularAcceleration_degs2 = Real (final quantity="AngularAcceleration",
        final unit="deg/s2");
  
  package RotationTypes 
    "Type, constants and menu choices for rotation types, as temporary solution until enumerations are available" 
    
    annotation (preferedView="text");
    
    extends Modelica.Icons.Library;
    constant Integer RotationAxis=1;
    constant Integer TwoAxesVectors=2;
    constant Integer PlanarRotationSequence=3;
    type Temp 
      "Temporary type of RotationTypes with choices for menus (until enumerations are available)" 
      
      extends Integer;
      annotation (Evaluate=true, choices(
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis 
            "Rotation axis",
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors 
            "Two axes vectors",
          choice=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence 
            "Planar rotation sequence"));
      
    end Temp;
  end RotationTypes;
  
  package GravityTypes 
    "Type, constants and menu choices for gravity fields, as temporary solution until enumerations are available" 
    
    annotation (preferedView="text");
    extends Modelica.Icons.Library;
    constant Integer NoGravity=0;
    constant Integer UniformGravity=1;
    constant Integer PointGravity=2;
    
    type Temp 
      "Temporary type of gravity field with choices for menus (until enumerations are available)" 
      
      extends Integer;
      annotation (choices(
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity 
            "no gravity",
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity 
            "uniform gravity",
          choice=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity 
            "point gravity"));
      
    end Temp;
  end GravityTypes;
  
  package Init 
    "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available" 
    
    annotation (preferedView="text");
    extends Modelica.Icons.Library;
    
    constant Integer Free=1;
    constant Integer PositionVelocity=2;
    constant Integer SteadyState=3;
    constant Integer Position=4;
    constant Integer Velocity=5;
    constant Integer VelocityAcceleration=6;
    constant Integer PositionVelocityAcceleration=7;
    
    type Temp 
      "Temporary type of Init with choices for menus (until enumerations are available)" 
      
      extends Integer;
      annotation (choices(
          choice=Modelica.Mechanics.MultiBody.Types.Init.Free 
            "free (no initialization)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity 
            "initialize generalized position and velocity variables",
          choice=Modelica.Mechanics.MultiBody.Types.Init.SteadyState 
            "initialize in steady state (velocity and acceleration are zero)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.Position 
            "initialize only generalized position variable(s)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.Velocity 
            "initialize only generalized velocity variable(s)",
          choice=Modelica.Mechanics.MultiBody.Types.Init.VelocityAcceleration 
            "initialize generalized velocity and acceleration variables",
          choice=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration 
            "initialize generalized position, velocity and acceleration variables"));
      
    end Temp;
  end Init;
  
  package Defaults "Default settings of the MultiBody library via constants" 
    annotation (preferedView="text");
    extends Modelica.Icons.Library;
    
    // Color defaults
    constant Types.Color BodyColor={0,128,255} 
      "Default color for body shapes that have mass (light blue)";
    constant Types.Color RodColor={155,155,155} 
      "Default color for massless rod shapes (grey)";
    constant Types.Color JointColor={255,0,0} 
      "Default color for elementary joints (red)";
    constant Types.Color ForceColor={0,128,0} 
      "Default color for force arrow (dark green)";
    constant Types.Color TorqueColor={0,128,0} 
      "Default color for torque arrow (dark green)";
    constant Types.Color SpringColor={0,0,255} 
      "Default color for a spring (blue)";
    constant Types.Color SensorColor={255,255,0} 
      "Default color for sensors (yellow)";
    constant Types.Color FrameColor={0,0,0} 
      "Default color for frame axes and labels (black)";
    constant Types.Color ArrowColor={0,0,255} 
      "Default color for arrows and double arrows (blue)";
    
    // Arrow and frame defaults
    constant Real FrameHeadLengthFraction=5.0 
      "Frame arrow head length / arrow diameter";
    constant Real FrameHeadWidthFraction=3.0 
      "Frame arrow head width / arrow diameter";
    constant Real FrameLabelHeightFraction=3.0 
      "Height of frame label / arrow diameter";
    constant Real ArrowHeadLengthFraction=4.0 
      "Arrow head length / arrow diameter";
    constant Real ArrowHeadWidthFraction=3.0 
      "Arrow head width / arrow diameter";
    
    // Other defaults
    constant SI.Diameter BodyCylinderDiameterFraction=3 
      "Default for body cylinder diameter as a fraction of body sphere diameter";
    constant Real JointRodDiameterFraction=2 
      "Default for rod diameter as a fraction of joint sphere diameter attached to rod";
    
    /*
  constant Real N_to_m(unit="N/m") = 1000 
    "Default force arrow scaling (length = force/N_to_m_default)";
  constant Real Nm_to_m(unit="N.m/m") = 1000 
    "Default torque arrow scaling (length = torque/Nm_to_m_default)";
*/
  end Defaults;
  
end Types;

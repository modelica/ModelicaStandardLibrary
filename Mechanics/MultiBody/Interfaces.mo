package Interfaces "Connectors and partial models for 3D mechanical components" 
  
  extends Modelica.Icons.Library;
  
  annotation(Window(
      x=0.03,
      y=0.1,
      width=0.38,
      height=0.26,
      library=1,
      autolayout=1));
  
  connector Frame "Frame of a mechanical system" 
    import SI = Modelica.SIunits;
    SI.Position r_0[3] 
      "Position vector from world frame to the connector frame origin, resolved in world frame";
    Frames.Orientation R 
      "Orientation object to rotate the world frame into the connector frame";
    flow SI.Force f[3] "Cut-force resolved in connector frame" annotation (
        unassignedMessage="All Forces cannot be uniquely calculated. 
The reason could be that the mechanism contains
a planar loop or that joints constrain the
same motion. For planar loops, use in one
revolute joint per loop the option
PlanarCutJoint=true in the Advanced menu.");
    flow SI.Torque t[3] "Cut-torque resolved in connector frame";
  end Frame;
  
  connector Frame_a "Frame a of a mechanical element" 
    extends Frame;
    
    annotation (defaultComponentName="frame_a",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Rectangle(extent=[0, 100; 100, -100], style(
            color=0,
            thickness=2,
            fillColor=8))),
      Diagram(Text(
          extent=[-136, -102; 134, -198],
          string="%name",
          style(color=0)), Rectangle(extent=[0, 100; 100, -100], style(
            color=0,
            thickness=2,
            fillColor=8))),
      Terminal(Polygon(points=[0, 0; -100, -100; 100, -100; 100, 100; -100, 100;
               0, 0], style(fillColor=3))),
      Window(
        x=0.21,
        y=0.18,
        width=0.71,
        height=0.65));
  end Frame_a;
  
  connector Frame_b "Frame b of a mechanical element" 
    extends Frame;
    annotation (defaultComponentName="frame_b",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Rectangle(extent=[-100, 100; 0, -100], style(
            color=0,
            thickness=2,
            fillColor=7))),
      Diagram(Rectangle(extent=[-100, 100; 0, -100], style(
            color=0,
            thickness=2,
            fillColor=7)), Text(
          extent=[-126, -110; 144, -206],
          string="%name",
          style(color=0))),
      Terminal(Polygon(points=[-100, -100; 0, -100; 100, 0; 0, 100; -100, 100;
              -100, -100])),
      Window(
        x=0.06,
        y=0.09,
        width=0.63,
        height=0.6));
  end Frame_b;
  
  connector Frame_resolve 
    "Frame of a mechanical element that is solely used to provide orientation information" 
    
    extends Frame;
    
    annotation (defaultComponentName="frame_resolve",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Rectangle(extent=[0, 100; 100, -100], style(
            color=0,
            pattern=3,
            fillColor=8)), Rectangle(extent=[0, 100; 100, -100], style(color=0))),
      Diagram(
        Text(
          extent=[-136, -102; 134, -198],
          string="%name",
          style(color=0)),
        Rectangle(extent=[0, 100; 100, -100], style(
            color=0,
            pattern=3,
            fillColor=8)),
        Rectangle(extent=[0, 100; 100, -100], style(color=0))),
      Terminal(Polygon(points=[0, 0; -100, -100; 100, -100; 100, 100; -100, 100;
               0, 0], style(fillColor=3))),
      Window(
        x=0.21,
        y=0.18,
        width=0.71,
        height=0.65));
    
  end Frame_resolve;
  
  partial model PartialTwoFrames 
    "Base model for components providing two frame connectors + outer world + assert to guarantee that the component is connected" 
    
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of component is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of component is not connected");
    annotation (
      Icon(Text(
          extent=[-128, -16; -92, -41],
          style(color=10),
          string="a"), Text(
          extent=[97, -19; 133, -44],
          style(color=10),
          string="b")),
      Documentation(info="<HTML>
<p>
This partial model provides two frame connectors, access to the world
object and an assert to check that both frame connectors are connected.
Therefore, inherit from this partial model if the two frame connectors are
needed and if the two frame connectors should be connected for a correct model.
</p>
</HTML>"),
      Coordsys(grid=[1, 1], component=[20, 20]));
    
  end PartialTwoFrames;
  
  partial model PartialElementaryJoint 
    "Base model of elementary joints (has two frames + outer world + assert to guarantee that the joint is connected)" 
    
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    defineBranch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of joint object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of joint object is not connected");
    annotation (Documentation(info="<HTML>
<p>
All <b>elementary joints</b> should inherit from this base model, i.e.,
joints that are directly defined by equations, provided they compute
either the rotation object of frame_b from the rotation object of frame_a
and from relative quantities (or vice versa), or there is a constraint
equation between the rotation objects of the two frames.
In other cases, a joint object should inherit from 
<b>Interfaces.PartialTwoFrames</b> (e.g., joint Spherical, because there
is no constraint between the rotation objects of frame_a and frame_b
or joint Cylindrical because it is not an elementary joint).
</p>
<p>
This partial model provides two frame connectors, a \"defineBranch\" 
between frame_a and frame_b, access to the world
object and an assert to check that both frame connectors are connected.
</p>
</HTML>
 "), Icon);
  end PartialElementaryJoint;
  
  partial model PartialForce 
    "Superclass of force elements (provide frame_b.f and frame_b.t in subclasses)" 
    
    import SI = Modelica.SIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    SI.Position r_rel_b[3] 
      "Position vector from origin of frame_a to origin of frame_b, resolved in frame_b";
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of force object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of force object is not connected");
    
    /* Determine relative position vector
     between frame_a and frame_b
  */
    r_rel_b = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
    
    /* Force and torque balance between frame_a and frame_b */
    zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.
       R);
    zeros(3) = frame_a.t + Frames.resolveRelative(frame_b.t + cross(r_rel_b,
      frame_b.f), frame_b.R, frame_a.R);
    annotation (Documentation(info="<HTML>
<p>
All <b>3-dimensional force</b> and <b>torque elements</b> 
should be based on this superclass.
This model defines frame_a and frame_b, computes the relative
translation and rotation between the two frames and calculates
the cut-force and cut-torque at frame_a by a force and torque
balance from the cut-force and cut-torque at frame_b.
As a result, in a subclass, only the relationship between 
the cut-force and cut-torque at frame_b has to be defined as
a function of the following relative quantities:
</p>
<pre>
  r_rel_b[3]: Position vector from origin of frame_a to origin 
              of frame_b, resolved in frame_b
  R_rel     : Relative orientation object to rotate from frame_a to frame_b
</pre>
<p>
Assume that force f = {100,0,0} should be applied on the body
to which this force element is attached at frame_b, then
the definition should be:
</p>
<pre>
   <b>model</b> Constant_x_Force
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialForce;
   <b>equation</b>
      frame_b.f = {-100, 0, 0};
      frame_b.t = zeros(3);
   <b>end</b> Constant_x_Force;
</pre>
<p>
Note, that frame_b.f and frame_b.t are flow variables and therefore
the negative value of frame_b.f and frame_b.t is acting at the part
to which this force element is connected.
</p>
</HTML>"), Icon(Text(
          extent=[-136, 42; -100, 17],
          style(color=10),
          string="a"), Text(
          extent=[102, 44; 138, 19],
          style(color=10),
          string="b")));
  end PartialForce;
  
  partial model PartialLineForce "Base model of line force elements" 
    import SI = Modelica.SIunits;
    parameter SI.Position s_small=1.E-6 
      "|Advanced|| Prevent zero-division if relative distance s=0";
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    SI.Force f 
      "Line force acting on frame_a and on frame_b (positive, if acting on frame_b and directed from frame_a to frame_b)";
    SI.Position s 
      "(Guarded) distance between the origin of frame_a and the origin of frame_b (>= s_small))";
    SI.Position e_a[3] 
      "Unit vector on the line connecting the origin of frame_a with the origin of frame_b resolved in frame_a (directed from frame_a to frame_b)";
    Real r_rel_a[3] 
      "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    definePotentialRoot(frame_a.R, 100);
    definePotentialRoot(frame_b.R, 100);
    
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of line force object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of line force object is not connected");
    
    // Determine distance s and n_a 
    r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
    s = noEvent(max(Frames.length(r_rel_a), s_small));
    e_a = r_rel_a/s;
    
    /* Determine forces and torques at frame_a and frame_b */
    frame_a.f = -e_a*f;
    frame_b.f = -Frames.resolve2(Frames.relativeRotation(frame_a.R, frame_b.R),
       frame_a.f);
    
    // Additional equations, if direct connections of line forces
    if isRoot(frame_a.R) then
      frame_a.R = Frames.nullRotation();
    else
      frame_a.t = zeros(3);
    end if;
    
    if isRoot(frame_b.R) then
      frame_b.R = Frames.nullRotation();
    else
      frame_b.t = zeros(3);
    end if;
    
    annotation (Documentation(info="<HTML>
<p>
All <b>line force</b> elements should be based on this base model.
This model defines frame_a and frame_b, computes the relative
distance <b>s</b> and provides the force and torque
balance of the cut-forces and cut-torques at frame_a and
frame_b, respectively. In sub-models, only the line force <b>f</b>,
acting at frame_b on the line from frame_a to frame_b, as a function
of the relative distance <b>s</b> and its derivative <b>der</b>(<b>s</b>)
has to be defined. Example:
</p>
<pre>
   <b>model</b> Spring
      <b>parameter</b> Real c \"spring constant\",
      <b>parameter</b> Real s_unstretched \"unstretched spring length\";
      <b>extends</b> Modelica.Mechanics.MultiBody.Interfaces.PartialLineForce;
   <b>equation</b>
      f = c*(s-s_unstretched);
   <b>end</b> Spring;
</pre>
</HTML>"), Icon(Text(
          extent=[-136, 44; -100, 19],
          style(color=10),
          string="a"), Text(
          extent=[100, 42; 136, 17],
          style(color=10),
          string="b")));
  end PartialLineForce;
  
  partial model PartialAbsoluteSensor 
    "Base class to measure an absolute frame variable" 
    extends Modelica.Icons.RotationalSensor;
    parameter Integer n_out = 1 "Number of output signals";
    Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Modelica.Blocks.Interfaces.RealOutput y[n_out] "Measured data as signals" 
      annotation (extent=[100, -10; 120, 10]);
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.39,
        y=0.05,
        width=0.6,
        height=0.6),
      Documentation(info="
<HTML>
<p>
This is the base class of a 3D mechanics component with one frame and one
output port in order to measure an absolute quantity in the frame connector
and to provide the measured signal as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</HTML>
"),   Icon(
        Line(points=[-70, 0; -100, 0], style(color=0)),
        Line(points=[70, 0; 100, 0]),
        Text(extent=[-132, -125; 131, -79], string="%name")),
      Diagram(Line(points=[-70, 0; -100, 0], style(color=0)), Line(points=[70,
              0; 100, 0])));
  equation 
    
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of absolute sensor object is not connected");
  end PartialAbsoluteSensor;
  
  partial model PartialRelativeSensor 
    "Base class to measure a relative variable between two frames" 
    extends Modelica.Icons.RotationalSensor;
    parameter Integer n_out = 1 "Number of output signals";
    Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    Modelica.Blocks.Interfaces.RealOutput y[n_out] 
      annotation (extent=[-10, -100; 10, -120], rotation=90);
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.37,
        y=0.02,
        width=0.6,
        height=0.65),
      Documentation(info="
<HTML>
<p>
This is a base class for 3D mechanical components with two frames
and one output port in order to measure relative quantities
between the two frames or the cut-forces/torques in the frame and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</HTML>
"),   Icon(
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[0, -100; 0, -70]),
        Text(extent=[-132, 76; 129, 124], string="%name"),
        Text(
          extent=[-136, 44; -100, 19],
          style(color=10),
          string="a"),
        Text(
          extent=[101, 41; 137, 16],
          style(color=10),
          string="b")),
      Diagram(
        Line(points=[-70, 0; -100, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[0, -100; 0, -70])));
  equation 
    
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of relative sensor object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of relative sensor object is not connected");
    
  end PartialRelativeSensor;
  
  partial model PartialCutForceSensor 
    "Base class to measure the cut force and/or torque between two frames" 
    
    extends Modelica.Icons.RotationalSensor;
    Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    Frame_resolve frame_resolve 
      "If connected, the output signals are resolved in this frame" 
      annotation (extent=[95, -110; 64, -90], rotation=-90);
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.37,
        y=0.02,
        width=0.6,
        height=0.65),
      Documentation(info="
<HTML>
<p>
This is a base class for 3D mechanical components with two frames
and one output port in order to measure the cut-force and/or
cut-torque acting between the two frames and
to provide the measured signals as output for further processing
with the blocks of package Modelica.Blocks.
</p>
</HTML>
"),   Icon(
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, -100; -80, 0]),
        Text(extent=[-132, 76; 129, 124], string="%name"),
        Text(
          extent=[-136, 44; -100, 19],
          style(color=10),
          string="a"),
        Text(
          extent=[101, 41; 137, 16],
          style(color=10),
          string="b"),
        Text(
          extent=[-31, -72; 100, -97],
          style(color=8),
          string="resolve"),
        Line(points=[80, 0; 80, -100], style(color=6, thickness=2))),
      Diagram(
        Line(points=[-70, 0; -100, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, -100; -80, 0]),
        Line(points=[80,0; 80,-100],   style(color=6, thickness=2))));
    
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    defineBranch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of cut-force/-torque sensor object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of cut-force/-torque sensor object is not connected");
    
    // frame_a and frame_b are identical
    frame_a.r_0 = frame_b.r_0;
    frame_a.R = frame_b.R;
    
    // force and torque balance
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t;
    
    // deduce cut-force
    if cardinality(frame_resolve) == 1 then
      // frame_resolve is connected
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    else
      // frame_resolve is NOT connected
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    end if;
  end PartialCutForceSensor;
  
  partial model PartialVisualizer 
    "Base model of visualizers (has a frame_a on the left side + outer world + assert to guarantee that the component is connected)" 
    
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
      annotation (extent=[-120, -15; -100, 15]);
  protected 
    outer Modelica.Mechanics.MultiBody.World world;
  equation 
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of visualizer object is not connected");
    annotation (Icon);
  end PartialVisualizer;
  
end Interfaces;

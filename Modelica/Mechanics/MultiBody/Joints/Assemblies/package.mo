within Modelica.Mechanics.MultiBody.Joints;
package Assemblies "Components that aggregate several joints for analytic loop handling"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
The joints in this package are mainly designed to be used
in <strong>kinematic loop</strong> structures. Every component consists of
<strong>3 elementary joints</strong>. These joints are combined in such a
way that the kinematics of the 3 joints between frame_a and
frame_b are computed from the movement of frame_a and frame_b,
i.e., there are <strong>no constraints</strong> between frame_a and frame_b.
This requires to solve a <strong>non-linear system of equations</strong> which
is performed <strong>analytically</strong> (i.e., when a mathematical
solution exists, it is computed efficiently and reliably).
A detailed description how to use these joints is provided in
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>
<p>
The assembly joints in this package are named <strong>JointXYZ</strong> where
<strong>XYZ</strong> are the first letters of the elementary joints used in the
component, in particular:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>P</strong></td><td>Prismatic joint</td></tr>
  <tr><td><strong>R</strong></td><td>Revolute joint</td></tr>
  <tr><td><strong>S</strong></td><td>Spherical joint</td></tr>
  <tr><td><strong>U</strong></td><td>Universal joint</td></tr>
</table>
<p>
For example, JointUSR is an assembly joint consisting
of a universal, a spherical and a revolute joint.
</p>
<p> This package contains the following models:
</p>
<h4>Content</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">JointUPS</a></td>
      <td> Universal - prismatic - spherical joint aggregation<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUPS.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR\">JointUSR</a></td>
      <td> Universal - spherical - revolute joint aggregation<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSR.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP\">JointUSP</a></td>
      <td> Universal - spherical - prismatic joint aggregation<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSP.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSR\">JointSSR</a></td>
      <td> Spherical - spherical - revolute joint aggregation
           with an optional mass point at the rod connecting
           the two spherical joints<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSR.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP\">JointSSP</a></td>
      <td> Spherical - spherical - prismatic joint aggregation
           with an optional mass point at the rod connecting
           the two spherical joints<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSP.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR\">JointRRR</a></td>
      <td> Revolute - revolute - revolute joint aggregation for planar loops<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRR.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRP\">JointRRP</a></td>
      <td> Revolute - revolute - prismatic joint aggregation for planar loops<br>
     <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRP.png\">
      </td>
  </tr>
</table>
<p>
Note, no component of this package has potential states, since the
components are designed in such a way that the generalized coordinates
of the used elementary joints are computed from the frame_a and frame_b
coordinates. Still, it is possible to use the components in a
tree structure. In this case states are selected from bodies that are
connected to the frame_a or frame_b side of the component.
In most cases this gives a less efficient solution, as if elementary
joints of package Modelica.Mechanics.MultiBody.Joints would be used directly.
</p>
<p>
The analytic handling of kinematic loops by using joint aggregations
with 6 degrees of freedom as provided in this package, is a <strong>new</strong>
methodology. It is based on a more general method for solving
non-linear equations of kinematic loops developed by Woernle and
Hiller. An automatic application of this more general method
is difficult, and a manual application is only suited for
specialists in this field. The method introduced here is a
compromise: It can be quite easily applied by an end user, but
for a smaller class of kinematic loops. The method of the \"characteristic
pair of joints\" from Woernle and Hiller is described in:
</p>
<dl>
<dt>Woernle C.:</dt>
<dd><strong>Ein systematisches Verfahren zur Aufstellung der geometrischen
    Schliessbedingungen in kinematischen Schleifen mit Anwendung
    bei der R&uuml;ckw&auml;rtstransformation f&uuml;r
    Industrieroboter.</strong><br>
    Fortschritt-Berichte VDI, Reihe 18, Nr. 59, D&uuml;sseldorf: VDI-Verlag 1988,
    ISBN 3-18-145918-6.<br>&nbsp;</dd>
<dt>Hiller M., and Woernle C.:</dt>
<dd><strong>A Systematic Approach for Solving the Inverse Kinematic
    Problem of Robot Manipulators</strong>.<br>
    Proceedings 7th World Congress Th. Mach. Mech., Sevilla 1987. </dd>
</dl>
</html>"));
end Assemblies;

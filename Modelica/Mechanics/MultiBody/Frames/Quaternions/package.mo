within Modelica.Mechanics.MultiBody.Frames;
package Quaternions "Functions to transform rotational frame quantities based on quaternions (also called Euler parameters)"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
<p>
Package <strong>Frames.Quaternions</strong> contains type definitions and
functions to transform rotational frame quantities with quaternions.
Functions of this package are currently only utilized in
MultiBody.Parts.Body components, when quaternions shall be used
as parts of the body states.
Some functions are also used in a new Modelica package for
B-Spline interpolation that is able to interpolate paths consisting of
position vectors and orientation objects.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<blockquote><pre>
Quaternions.Orientation Q, Q1, Q2, Q_rel, Q_inv;
Real[3,3]   T, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation Q;</strong></td>
      <td>New type defining a quaternion object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_Q;</td>
      <td>New type defining the first time derivative
         of Frames.Quaternions.Orientation.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(Q);</td>
      <td>Return the constraints between the variables of a quaternion object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(Q, der_Q);</td>
      <td>Return angular velocity resolved in frame 1 from
          quaternion object Q<br> and its derivative der_Q.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(Q, der_Q);</td>
      <td>Return angular velocity resolved in frame 2 from
          quaternion object Q<br> and its derivative der_Q.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(Q,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(Q,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(Q, [v2,w2]);</td>
      <td>Transform several vectors from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(Q, [v1,w1]);</td>
      <td>Transform several vectors from frame 1 to frame 2.
      </td>
  </tr>
  <tr><td>Q = <strong>nullRotation</strong>()</td>
      <td>Return quaternion object R that does not rotate a frame.
      </td>
  </tr>
  <tr><td>Q_inv = <strong>inverseRotation</strong>(Q);</td>
      <td>Return inverse quaternion object.
      </td>
  </tr>
  <tr><td>Q_rel = <strong>relativeRotation</strong>(Q1,Q2);</td>
      <td>Return relative quaternion object from two absolute
          quaternion objects.
      </td>
  </tr>
  <tr><td>Q2 = <strong>absoluteRotation</strong>(Q1,Q_rel);</td>
      <td>Return absolute quaternion object from another
          absolute<br> and a relative quaternion object.
      </td>
  </tr>
  <tr><td>Q = <strong>planarRotation</strong>(e, angle);</td>
      <td>Return quaternion object of a planar rotation.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(Q);</td>
      <td>Return rotation angles phi valid for a small rotation.
      </td>
  </tr>
  <tr><td>Q = <strong>from_T</strong>(T);</td>
      <td>Return quaternion object Q from transformation matrix T.
      </td>
  </tr>
  <tr><td>Q = <strong>from_T_inv</strong>(T_inv);</td>
      <td>Return quaternion object Q from inverse transformation matrix T_inv.
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(Q);</td>
      <td>Return transformation matrix T from quaternion object Q.
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(Q);</td>
      <td>Return inverse transformation matrix T_inv from quaternion object Q.
      </td>
  </tr>
</table>
</html>"));
end Quaternions;

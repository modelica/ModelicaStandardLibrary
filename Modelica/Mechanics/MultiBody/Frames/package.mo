within Modelica.Mechanics.MultiBody;
package Frames "Functions to transform rotational frame quantities"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
Package <strong>Frames</strong> contains type definitions and
functions to transform rotational frame quantities. The basic idea is to
hide the actual definition of an <strong>orientation</strong> in this package
by providing essentially type <strong>Orientation</strong> together with
<strong>functions</strong> operating on instances of this type.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<blockquote><pre>
Frames.Orientation R, R1, R2, R_rel, R_inv;
Real[3,3]   T, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation R;</strong></td>
      <td>New type defining an orientation object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(R);</td>
      <td>Return the constraints between the variables of an orientation object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(R);</td>
      <td>Return angular velocity resolved in frame 1 from
          orientation object R.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(R);</td>
      <td>Return angular velocity resolved in frame 2 from
          orientation object R.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(R,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(R,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>v2 = <strong>resolveRelative</strong>(v1,R1,R2);</td>
      <td>Transform vector v1 from frame 1 to frame 2
          using absolute orientation objects R1 of frame 1 and R2 of frame 2.
      </td>
  </tr>
  <tr><td>D1 = <strong>resolveDyade1</strong>(R,D2);</td>
      <td>Transform second order tensor D2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(R,D1);</td>
      <td>Transform second order tensor D1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>R = <strong>nullRotation</strong>()</td>
      <td>Return orientation object R that does not rotate a frame.
     </td>
  </tr>
  <tr><td>R_inv = <strong>inverseRotation</strong>(R);</td>
      <td>Return inverse orientation object.
      </td>
  </tr>
  <tr><td>R_rel = <strong>relativeRotation</strong>(R1,R2);</td>
      <td>Return relative orientation object from two absolute
          orientation objects.
      </td>
  </tr>
  <tr><td>R2 = <strong>absoluteRotation</strong>(R1,R_rel);</td>
      <td>Return absolute orientation object from another
          absolute<br> and a relative orientation object.
      </td>
  </tr>
  <tr><td>R = <strong>planarRotation</strong>(e, angle, der_angle);</td>
      <td>Return orientation object of a planar rotation.
      </td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>Return angle of a planar rotation, given the rotation axis<br>
        and the representations of a vector in frame 1 and frame 2.
      </td>
  </tr>
  <tr><td>R = <strong>axisRotation</strong>(axis, angle, der_angle);</td>
      <td>Return orientation object R to rotate around angle along axis of frame 1.
      </td>
  </tr>
  <tr><td>R = <strong>axesRotations</strong>(sequence, angles, der_angles);</td>
      <td>Return rotation object to rotate in sequence around 3 axes. Example:<br>
          R = axesRotations({1,2,3},{pi/2,pi/4,-pi}, zeros(3));
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(R, sequence);</td>
      <td>Return the 3 angles to rotate in sequence around 3 axes to<br>
          construct the given orientation object.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(R);</td>
      <td>Return rotation angles phi valid for a small rotation R.
      </td>
  </tr>
  <tr><td>R = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>Return orientation object from n_x and n_y vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>Return orientation object from n_x and n_z vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T,w);</td>
      <td>Return orientation object R from transformation matrix T and
          its angular velocity w.
      </td>
  </tr>
  <tr><td>R = <strong>from_T2</strong>(T,der(T));</td>
      <td>Return orientation object R from transformation matrix T and
          its derivative der(T).
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv,w);</td>
      <td>Return orientation object R from inverse transformation matrix T_inv and
          its angular velocity w.
      </td>
  </tr>
  <tr><td>R = <strong>from_Q</strong>(Q,w);</td>
      <td>Return orientation object R from quaternion orientation object Q
          and its angular velocity w.
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(R);</td>
      <td>Return transformation matrix T from orientation object R.
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(R);</td>
      <td>Return inverse transformation matrix T_inv from orientation object R.
      </td>
  </tr>
  <tr><td>Q = <strong>to_Q</strong>(R);</td>
      <td>Return quaternion orientation object Q from orientation object R.
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(R);</td>
      <td>Return [e_x, e_y] matrix of an orientation object R,<br>
          with e_x and e_y vectors of frame 2, resolved in frame 1.
      </td>
  </tr>
  <tr><td>L = <strong>length</strong>(n_x);</td>
      <td>Return length L of a vector n_x.
      </td>
  </tr>
  <tr><td>e_x = <strong>normalize</strong>(n_x);</td>
      <td>Return normalized vector e_x of n_x such that length of e_x is one.
      </td>
  </tr>
  <tr><td>e = <strong>axis</strong>(i);</td>
      <td>Return unit vector e directed along axis i
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions\">Quaternions</a></td>
      <td><strong>Package</strong> with functions to transform rotational frame quantities based
          on quaternions (also called Euler parameters).
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a></td>
      <td><strong>Package</strong> with functions to transform rotational frame quantities based
          on transformation matrices.
      </td>
  </tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-2,-18},{80,-60}}, color={95,95,95}),
        Line(points={{-2,-18},{-2,80}}, color={95,95,95}),
        Line(points={{-78,-56},{-2,-18}}, color={95,95,95})}));
end Frames;

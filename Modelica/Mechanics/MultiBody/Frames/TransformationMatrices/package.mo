within Modelica.Mechanics.MultiBody.Frames;
package TransformationMatrices "Functions for transformation matrices"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
<p>
Package <strong>Frames.TransformationMatrices</strong> contains type definitions and
functions to transform rotational frame quantities using
transformation matrices.
</p>
<h4>Content</h4>
<p>In the table below an example is given for every function definition.
The used variables have the following declaration:
</p>
<blockquote><pre>
Orientation T, T1, T2, T_rel, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><strong>Orientation T;</strong></td>
      <td>New type defining an orientation object that describes<br>
          the rotation of frame 1 into frame 2.
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_T;</td>
      <td>New type defining the first time derivative
         of Frames.Orientation.
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(T);</td>
      <td>Return the constraints between the variables of an orientation object<br>
      (shall be zero).</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(T, der_T);</td>
      <td>Return angular velocity resolved in frame 1 from
          orientation object T<br> and its derivative der_T.
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(T, der_T);</td>
      <td>Return angular velocity resolved in frame 2 from
          orientation object T<br> and its derivative der_T.
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(T,v2);</td>
      <td>Transform vector v2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(T,v1);</td>
      <td>Transform vector v1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(T, [v2,w2]);</td>
      <td>Transform several vectors from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(T, [v1,w1]);</td>
      <td>Transform several vectors from frame 1 to frame 2.
      </td>
  </tr>
  <tr><td>D1 = <strong>resolveDyade1</strong>(T,D2);</td>
      <td>Transform second order tensor D2 from frame 2 to frame 1.
      </td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(T,D1);</td>
      <td>Transform second order tensor D1 from frame 1 to frame 2.
     </td>
  </tr>
  <tr><td>T= <strong>nullRotation</strong>()</td>
      <td>Return orientation object T that does not rotate a frame.
     </td>
  </tr>
  <tr><td>T_inv = <strong>inverseRotation</strong>(T);</td>
      <td>Return inverse orientation object.
      </td>
  </tr>
  <tr><td>T_rel = <strong>relativeRotation</strong>(T1,T2);</td>
      <td>Return relative orientation object from two absolute
          orientation objects.
      </td>
  </tr>
  <tr><td>T2 = <strong>absoluteRotation</strong>(T1,T_rel);</td>
      <td>Return absolute orientation object from another
          absolute<br> and a relative orientation object.
      </td>
  </tr>
  <tr><td>T = <strong>planarRotation</strong>(e, angle);</td>
      <td>Return orientation object of a planar rotation.
      </td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>Return angle of a planar rotation, given the rotation axis<br>
        and the representations of a vector in frame 1 and frame 2.
      </td>
  </tr>
  <tr><td>T = <strong>axisRotation</strong>(i, angle);</td>
      <td>Return orientation object T for rotation around axis i of frame 1.
      </td>
  </tr>
  <tr><td>T = <strong>axesRotations</strong>(sequence, angles);</td>
      <td>Return rotation object to rotate in sequence around 3 axes. Example:<br>
          T = axesRotations({1,2,3},{90,45,-90});
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(T, sequence);</td>
      <td>Return the 3 angles to rotate in sequence around 3 axes to<br>
          construct the given orientation object.
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(T);</td>
      <td>Return rotation angles phi valid for a small rotation.
      </td>
  </tr>
  <tr><td>T = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>Return orientation object from n_x and n_y vectors.
      </td>
  </tr>
  <tr><td>T = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>Return orientation object from n_x and n_z vectors.
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T);</td>
      <td>Return orientation object R from transformation matrix T.
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv);</td>
      <td>Return orientation object R from inverse transformation matrix T_inv.
      </td>
  </tr>
  <tr><td>T = <strong>from_Q</strong>(Q);</td>
      <td>Return orientation object T from quaternion orientation object Q.
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
  <tr><td>Q = <strong>to_Q</strong>(T);</td>
      <td>Return quaternion orientation object Q from orientation object T.
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(T);</td>
      <td>Return [e_x, e_y] matrix of an orientation object T,<br>
          with e_x and e_y vectors of frame 2, resolved in frame 1.
      </td>
  </tr>
</table>
</html>"));
end TransformationMatrices;

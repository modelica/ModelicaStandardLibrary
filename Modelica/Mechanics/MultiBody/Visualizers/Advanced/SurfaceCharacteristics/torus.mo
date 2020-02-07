within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function torus "Function defining the surface characteristic of a torus"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=false);
  input SI.Length R=1 "Major radius (distance from center of torus to center of tube)" annotation(Dialog);
  input SI.Length r=0.2 "Minor radius (radius of tube)" annotation(Dialog);
  input SI.Angle opening=0 "Opening angle of torus" annotation(Dialog);
  input SI.Angle startAngle= -Modelica.Constants.pi
    "Start angle of torus slice" annotation(Dialog);
  input SI.Angle stopAngle= Modelica.Constants.pi
    "End angle of torus slice" annotation(Dialog);
protected
  SI.Angle alpha;
  SI.Angle beta;
  SI.Angle phi_start;
  SI.Angle phi_stop;
algorithm
  phi_start :=-Modelica.Constants.pi + opening;
  phi_stop  :=Modelica.Constants.pi - opening;
  for i in 1:nu loop
    alpha := startAngle + (stopAngle-startAngle)*(i-1)/(nu-1);
    for j in 1:nv loop
      beta := phi_start + (phi_stop-phi_start)*(j-1)/(nv-1);
      X[i,j] := (R + r*Modelica.Math.cos(beta))*Modelica.Math.sin(alpha);
      Y[i,j] := r*Modelica.Math.sin(beta);
      Z[i,j] := (R + r*Modelica.Math.cos(beta))*Modelica.Math.cos(alpha);
    end for;
  end for;

  annotation (Documentation(info="<html>
<p>
Function <strong>torus</strong> computes the X, Y and Z arrays to visualize a torus
with model <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>.
The left image below shows a torus with <var>R</var>&nbsp;=&nbsp;0.5&nbsp;m and
<var>r</var>&nbsp;=&nbsp;0.2&nbsp;m.
The right images below shows the torus with the additional parameter
settings:
</p>
<blockquote><pre>
opening    =   45 degree
startAngle = -135 degree
stopAngle  =  135 degree
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Torus.png\">
</blockquote>
</html>"));
end torus;

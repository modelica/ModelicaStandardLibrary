within ;
package ModelicaServices
  "Models and functions used in the Modelica Standard Library requiring a tool specific implementation"

package Animation "Models and functions for 3-dim. animation"

model Shape
      "Different visual shapes with variable size; all data have to be set as modifiers (see info layer)"
  extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

      import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types;

    protected
  Real abs_n_x(final unit="1")=Modelica.Math.Vectors.length(
                             lengthDirection) annotation (HideResult=true);
  Real e_x[3](each final unit="1")=noEvent(if abs_n_x < 1.e-10 then {1,0,0} else lengthDirection
      /abs_n_x) annotation (HideResult=true);
  Real n_z_aux[3](each final unit="1")=cross(e_x, widthDirection) annotation (HideResult=true);
  Real e_y[3](each final unit="1")=noEvent(cross(Modelica.Math.Vectors.normalize(
                                             cross(e_x, if n_z_aux*n_z_aux
       > 1.0e-6 then widthDirection else (if abs(e_x[1]) > 1.0e-6 then {0,1,
      0} else {1,0,0}))), e_x)) annotation (HideResult=true);
  output Real Form annotation (HideResult=false);
    public
  output Real rxvisobj[3](each final unit="1")
        "x-axis unit vector of shape, resolved in world frame" 
    annotation (HideResult=false);
  output Real ryvisobj[3](each final unit="1")
        "y-axis unit vector of shape, resolved in world frame" 
    annotation (HideResult=false);
  output SI.Position rvisobj[3]
        "position vector from world frame to shape frame, resolved in world frame"
    annotation (HideResult=false);

    protected
  output SI.Length size[3] "{length,width,height} of shape" 
    annotation (HideResult=false);
  output Real Material annotation (HideResult=false);
  output Real Extra annotation (HideResult=false);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
            Rectangle(
              extent={{-100,-100},{80,60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,60},{-80,100},{100,100},{80,60},{-100,60}},
              lineColor={0,0,255},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{100,100},{100,-60},{80,-100},{80,60},{100,100}},
              lineColor={0,0,255},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,-100},{80,60}},
              lineColor={0,0,0},
              textString="%shapeType"),
            Text(
              extent={{-132,160},{128,100}},
              textString="%name",
              lineColor={0,0,255})}),
    Documentation(info="<html>

<p>
This model is documented at
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>.
</p>


</html>
"));
equation
  /* Outputs to file. */
  Form = (987000 + PackShape(shapeType))*1E20;
  /*
  rxry = Frames.TransformationMatrices.to_exy(
    Frames.TransformationMatrices.absoluteRotation(R.T, 
    Frames.TransformationMatrices.from_nxy(lengthDirection, widthDirection)));
  rxvisobj = rxry[:, 1];
  ryvisobj = rxry[:, 2];
*/
  rxvisobj = transpose(R.T)*e_x;
  ryvisobj = transpose(R.T)*e_y;
  rvisobj = r + T.resolve1(R.T, r_shape);
  size = {length,width,height};
  Material = PackMaterial(color[1]/255.0, color[2]/255.0, color[3]/255.0,
    specularCoefficient);
  Extra = extra;
end Shape;
end Animation;

  annotation (preferredView="info",uses(Modelica(version="3.1")), Documentation(info="<html>
 
<p>
This package contains a set of models and functions to be used in the
Modelica Standard Library that requires a tool specific implementation.
These are:
</p>
 
<ul>
<li> <a href=\"Modelica://ModelicaServices.Animation.Shape\">ModelicaServices.Animation.Shape</a>.
     provides a 3-dim. visualization of 
     mechanical objects. It is used in
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
     via inheritance.</li>
</ul>
 
 
 
</html>"));
end ModelicaServices;


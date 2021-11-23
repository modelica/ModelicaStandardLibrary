within Modelica.Magnetic.FluxTubes.Shapes;
package Force "Flux tubes with reluctance force generation; constant permeability"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>
<p>
Flux tube elements with generation of a reluctance force are intended for modelling of position-dependent air gap sections and permanent magnet sections respectively of translatory actuators. By default, the position coordinate of the mechanical connector flange.s is identical with the dimension l of the package's flux tube elements. l is the dimension changes with armature motion. If needed, the identity l=flange.s can be replaced by an actuator-specific equation, for example, when a flux tube length increases with decreasing armature position. The position coordinate of an element's translatory connector flange.s in turn will be identical with the armature position x in most cases, as the examples illustrate.</p>
<p>
The derivative of each element's permeance with respect to armature position <code>dGmBydx</code> is calculated from the derivative of the flux tube's permeance with respect to its varying dimension dGmBydl and the derivative of this dimension with respect to armature position <code>dlBydx</code>:</p>

<blockquote><pre>
dG_m   dG_m   dl
---- = ---- * --
 dx     dl    dx
</pre></blockquote>

<p>
The parameter <code>dlBydx</code> must be set in each flux tube element to +1 or -1 according to the definition of the armature coordinate and the position of the element in a device's magnetic circuit. Proper match between armature motion and resulting variation of the flux tube length assures that the element's reluctance force acts in the right direction.
</p>
<p>
The shapes of the flux tubes defined in this package are rather simple. Only one dimension varies with armature motion. Flux tubes with more complex variations of dimensions with armature motion can be defined by extending the base class <a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.Force\">BaseClasses.Force</a>, if needed. Determination of the analytic derivative dGmBydl could become more complex for those flux tubes.
</p>
</html>"));
end Force;

within Modelica.UsersGuide;
class Overview "Overview of Modelica Library"
  extends Modelica.Icons.Information;

 annotation (Documentation(info="<html>
<p>
The Modelica Standard Library consists of the following
main sub-libraries:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Library Components</th> <th>Description</th></tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Electrical.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Analog\">Analog</a><br>
 Analog electric and electronic components, such as
 resistor, capacitor, transformers, diodes, transistors,
 transmission lines, switches, sources, sensors.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Digital.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Digital\">Digital</a><br>
 Digital electrical components based on the VHDL standard,
 like basic logic blocks with 9-value logic, delays, gates,
 sources, converters between 2-, 3-, 4-, and 9-valued logic.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Machines.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a><br>
            Electrical asynchronous-, synchronous-, and DC-machines
 (motors and generators) as well as three-phase transformers.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-FluxTubes.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a><br>
Based on magnetic flux tubes concepts. Especially to model electromagnetic actuators. Nonlinear shape, force, leakage, and material models. Material data for steel, electric sheet, pure iron, Cobalt iron, Nickel iron, NdFeB, Sm2Co17, and more.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Translational.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.Translational\">Translational</a><br>
 1-dim. mechanical, translational systems, e.g.,
 sliding mass, mass with stops, spring, damper.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Rotational.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.Rotational\">Rotational</a><br>
 1-dim. mechanical, rotational systems, e.g., inertias, gears,
 planetary gears, convenient definition of speed/torque dependent friction
 (clutches, brakes, bearings, ..)
 </td>
</tr>

<tr><td width=\"100\">
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-MultiBody1.png\"><br>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-MultiBody2.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.MultiBody\">MultiBody</a>
 3-dim. mechanical systems consisting of joints, bodies, force and
 sensor elements. Joints can be driven by drive trains defined by
 1-dim. mechanical system library (Rotational).
 Every component has a default animation.
 Components can be arbitrarily connected together.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Fluid.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Fluid\">Fluid</a><br>
        1-dim. thermo-fluid flow in networks of vessels, pipes,
        fluid machines, valves and fittings. All media from the
        Modelica.Media library can be used (so incompressible or compressible,
        single or multiple substance, one or two phase medium).
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Media.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Media\">Media</a><br>
 Large media library providing models and functions
 to compute media properties, such as h = h(p,T), d = d(p,T),
 for the following media:
 <ul>
 <li> 1240 gases and mixtures between these gases.</li>
 <li> incompressible, table based liquids (h = h(T), etc.).</li>
 <li> compressible liquids</li>
 <li> dry and moist air</li>
 <li> high precision model for water (IF97).</li>
 </ul>
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Thermal.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow\">FluidHeatFlow</a>,
 <a href=\"modelica://Modelica.Thermal.HeatTransfer\">HeatTransfer</a>
 Simple thermo-fluid pipe flow, especially to model cooling of machines
 with air or water (pipes, pumps, valves, ambient, sensors, sources) and
 lumped heat transfer with heat capacitors, thermal conductors, convection,
 body radiation, sources and sensors.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Blocks1.png\"><br>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Blocks2.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Blocks\">Blocks</a><br>
 Input/output blocks to model block diagrams and logical networks, e.g.,
 integrator, PI, PID, transfer function, linear state space system,
 sampler, unit delay, discrete transfer function, and/or blocks,
 timer, hysteresis, nonlinear and routing blocks, sources, tables.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Clocked.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Clocked\">Clocked</a><br>
 Blocks to precisely define and synchronize sampled data systems with different
 sampling rates. Continuous-time equations can be automatically discretized and
 utilized in a sampled data system. The library is based on the clocked
 synchronous language elements introduced in Modelica 3.3.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-StateGraph.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.StateGraph\">StateGraph</a><br>
 Hierarchical state machines with a similar modeling power as Statecharts.
 Modelica is used as synchronous action language, i.e., deterministic
 behavior is guaranteed
 </td>
</tr>

<tr><td>
 <blockquote><pre>
A = [1,2,3;
     3,4,5;
     2,1,4];
b = {10,22,12};
x = Matrices.solve(A,b);
Matrices.eigenValues(A);
 </pre></blockquote>
 </td>
 <td>
 <a href=\"modelica://Modelica.Math\">Math</a>,
 <a href=\"modelica://Modelica.Utilities\">Utilities</a><br>
 Functions operating on vectors and matrices, such as for solving
 linear systems, eigen and singular values etc.,  and
 functions operating on strings, streams, files, e.g.,
 to copy and remove a file or sort a vector of strings.
 </td>
</tr>

</table>

</html>"));
end Overview;

within Modelica.UsersGuide;
class Contact "Contact"
  extends Modelica.Icons.Contact;

 annotation (Documentation(info="<html>
<dl><dt>The Modelica Standard Library (this Modelica package) is developed by contributors from different organizations (see list below). It is licensed under the <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">BSD 3-Clause License</a> by:</dt>
<dt><br /></dt>
<dd>Modelica Association</dd>
<dd>(Ideella F&ouml;reningar 822003-8858 in Link&ouml;ping)</dd>
<dd>c/o PELAB, IDA, Link&ouml;pings Universitet</dd>
<dd>S-58183 Link&ouml;ping</dd>
<dd>Sweden</dd>
<dd>email: <a href=\"mailto:Board@Modelica.org\">Board@Modelica.org</a></dd>
<dd>web: <a href=\"https://www.Modelica.org\">https://www.Modelica.org</a></dd>
<dd><br /></dd>

<dt>The development of this Modelica package, starting with version 3.2.3, is organized by:</dt>
<dd><a href=\"https://github.com/beutlich\">Thomas Beutlich</a> and <a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></dd>
<dd><br /></dd>

<dt>The development of this Modelica package of version 3.2.2 was organized by:</dt>
<dd><a href=\"https://www.haumer.at/eindex.htm\">Anton Haumer</a></dd>
<dd>Technical Consulting &amp; Electrical Engineering</dd>
<dd>D-93049 Regensburg</dd>
<dd>Germany</dd>
<dd>email: <a href=\"mailto:A.Haumer@Haumer.at\">A.Haumer@Haumer.at</a></dd>
<dd><br /></dd>

<dt>The development of this Modelica package up to and including version 3.2.1 was organized by:</dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dd>
<dd>Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)</dd>
<dd>Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)</dd>
<dd>M&uuml;nchener Straße 20</dd>
<dd>D-82234 We&szlig;ling</dd>
<dd>Germany</dd>
<dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>
<p>Since end of 2007, the development of the sublibraries of package Modelica is organized by personal and/or organizational <strong>library officers</strong> assigned by the Modelica Association. They are responsible for the maintenance and for the further organization of the development. Other persons may also contribute, but the final decision for library improvements and/or changes is performed by the responsible library officer(s). In order that a new sublibrary or a new version of a sublibrary is ready to be released, the responsible library officers report the changes to the members of the Modelica Association and the library is made available for beta testing to interested parties before a final decision. A new release of a sublibrary is formally decided by voting of the Modelica Association members.</p>
<p>As of March 7th, 2020, the following library officers are assigned:</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>Sublibraries</strong> </td>
   <td><strong>Library officers</strong></td>
</tr>

<tr>
<td align=\"left\">UsersGuide</td>
<td align=\"left\">Christian Kral, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Blocks</td>
<td align=\"left\">Martin Otter, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">Clocked</td>
<td align=\"left\">Christoff B&uuml;rger, Bernhard Thiele</td>
</tr>
<tr>
<td align=\"left\">ComplexBlocks</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Blocks.Tables</td>
<td align=\"left\">Thomas Beutlich, Martin Otter, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">StateGraph</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Electrical.Analog</td>
<td align=\"left\">Christoph Clauss, Anton Haumer, Christian Kral, Kristin Majetta</td>
</tr>
<tr>
<td align=\"left\">Electrical.Batteries</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Digital</td>
<td align=\"left\">Christoph Clauss, Kristin Majetta</td>
</tr>
<tr>
<td align=\"left\">Electrical.Machines</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Polyphase</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.PowerConverters</td>
<td align=\"left\">Christian Kral, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">Electrical.QuasiStatic</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Spice3</td>
<td align=\"left\">Christoph Clauss, Kristin Majetta, Joe Riel</td>
</tr>
<tr>
<td align=\"left\">Magnetic.FluxTubes</td>
<td align=\"left\">Thomas B&ouml;drich, Anton Haumer, Christian Kral, Johannes Ziske</td>
</tr>
<tr>
<td align=\"left\">Magnetic.FundamentalWave</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Magnetic.QuasiStatic</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Mechanics.MultiBody</td>
<td align=\"left\">Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Mechanics.Rotational</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Mechanics.Translational</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Fluid</td>
<td align=\"left\">Francesco Casella, R&uuml;diger Franke, Hubertus Tummescheit</td>
</tr>
<tr>
<td align=\"left\">Fluid.Dissipation</td>
<td align=\"left\">Francesco Casella, Stefan Wischhusen</td>
</tr>
<tr>
<td align=\"left\">Media</td>
<td align=\"left\">Francesco Casella, R&uuml;diger Franke, Hubertus Tummescheit</td>
</tr>
<tr>
<td align=\"left\">Thermal.FluidHeatFlow</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Thermal.HeatTransfer</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Math</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">ComplexMath</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Utilities</td>
<td align=\"left\">Dag Br&uuml;ck, Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Constants</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Icons</td>
<td align=\"left\">Christian Kral, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Units</td>
<td align=\"left\">Christian Kral, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">C-Sources</td>
<td align=\"left\">Thomas Beutlich, Hans Olsson, Martin Sj&ouml;lund</td>
</tr>
<tr>
<td align=\"left\">Reference</td>
<td align=\"left\">Hans Olsson, Dietmar Winkler</td>
</tr>
<tr>
<td align=\"left\">Services</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Complex</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Test</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">TestOverdetermined</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">TestConversion4</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">ObsoleteModelica4</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
</table>

<p>
The following people have directly contributed to the implementation
of the Modelica package (many more people have contributed to the design):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>Marcus Baur</strong></td>
   <td>previously at:<br>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Complex<br>
                      Modelica.Math.Vectors<br>
                      Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Peter Beater</strong></td>
   <td>University of Paderborn, Germany</td>
   <td>Modelica.Mechanics.Translational</td>
</tr>

<tr><td><strong>Thomas Beutlich</strong></td>
   <td>previously at:<br>ESI ITI GmbH, Germany</td>
   <td>Modelica.Blocks.Sources.CombiTimeTable<br>
                      Modelica.Blocks.Tables</td>
</tr>

<tr><td><strong>Thomas B&ouml;drich</strong></td>
   <td>Dresden University of Technology, Germany</td>
   <td>Modelica.Magnetic.FluxTubes</td>
</tr>

<tr><td><strong>Dag Br&uuml;ck</strong></td>
   <td>Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Utilities</td>
</tr>

<tr><td><strong>Francesco Casella</strong></td>
   <td>Politecnico di Milano, Milano, Italy</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Christoph Clauss</strong></td>
   <td>until 2016:<br>
     Fraunhofer Institute for Integrated Circuits,<br>
     Dresden, Germany</td>
   <td>Modelica.Electrical.Analog<br>
                      Modelica.Electrical.Digital<br>
                      Modelica.Electrical.Spice3</td>
</tr>

<tr><td><strong>Jonas Eborn</strong></td>
   <td>Modelon AB, Lund, Sweden</td>
   <td>Modelica.Media</td>
</tr>

<tr><td><strong>Hilding Elmqvist</strong></td>
   <td>Mogram AB, Lund, Sweden<br>
     until 2015:<br>
     Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Mechanics.MultiBody<br>
                      Modelica.Fluid<br>
                      Modelica.Media<br>
                      Modelica.StateGraph<br>
                      Modelica.Utilities<br>
                      Conversion from 1.6 to 2.0</td>
</tr>

<tr><td><strong>R&uuml;diger Franke</strong></td>
   <td>ABB Corporate Research,<br>Ladenburg, Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Manuel Gr&auml;ber</strong></td>
   <td>Institut f&uuml;r Thermodynamik,<br>
     Technische Universit&auml;t Braunschweig, Germany</td>
   <td>Modelica.Fluid</td>
</tr>

<tr><td><strong>Anton Haumer</strong></td>
   <td>Consultant, Regensburg,<br>Germany</td>
   <td>Modelica.ComplexBlocks<br>
                      Modelica.Electrical.Machines<br>
                      Modelica.Electrical.Polyphase<br>
                      Modelica.Electrical.QuasiStatic<br>
                      Modelica.Magnetics.FundamentalWave<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Thermal.FluidHeatFlow<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.ComplexMath<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Hans-Dieter Joos</strong></td>
   <td>previously at:<br>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Christian Kral</strong></td>
   <td>Modeling and Simulation of Electric Machines, Drives and Mechatronic Systems,<br>
     Vienna, Austria</td>
   <td>Modelica.ComplexBlocks<br>
                      Modelica.Electrical.Machines<br>
                      Modelica.Electrical.Polyphase<br>
                      Modelica.Electrical.QuasiStatic<br>
                      Modelica.Magnetics.FundamentalWave<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Thermal.FluidHeatFlow<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.ComplexMath
  </td>
</tr>

<tr><td><strong>Sven Erik Mattsson</strong></td>
   <td>until 2015:<br>
     Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Mechanics.MultiBody</td>
</tr>

<tr><td><strong>Hans Olsson</strong></td>
   <td>Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Blocks<br>
                      Modelica.Math.Matrices<br>
                      Modelica.Utilities<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Martin Otter</strong></td>
   <td>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Complex<br>
                      Modelica.Blocks<br>
                      Modelica.Fluid<br>
                      Modelica.Mechanics.MultiBody<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Math<br>
                      Modelica.ComplexMath<br>
                      Modelica.Media<br>
                      Modelica.SIunits<br>
                      Modelica.StateGraph<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.Utilities<br>
                      ModelicaReference<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Katrin Pr&ouml;l&szlig;</strong></td>
   <td>previously at:<br>Modelon Deutschland GmbH, Hamburg, Germany<br>
     until 2008:<br>
     Department of Technical Thermodynamics,<br>
     Technical University Hamburg-Harburg,<br>Germany</td>
   <td>Modelica.Fluid<br>
                            Modelica.Media</td>
</tr>

<tr><td><strong>Christoph C. Richter</strong></td>
   <td>until 2009:<br>
     Institut f&uuml;r Thermodynamik,<br>
     Technische Universit&auml;t Braunschweig,<br>
     Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Andr&eacute; Schneider</strong></td>
   <td>Fraunhofer Institute for Integrated Circuits,<br>Dresden, Germany</td>
   <td>Modelica.Electrical.Analog<br>
     Modelica.Electrical.Digital</td>
</tr>
<tr><td><strong>Christian Schweiger</strong></td>
   <td>until 2006:<br>
     Institute of System Dynamics and Control,<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Mechanics.Rotational<br>
                      ModelicaReference<br>
                      Conversion from 1.6 to 2.0</td>
</tr>

<tr><td><strong>Michael Sielemann</strong></td>
   <td>Modelon Deutschland GmbH, Munich, Germany<br>
     previously at:<br>
     Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Michael Tiller</strong></td>
   <td>Xogeny Inc., Canton, MI, U.S.A.<br>
     previously at:<br>
     Emmeskay, Inc., Dearborn, MI, U.S.A.<br>
     previously at:<br>
     Ford Motor Company, Dearborn, MI, U.S.A.</td>
   <td>Modelica.Media<br>
                      Modelica.Thermal.HeatTransfer</td>
</tr>

<tr><td><strong>Hubertus Tummescheit</strong></td>
   <td>Modelon, Inc., Hartford, CT, U.S.A.</td>
   <td>Modelica.Media<br>
                      Modelica.Thermal.HeatTransfer</td>
</tr>

<tr><td><strong>Thorsten Vahlenkamp</strong></td>
   <td>until 2010:<br>
                     XRG Simulation GmbH, Hamburg, Germany</td>
   <td>Modelica.Fluid.Dissipation</td>
</tr>

<tr><td><strong>Nico Walter</strong></td>
   <td>Master thesis at HTWK Leipzig<br>
     (Prof. R. M&uuml;ller) and<br>
     DLR Oberpfaffenhofen, Germany</td>
   <td>Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Michael Wetter</strong></td>
   <td>Lawrence Berkeley National Laboratory, Berkeley, CA, U.S.A.</td>
   <td>Modelica.Fluid</td>
</tr>

<tr><td><strong>Hans-J&uuml;rg Wiesmann</strong></td>
   <td>Switzerland</td>
   <td>Modelica.ComplexMath</td>
</tr>

<tr><td><strong>Stefan Wischhusen</strong></td>
   <td>XRG Simulation GmbH, Hamburg, Germany</td>
   <td>Modelica.Fluid.Dissipation<br>
                      Modelica.Media</td>
</tr>
</table>

</html>"));

end Contact;

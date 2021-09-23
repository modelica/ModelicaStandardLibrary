within Modelica.Magnetic.FluxTubes.UsersGuide;
package Hysteresis "Hysteresis"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<h4>Introduction</h4>

<p>
The elements provided in the package Shapes.HysteresisAndMagnets allow for consideration of ferromagnetic and dynamic hysteresis during the simulation of electromagnetic networks. The ferromagnetic hysteresis is a material property of the core material and frequency independent. Due to eddy currents the static ferromagnetic hysteresis is superposed by a frequency dependent hysteresis when the ferromagnetic material is exposed to an alternating magnetic field. Fig 1 exemplary shows the simulated hysteresis characteristics of a simple inductor with an iron core for three different excitation frequencies. Thereby, the 0 Hz hysteresis loop represents the static ferromagnetic hysteresis of the core material. The widening of the loops for higher frequencies is due to eddy currents induced in the core material.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption><strong>Fig. 1:</strong> Inductor with ferromagnetic core and hysteresis effects; (a) diagram of the network model; (b) simulated hysteresis characteristics of the core for different excitation frequencies of 0, 10 and 100 Hz (the example model can be found at: <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.InductorWithHysteresis\">Examples.Hysteresis.InductorWithHysteresis</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/InductorWithHysteresis_DiagramAndSim.png\">
   </td>
  </tr>
</table>

<p>
Several models to describe the static hysteresis behavior of ferromagnetic materials are known. In this library two of them are implemented. The simple but fast <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a> and the more accurate but complex <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. Click the links for a short description of both models.
</p>

<h4>Flux tube elements of the Package HysteresisAndMagnets</h4>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
 <tr>
  <th>Name / Icon</th><th>Description</th>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenSoft\">GenericHystTellinenSoft</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenS.png\">
  </td>
  <td>
  Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters. Therefore, the hysteresis shape variety is limited but the parameterization of the model is very simple and the model is relatively fast and robust.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenH.png\">
  </td>
  <td>
  Flux tube element for modeling the ferromagnetic (static) hysteresis of hard magnetic materials. The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenE.png\">
  </td>
  <td>
  Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function, which is also used to parameterize the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a> model. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenT.png\">
  </td>
  <td>
  Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The rising and falling branch of the limiting ferromagnetic hysteresis loop are specified by table data. Therefore, almost any hysteresis shapes are possible. A library with predefined tables can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystPreisachE.png\">
  </td>
  <td>
  Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenPermanentMagnet\">GenericHystTellinenPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenPM.png\">
  </td>
  <td>
  Flux tube element for modeling the hard magnetic hysteresis of permanent magnets. The model is similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a> but has an initial magnetization preset of -100% and an adapted icon for better readability of the diagram.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericLinearPermanentMagnet\">GenericLinearPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericLinearPM.png\">
  </td>
  <td>
  Simple model of a linear permanent Magnet. Typical characteristics of common permanent magnetic materials can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">FluxTubes.Material.HardMagnetic</a>.
  </td>
 </tr>

</table>

</html>"));
end Hysteresis;

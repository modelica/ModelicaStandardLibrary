within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis;
class Preisach "Preisach Hysteresis Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>The Preisach hysteresis model</h4>

<p>
This section gives an very brief overview of the Preisach hysteresis model, which is explained in more detail in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Pr35, Ma03, Zi12]</a>. The classical Preisach hysteresis model describes the course of magnetic flux density B(t) of a ferromagnetic core material as a function of the course of the magnetic field strength H(t) and its history. The model assumes an infinite set of elementary hysteresis operators &gamma;&alpha;&beta;. The simple rectangular pattern of the output &gamma;&alpha;&beta;H(t) of such an operator with its upper and lower switching limits &alpha; and &beta; is shown Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1: </strong>Characteristics of an elementary hysteresis operator.</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_elementaryOperator.png\">
    </td>
  </tr>
</table>

<p>
Due to &alpha;&ge;&beta;, the switching limits &alpha; and &beta; span a right triangular region, often referred to as Preisach plane (see Fig. 2a). For each single point (&alpha;,&beta;) on this plane exactly one elementary hysteresis operator is defined with exactly the switching limits of &alpha; and &beta;.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 2:</strong> Preisach Plane (a) and exemplary plot of the Preisach distribution function P(&alpha;,&beta;) (b)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_PlaneAndDist.png\">
    </td>
  </tr>
</table>

<p>
Additionally, the Preisach distribution function P(&alpha;,&beta;) is defined over the Preisach plane, which gives each operator an individual weight (see Fig. 2b). The Preisach plane can be separated into two regions. The S+ region, in which all the operators being in the &quot;+1&quot; state and the S- region, in which all the operators being in the &quot;-1&quot; state. The line L(t), which separates the regions S+ and S- develops along with the variation of the magnetic field strength H(t) and holds information about its history. The current magnetic flux density can than be computed as follows:
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_PreisachBt.png\">
    </td>
  </tr>
</table>

<h4>Hysteresis shape and computing of the double integral</h4>

<p>
The equation above shows, that the double integral of P(&alpha;,&beta;) have to be computed in every time step to compute B(t) according to the Preisach hysteresis model. Typically, the Preisach distribution function is not analytically integrable twice. A numerical double integration in every time step would be very computationally intensive. Therefore, an analytical description of the Everett function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> is used to define the hysteresis shape.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_EverettFcn.png\">
    </td>
  </tr>
</table>

<p>
The Everett function returns the change in magnetization which results when all elementary hysteresis operators of the region R switch from \"-1\" to the \"+1\" state (see Fig 3.). The entire Region S+ can be now be decomposed into several smaller triangular regions similar to R. This way the magnetization B(t) can be efficiently evaluated without the need of the numerical integration of the Preisach distribution function.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 3:</strong> Preisach plane and region R over which P(&alpha;,&beta;) is integrated to obtain E(H1,H2)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/EverettRegion.png\">
    </td>
  </tr>
</table>

<p>
According to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> the used analytical form of the Everett function is parameterized by 8 parameters. Several parameter sets were identified to fit measured or published static hysteresis behavior of different materials. These predefined parameter sets are stored in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\"><code>FluxTubes.Material.HysteresisEverettParameter</code></a> library and can be used with the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\"><code>GenericHystPreisachEverett</code></a> flux tube element. Additionally, also the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\"><code>GenericHystTellinenEverett</code></a> element can use this library.
</p>

</html>"));
end Preisach;

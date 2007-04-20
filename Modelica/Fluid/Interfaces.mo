package Interfaces 
  "Interfaces for steady state and unsteady, mixed-phase, multi-substance, incompressible and compressible flow" 
  
  connector FluidPort 
    "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
    
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
      "Medium model" annotation (choicesAllMatching=true);
    
    Medium.AbsolutePressure p "Pressure in the connection point";
    flow Medium.MassFlowRate m_flow 
      "Mass flow rate from the connection point into the component";
    
    Medium.SpecificEnthalpy h 
      "Specific mixing enthalpy in the connection point";
    flow Medium.EnthalpyFlowRate H_flow 
      "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
    
    Medium.MassFraction Xi[Medium.nXi] 
      "Independent mixture mass fractions m_i/m in the connection point";
    flow Medium.MassFlowRate mXi_flow[Medium.nXi] 
      "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mXi_flow = m_flow*Xi)";
    
    Medium.ExtraProperty C[Medium.nC] 
      "properties c_i/m in the connection point";
    flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
      "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
    
  end FluidPort;
  
  annotation (Documentation(info="<html>
 
</html>", revisions="<html>
<ul>
<li><i>Apr. 20, 2006</i>
       by Christoph Richter: moved parts of the original package from Modelica_Fluid
       to the development branch of Modelica 2.2.2.</li>
<li><i>Nov. 2, 2005</i>
       by Francesco Casella: restructured after 45th Design Meeting.</li>
<li><i>Nov. 20-21, 2002</i>
       by Hilding Elmqvist, Mike Tiller, Allan Watson, John Batteh, Chuck Newman,
       Jonas Eborn: Improved at the 32nd Modelica Design Meeting.
<li><i>Nov. 11, 2002</i>
       by Hilding Elmqvist, Martin Otter: improved version.</li>
<li><i>Nov. 6, 2002</i>
       by Hilding Elmqvist: first version.</li>
<li><i>Aug. 11, 2002</i>
       by Martin Otter: Improved according to discussion with Hilding
       Elmqvist and Hubertus Tummescheit.<br>
       The PortVicinity model is manually
       expanded in the base models.<br>
       The Volume used for components is renamed
       PartialComponentVolume.<br>
       A new volume model \"Fluid.Components.PortVolume\"
       introduced that has the medium properties of the port to which it is
       connected.<br>
       Fluid.Interfaces.PartialTwoPortTransport is a component
       for elementary two port transport elements, whereas PartialTwoPort
       is a component for a container component.</li>
</ul>
</html>"));
  
  extends Modelica.Icons.Library;
  
  connector FluidPort_a "Fluid connector with filled icon" 
    extends FluidPort;
    annotation (defaultComponentName="port_a",
                Diagram(Ellipse(extent=[-40,40; 40,-40], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=69,
            rgbfillColor={0,127,255})),
                               Text(extent=[-150,110; 150,50],   string="%name")),
         Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
              fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
              fillColor=69))));
  end FluidPort_a;
  
  connector FluidPort_b "Fluid connector with outlined icon" 
    extends FluidPort;
    annotation (defaultComponentName="port_b",
                Diagram(Ellipse(extent=[-40,40; 40,-40], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=69,
            rgbfillColor={0,127,255})),
                               Ellipse(extent=[-30,30; 30,-30],   style(color=69,
               fillColor=7)), Text(extent=[-150,110; 150,50],   string="%name")),
         Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
              fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
              fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
               fillColor=7))));
  end FluidPort_b;
  
  connector FluidPorts_a 
    "Fluid connector with filled, large icon to be used for vectors of FluidPorts (vector dimensions must be added after dragging)" 
    extends FluidPort;
    annotation (defaultComponentName="ports_a",
                Diagram(       Text(extent=[-75,130; 75,100],  string="%name"),
        Rectangle(extent=[-25,100; 25,-100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Ellipse(extent=[-25,90; 25,40],style(color=16,fillColor=69)),
        Ellipse(extent=[-25,25; 25,-25],style(color=16,fillColor=69)),
        Ellipse(extent=[-25,-40; 25,-90], style(color=16,fillColor=69))),
         Icon(
        Rectangle(extent=[-50,200; 50,-200], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
                              Ellipse(extent=[-50,180; 50,80],       style(color=16,
              fillColor=69)), Ellipse(extent=[-50,50; 50,-50],       style(color=16,
              fillColor=69)), Ellipse(extent=[-50,-80; 50,-180],     style(color=16,
              fillColor=69))),
      Coordsys(
        extent=[-50,-200; 50,200],
        grid=[1,1],
        scale=0.2));
  end FluidPorts_a;
  
  connector FluidPorts_b 
    "Fluid connector with outlined, large icon to be used for vectors of FluidPorts (vector dimensions must be added after dragging)" 
    extends FluidPort;
    annotation (defaultComponentName="ports_b",
                Diagram(       Text(extent=[-75,130; 75,100],  string="%name"),
        Rectangle(extent=[-25,100; 25,-100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Ellipse(extent=[-25,90; 25,40],style(color=16,fillColor=69)),
        Ellipse(extent=[-25,25; 25,-25],style(color=16,fillColor=69)),
        Ellipse(extent=[-25,-40; 25,-90], style(color=16,fillColor=69)),
        Ellipse(extent=[-15,-50; 15,-80], style(color=69, fillColor=7)),
        Ellipse(extent=[-15,15; 15,-15], style(color=69, fillColor=7)),
        Ellipse(extent=[-15,50; 15,80], style(color=69, fillColor=7))),
         Icon(
        Rectangle(extent=[-50,200; 50,-200], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
                              Ellipse(extent=[-50,180; 50,80],       style(color=16,
              fillColor=69)), Ellipse(extent=[-50,50; 50,-50],       style(color=16,
              fillColor=69)), Ellipse(extent=[-50,-80; 50,-180],     style(color=16,
              fillColor=69)),
            Ellipse(extent=[-30,30; 30,-30], style(color=69, fillColor=7)),
            Ellipse(extent=[-30,100; 30,160], style(color=69, fillColor=7)),
            Ellipse(extent=[-30,-100; 30,-160], style(color=69, fillColor=7))),
      Coordsys(
        extent=[-50,-200; 50,200],
        grid=[1,1],
        scale=0.2));
  end FluidPorts_b;
end Interfaces;

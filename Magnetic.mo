package Magnetic "Library of magnetic components" 
  package Interfaces "Magnetic Connectors" 
    connector MagneticPort 
      Modelica.SIunits.MagneticPotential V 
        "Magnetic potential with respect to magnetic ground";
      flow Modelica.SIunits.MagneticFlux Phi 
        "Magnetic Flux flowing into the pin";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram,
        Icon,
        Window(
          x=0.31,
          y=0.08,
          width=0.39,
          height=0.52));
    end MagneticPort;
    
    //Author: Thomas Boedrich, Dresden University of Technology, 14. Sept. 2004
    
    
    
    annotation (uses(Modelica(version="2.1 Beta1")));
    connector PositiveMagneticPort 
      extends MagneticPort;
      annotation (
        defaultComponentName = "p",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-100, 100; 100, -100], style(color=45,
                fillColor=45))),
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=45, fillColor=
                  45)), Text(
            extent=[-102, 160; 100, 108],
            string="%name",
            style(color=45, fillColor=45))),
        Window(
          x=0.45,
          y=0.01,
          width=0.35,
          height=0.49));
    end PositiveMagneticPort;

    connector NegativeMagneticPort 
      extends MagneticPort;
      annotation (
        defaultComponentName = "n",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Diagram(Rectangle(extent=[-100, 100; 100, -100], style(
              color=45, 
              rgbcolor={255,127,0}, 
              fillColor=7, 
              rgbfillColor={255,255,255}))),
        Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=45, 
              rgbcolor={255,127,0}, 
              fillColor=7, 
              rgbfillColor={255,255,255})),
                      Text(
            extent=[-102, 156; 100, 110],
            string="%name",
            style(color=45, fillColor=45))),
        Window(
          x=0.45,
          y=0.01,
          width=0.35,
          height=0.49));
    end NegativeMagneticPort;
  end Interfaces;
end Magnetic;

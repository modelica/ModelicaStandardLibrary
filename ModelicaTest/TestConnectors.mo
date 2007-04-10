package TestConnectors "Test models for Modelica.Media connectors" 
  
  annotation (uses(Modelica_Fluid(version="0.900"),
      Modelica(Media(version="0.901")),
      Modelica(version="2.2.1")));
  import Modelica.SIunits.*;
  import Modelica.Media;
  
  package MinimalReduced 
      package Interfaces 
        connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
            replaceable package Medium = 
            Modelica.Media.Interfaces.PartialMedium "Medium model" 
                             annotation (choicesAllMatching=true);
        
            Medium.AbsolutePressure p "Pressure in the connection point";
            flow Medium.MassFlowRate m_flow 
          "Mass flow rate from the connection point into the component";
        
            Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
            flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
            Medium.MassFraction X[Medium.nX-1](quantity=Medium.substanceNames, start=Medium.reference_X[1:Medium.nX-1]) 
          "Mixture mass fractions m_i/m in the connection point";
            flow Medium.MassFlowRate mX_flow[Medium.nX-1](quantity=Medium.substanceNames) 
          "Mass flow rates of substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
        
            Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
            flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
        end FluidPort;
      
        connector FluidPort_a "Fluid connector with filled icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_a;
      
        connector FluidPort_b "Fluid connector with outlined icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_b;
      
      partial model PartialSource 
        "Partial component source with one fluid connector" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model within the source" 
           annotation (choicesAllMatching=true);
        Interfaces.FluidPort_b port(redeclare package Medium = 
              Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        Medium.BaseProperties medium "Medium in the source";
      equation 
        port.p = medium.p;
        port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
        port.mX_flow = semiLinear(port.m_flow, port.X, medium.X[Medium.nX-1]);
        annotation (Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= port.p) is identical to the
     pressure in the volume (= medium.p).</li>
<li> The enthalpy flow rate (= port.H_flow) and the mass flow rates of the
     substances (= port.mX_flow) depend on the direction of the mass flow rate.</li>
</ul>
</html>"));
      end PartialSource;
      end Interfaces;
    
    package Components 
      model Source "Ambient source component" 
        extends Interfaces.PartialSource;
        
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure";
        parameter Medium.Temperature T_ambient=300 "Ambient temperature";
        parameter Medium.MassFraction X_ambient[Medium.nX](quantity=Medium.substanceNames)=Medium.reference_X 
          "Ambient composition";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136,142; 132,80],   string="%name"),
            Text(
              extent=[-106,84; -76,64],
              style(color=3, rgbcolor={0,0,255}),
              string="p"),
            Text(
              extent=[-108,-58; -78,-78],
              style(color=3, rgbcolor={0,0,255}),
              string="X")),
          Documentation(info="<html>
<p>
</p>
</html>"),DymolaStoredErrors,
          Diagram);
        Modelica.Blocks.Interfaces.RealInput pPrescribed 
          annotation (extent=[-108,40; -88,60]);
        Modelica.Blocks.Interfaces.RealInput XPrescribed[Medium.nX] 
          annotation (extent=[-108,-54; -88,-32]);
        Modelica.Blocks.Interfaces.RealInput TPrescribed 
          annotation (extent=[-106,-4; -86,18]);
      equation 
        if cardinality(pPrescribed)==0 then
          medium.p = p_ambient;
          pPrescribed = 0;
        else
          medium.p = pPrescribed;
        end if;
        
        if cardinality(TPrescribed)==0 then
          medium.T = T_ambient;
          TPrescribed = 0;
        else
          medium.T = TPrescribed;
         end if;
        
        if cardinality(XPrescribed)==0 then
          medium.X = X_ambient;
          XPrescribed = zeros(Medium.nX);
        else
          medium.X = XPrescribed;
        end if;
      end Source;
      
      model Plenum "Plenum model with dynamic mass and energy balances" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Volume V "Volume";
        Medium.BaseProperties fluid "Fluid model";
        Mass M "Total mass";
        Mass MX[Medium.nX] "Partial mass of components";
        Energy U "Total internal energy";
        
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities
        M=V*fluid.d;
        MX=M*fluid.X;
        U = M*fluid.u;
        
        // Balance equations
        der(M)=port_a.m_flow+port_b.m_flow;
        der(MX[1:Medium.nX-1])=port_a.mX_flow+port_b.mX_flow;
        der(U)=port_a.H_flow+port_b.H_flow;
        sum(MX)=M;
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_b.p;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Plenum;
      
      model PressureDrop "Nonlinear pressure drop" 
        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Real K "Pressure loss coefficient";
        parameter Medium.MassFlowRate wnom "Nominal mass flow rate";
        
        Medium.BaseProperties fluid "Entering fluid model";
        Medium.MassFlowRate w(start=wnom) "Mass flow rate port_a->port_b";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
                                      annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
                                      annotation (extent=[80,-10; 100,10]);
        annotation (Icon(Rectangle(extent=[-80,32; 80,-34], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=2,
                fillColor=3,
                rgbfillColor={0,0,255})),
                                Text(extent=[-130,100; 138,38], string="%name")),
                                           DymolaStoredErrors);
      equation 
        // Quadratic flow characteristic (never mind if it's implicit...)
        (port_a.p-port_b.p)=K/fluid.d*w*(noEvent(abs(w))+wnom);
        
        fluid.p = if w>=0 then port_a.p else port_b.p;
        fluid.h = if w>=0 then port_a.h else port_b.h;
        fluid.X[1:Medium.nX-1] = if w>=0 then port_a.X[1:Medium.nX-1] else port_b.X[1:Medium.nX-1];
        sum(fluid.X)=1;
        
        // Boundary conditions
        port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
        port_a.mX_flow = semiLinear(port_a.m_flow, port_a.X, port_b.X);
        
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mX_flow + port_b.mX_flow = zeros(Medium.nX-1);
        
        // Design direction of mass flow rate
        w = port_a.m_flow;
        
      end PressureDrop;
      
    model Reactor "Plenum model with dynamic mass and energy balances" 
      final package Medium = Media.GasMixture "Medium model";
      parameter Volume V "Volume";
      parameter Boolean chemicalEquilibrium=false 
          "if true then chemical equilibrium else complete combustion";
      parameter Real K=1e-12 "Chemical equilibrium constant";
      Medium.BaseProperties fluid "Fluid model";
      Medium.AbsolutePressure p(stateSelect=StateSelect.always) 
          "Fluid pressure";
      Medium.Temperature T(stateSelect=StateSelect.always) "Fluid temperature";
      Medium.MassFraction X[Medium.nX](each stateSelect=StateSelect.default);
      Mass M "Total mass";
      Mass MX[Medium.nX] "Partial mass of components";
      Energy U "Total internal energy";
      MassFlowRate CH4_burned "Flow rate of burned CH4";
      MassFlowRate O2_burned "Flow rate of burned O2";
      MassFlowRate H2O_created "Flow rate of created H2O";
      MassFlowRate CO2_created "Flow rate of created CO2";
        
      Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
        annotation (extent=[-100,-10; -80,10]);
      Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
        annotation (extent=[80,-10; 100,10]);
    equation 
      // Total quantities
      M=V*fluid.d;
      MX=M*fluid.X;
      U = M*fluid.u;
        
      // Balance equations
      der(M)=port_a.m_flow+port_b.m_flow;
        // Water
      der(MX[1])=port_a.mX_flow[1]+port_b.mX_flow[1]+H2O_created;
        // Oxygen
      der(MX[2])=port_a.mX_flow[2]+port_b.mX_flow[2]-O2_burned;
        // Methane
      der(MX[3])=port_a.mX_flow[3]+port_b.mX_flow[3]-CH4_burned;
        // Carbon dioxide
      der(MX[4])=port_a.mX_flow[4]+port_b.mX_flow[4]+CO2_created;
        // Nitrogen
      sum(MX)=M;
      der(U)=port_a.H_flow+port_b.H_flow+CH4_burned*51e6;
        
      // Stoichiometric relationships (CH4+2O2->CO2+2H2O)
      O2_burned = 2*CH4_burned*32/16;
      CO2_created = CH4_burned*44/16;
      H2O_created = 2*CH4_burned*18/16;
        
      // Combustion flow rate determination
      if chemicalEquilibrium then
        // chemical equilibrium conditions
        K = (X[3]*X[2]^2) / (X[4]*X[1]^2+1e-16);
      else
        // complete combustion
        X[3] = 0;
      end if;
      assert(X[2]>=0, "Insufficient oxygen to complete combustion");
        
      // Boundary conditions
      port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
      port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_a.p;
        
      port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
      port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_b.p;
        
      fluid.p=p;
      fluid.T=T;
      fluid.X=X;
        
      annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3,
              fillColor=3,
              rgbfillColor={0,0,255})), Text(
            extent=[-142,120; 144,76],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),            Diagram);
    end Reactor;
    end Components;
    
    package TestCases "Test cases for non-minimal connector components" 
      package BaseTests 
        partial model Test1 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-40,0; -20,20]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the right source pressure is changed sinusoidally, possibly causing flow reversal in some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.25) 
            annotation (extent=[-10,0; 10,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[44,0; 24,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[92,4; 72,24]);
        equation 
          connect(PressDrop.port_b, Source2.port) annotation (points=[9,10; 23,10],
              style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop.port_a) annotation (points=[-19,10; -9,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -52,50; -52,15; -39.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -62,20; -62,10.7; -39.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -60,-14; -60,5.7; -39.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y, Source2.pPrescribed) annotation (points=[
                71,14; 59.5,14; 59.5,15; 43.8,15], style(color=74, rgbcolor={0,0,
                  127}));
        end Test1;
        
        partial model Test2 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,40; -44,60]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup, with three-way connections.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the lower right source pressure is changed sinusoidally, possibly causing flow reversal in PressDrop3 and PressDrop4 during some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,80; -80,100]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,40; -18,60]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[72,14; 52,34]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,50; -80,70]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,16; -80,36]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[100,0; 80,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-12,40; 8,60]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=0.3e6,
            wnom=0.10) 
            annotation (extent=[22,60; 42,80]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=0.6e6,
            wnom=0.10) 
            annotation (extent=[22,14; 42,34]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[76,60; 56,80]);
        equation 
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,90;
                -70,90; -70,55; -63.8,55], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,60;
                -76,60; -76,50.7; -63.6,50.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,26;
                -72,26; -72,45.7; -63.8,45.7],style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y,Source3. pPrescribed) annotation (points=[79,
                10; 71.5,10; 71.5,29; 71.8,29],    style(color=74, rgbcolor={0,0,
                  127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,50;
                -37,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                50; -11,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop3.port_a) annotation (points=[7,50;
                12,50; 12,70; 23,70], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop4.port_a) annotation (points=[7,50;
                12,50; 12,24; 23,24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source3.port) annotation (points=[41,24; 51,
                24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, Source2.port) annotation (points=[41,70; 55,
                70], style(color=69, rgbcolor={0,127,255}));
        end Test2;
        annotation (Documentation(info=""));
        partial model Test3 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.05) 
            annotation (extent=[-10,0; 10,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[22,0; 42,20]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir.port_a) annotation (points=[-19,10;
                -9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop2.port_a) annotation (points=[9,10;
                23,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[41,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
        end Test3;
        
        partial model Test4 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Two reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
        end Test4;
        
        partial model Test5 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Three reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.4e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[82,-36; 62,-16]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.2e6) 
            annotation (extent=[34,-36; 54,-16]);
          Components.Plenum Reservoir3(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,-36; 30,-16]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b,Source3. port) annotation (points=[53,-26; 61,
                -26],style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir3.port_b, PressDrop3.port_a) annotation (points=[29,
                -26; 35,-26], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir3.port_a) annotation (points=[5,10;
                6,10; 6,-26; 11,-26], style(color=69, rgbcolor={0,127,255}));
        end Test5;
        
        partial model Test6 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic components with and without mass and energy buildup. <p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero for t>25 .
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-38,2; -18,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[100,8; 80,28]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.1) 
            annotation (extent=[22,24; 42,44]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-8,24; 12,44]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[6,-10; 26,10]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[52,8; 72,28]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -40,10; -40,12; -37,12],
                         style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                12; -14,12; -14,34; -7,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop3.port_a) annotation (points=[-19,
                12; -14,12; -14,0; 7,0], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Reservoir.port_a) annotation (points=[11,34;
                23,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source2.port) annotation (points=[71,18; 79,
                18], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop4.port_a) annotation (points=[41,34;
                46,34; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, PressDrop4.port_a) annotation (points=[25,0;
                46,0; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
        end Test6;
      end BaseTests;
      
      annotation (Documentation(info="<html>
Test cases for the basic mixture components: components with mass and energy dynamic balances (represented by <tt>Plenum</tt>), and possibly with chemical equilibrium reactions (represented by <tt>Reactor</tt>, as well as components with static balances (represented by <tt>PressureDrop</tt>).
<p>
Test are numbered progressively in each package. <tt>BaseTests</tt> contains the basic model with generic replaceable media, while the other packages redeclare a specific medium model in the test cases. <tt>TestReaction employs the gas mixture model to include chemical equilibrium equations in the <tt>Reactor</tt> model.
</html>"));
      
      package Tests_GasMixture 
        package TestMedium = Media.GasMixture;
        constant Real TestXHeight[TestMedium.nX]={0, 0.1, 0,0,-0.1};
        
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          
          annotation (experiment(StopTime=8));
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(wnom=0.3),
            PressDrop2(wnom=0.3),
            PressDrop3(wnom=0.3));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (Diagram);
        end Test6;
        
        model Test7 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Complete combustion is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=false) 
            annotation (extent=[8,0; 28,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[27,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test7;
        
        model Test8 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Chemical equilibrium is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=true) 
            annotation (extent=[6,0; 26,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 7,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[25,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test8;
      end Tests_GasMixture;
      
      package Tests_LiquidMixture 
        package TestMedium=Media.LiquidMixture;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop2(wnom=0.05),
            PressDrop3(wnom=0.05),
            PressDrop1(wnom=0.05));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test6;
      end Tests_LiquidMixture;
      
      package Tests_FunctionMedium 
        package TestMedium=Media.FunctionMedium;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test6;
      end Tests_FunctionMedium;
    end TestCases;
    annotation (Documentation(info="<html>
This package test components with minimal connectors, i.e. with nX-1 mass fractions on the connector variables, and with reduced state vectors.
</html>"));
  end MinimalReduced;
  
  package NonMinimalFull 
    package Interfaces 
    connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium(final 
              useMinimalX =                                                                  false) 
          "Medium model" 
                       annotation (choicesAllMatching=true);
        
      Medium.AbsolutePressure p "Pressure in the connection point";
      flow Medium.MassFlowRate m_flow 
          "Mass flow rate from the connection point into the component";
        
      Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
      flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
      Medium.MassFraction X[Medium.nX](quantity=Medium.substanceNames, start=Medium.reference_X) 
          "Mixture mass fractions m_i/m in the connection point";
      flow Medium.MassFlowRate mX_flow[Medium.nX](quantity=Medium.substanceNames) 
          "Mass flow rates of substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
        
      Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
      flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
    end FluidPort;
      
    connector FluidPort_a "Fluid connector with filled icon" 
      extends Interfaces.FluidPort;
      annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                 fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                 fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
           Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                fillColor=69)), Text(
            extent=[-126, 160; 130, 104],
            string="%name",
            style(
              color=0,
              fillColor=69,
              fillPattern=1))));
    end FluidPort_a;
      
    connector FluidPort_b "Fluid connector with outlined icon" 
      extends Interfaces.FluidPort;
      annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                 fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                 fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                 fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
           Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                 fillColor=7)), Text(
            extent=[-126, 160; 130, 104],
            string="%name",
            style(
              color=0,
              fillColor=69,
              fillPattern=1))));
    end FluidPort_b;
      
      partial model PartialSource 
        "Partial component source with one fluid connector" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model within the source" 
           annotation (choicesAllMatching=true);
        Interfaces.FluidPort_b port(redeclare package Medium = 
              Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        Medium.BaseProperties medium "Medium in the source";
      equation 
        port.p = medium.p;
        port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
        port.mX_flow = semiLinear(port.m_flow, port.X, medium.X);
        annotation (Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= port.p) is identical to the
     pressure in the volume (= medium.p).</li>
<li> The enthalpy flow rate (= port.H_flow) and the mass flow rates of the
     substances (= port.mX_flow) depend on the direction of the mass flow rate.</li>
</ul>
</html>"));
      end PartialSource;
    end Interfaces;
    
    package Components 
      model Source "Ambient source component" 
        extends Interfaces.PartialSource;
        
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure";
        parameter Medium.Temperature T_ambient=300 "Ambient temperature";
        parameter Medium.MassFraction X_ambient[Medium.nX](quantity=Medium.substanceNames)=Medium.reference_X 
          "Ambient composition";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136,142; 132,80],   string="%name"),
            Text(
              extent=[-106,84; -76,64],
              style(color=3, rgbcolor={0,0,255}),
              string="p"),
            Text(
              extent=[-108,-58; -78,-78],
              style(color=3, rgbcolor={0,0,255}),
              string="X")),
          Documentation(info="<html>
<p>
</p>
</html>"),DymolaStoredErrors,
          Diagram);
        Modelica.Blocks.Interfaces.RealInput pPrescribed 
          annotation (extent=[-108,40; -88,60]);
        Modelica.Blocks.Interfaces.RealInput XPrescribed[Medium.nX] 
          annotation (extent=[-108,-54; -88,-32]);
        Modelica.Blocks.Interfaces.RealInput TPrescribed 
          annotation (extent=[-106,-4; -86,18]);
      equation 
        if cardinality(pPrescribed)==0 then
          medium.p = p_ambient;
          pPrescribed = 0;
        else
          medium.p = pPrescribed;
        end if;
        
        if cardinality(TPrescribed)==0 then
          medium.T = T_ambient;
          TPrescribed = 0;
        else
          medium.T = TPrescribed;
         end if;
        
        if cardinality(XPrescribed)==0 then
          medium.X = X_ambient;
          XPrescribed = zeros(Medium.nX);
        else
          medium.X = XPrescribed;
        end if;
      end Source;
      
      model Plenum "Plenum model with dynamic mass and energy balances" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Volume V "Volume";
        Medium.BaseProperties fluid "Fluid model";
        Mass M "Total mass";
        Mass MX[Medium.nX] "Partial mass of components";
        Energy U "Total internal energy";
        
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities rewritten
        fluid.d = M/V;
        fluid.X=MX/M;
        U = M*fluid.u;
        
        // Balance equations
        der(M)=port_a.m_flow+port_b.m_flow;
        der(MX)=port_a.mX_flow+port_b.mX_flow;
        der(U)=port_a.H_flow+port_b.H_flow;
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X);
        fluid.p=port_b.p;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Plenum;
      
      model PressureDrop "Nonlinear pressure drop" 
        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Real K "Pressure loss coefficient";
        parameter Medium.MassFlowRate wnom "Nominal mass flow rate";
        
        Medium.BaseProperties fluid "Entering fluid model";
        Medium.MassFlowRate w(start=wnom) "Mass flow rate port_a->port_b";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
                                      annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
                                      annotation (extent=[80,-10; 100,10]);
        annotation (Icon(Rectangle(extent=[-80,32; 80,-34], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=2,
                fillColor=3,
                rgbfillColor={0,0,255})),
                                Text(extent=[-130,100; 138,38], string="%name")),
                                           DymolaStoredErrors);
      equation 
        // Quadratic flow characteristic (never mind if it's implicit...)
        (port_a.p-port_b.p)=K/fluid.d*w*(noEvent(abs(w))+wnom);
        
        fluid.p = if w>=0 then port_a.p else port_b.p;
        fluid.h = if w>=0 then port_a.h else port_b.h;
        fluid.X = if w>=0 then port_a.X else port_b.X;
        
        // Boundary conditions
        port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
        port_a.mX_flow = semiLinear(port_a.m_flow, port_a.X, port_b.X);
        
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mX_flow + port_b.mX_flow = zeros(Medium.nX);
        
        // Design direction of mass flow rate
        w = port_a.m_flow;
        
      end PressureDrop;
      
      model Reactor "Plenum model with dynamic mass and energy balances" 
        final package Medium = Media.GasMixture "Medium model";
        parameter Volume V "Volume";
        parameter Boolean chemicalEquilibrium=false 
          "if true then chemical equilibrium else complete combustion";
        parameter Real K=1e-12 "Chemical equilibrium constant";
        Medium.BaseProperties fluid "Fluid model";
        Medium.AbsolutePressure p(stateSelect=StateSelect.always) 
          "Fluid pressure";
        Medium.Temperature T(stateSelect=StateSelect.always) 
          "Fluid temperature";
        Medium.MassFraction X[Medium.nX](each stateSelect=StateSelect.default);
        Mass M "Total mass";
        Mass MX[Medium.nX] "Partial mass of components";
        Energy U "Total internal energy";
        MassFlowRate CH4_burned "Flow rate of burned CH4";
        MassFlowRate O2_burned "Flow rate of burned O2";
        MassFlowRate H2O_created "Flow rate of created H2O";
        MassFlowRate CO2_created "Flow rate of created CO2";
        
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities
        M=V*fluid.d;
        MX=M*fluid.X;
        U = M*fluid.u;
        
        // Balance equations
        der(M)=port_a.m_flow+port_b.m_flow;
          // Water
        der(MX[1])=port_a.mX_flow[1]+port_b.mX_flow[1]+H2O_created;
          // Oxygen
        der(MX[2])=port_a.mX_flow[2]+port_b.mX_flow[2]-O2_burned;
          // Methane
        der(MX[3])=port_a.mX_flow[3]+port_b.mX_flow[3]-CH4_burned;
          // Carbon dioxide
        der(MX[4])=port_a.mX_flow[4]+port_b.mX_flow[4]+CO2_created;
          // Nitrogen
        der(MX[5])=port_a.mX_flow[5]+port_b.mX_flow[5];
        der(U)=port_a.H_flow+port_b.H_flow+CH4_burned*51e6;
        
        // Stoichiometric relationships (CH4+2O2->CO2+2H2O)
        O2_burned = 2*CH4_burned*32/16;
        CO2_created = CH4_burned*44/16;
        H2O_created = 2*CH4_burned*18/16;
        
        // Combustion flow rate determination
        if chemicalEquilibrium then
          // chemical equilibrium conditions
          K = (X[3]*X[2]^2) / (X[4]*X[1]^2+1e-16);
        else
          // complete combustion
          X[3] = 0;
        end if;
        assert(X[2]>=0, "Insufficient oxygen to complete combustion");
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X);
        fluid.p=port_b.p;
        
        fluid.p=p;
        fluid.T=T;
        fluid.X=X;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Reactor;
    end Components;
    
    package TestCases "Test cases for non-minimal connector components" 
      
      annotation (Documentation(info="<html>
Test cases for the basic mixture components: components with mass and energy dynamic balances (represented by <tt>Plenum</tt>), and possibly with chemical equilibrium reactions (represented by <tt>Reactor</tt>, as well as components with static balances (represented by <tt>PressureDrop</tt>).
<p>
Test are numbered progressively in each package. <tt>BaseTests</tt> contains the basic model with generic replaceable media, while the other packages redeclare a specific medium model in the test cases. <tt>TestReaction employs the gas mixture model to include chemical equilibrium equations in the <tt>Reactor</tt> model.
</html>"));
      
      package BaseTests 
        partial model Test1 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-40,0; -20,20]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the right source pressure is changed sinusoidally, possibly causing flow reversal in some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.25) 
            annotation (extent=[-10,0; 10,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[44,0; 24,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[92,4; 72,24]);
        equation 
          connect(PressDrop.port_b, Source2.port) annotation (points=[9,10; 23,10],
              style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop.port_a) annotation (points=[-19,10; -9,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -52,50; -52,15; -39.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -62,20; -62,10.7; -39.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -60,-14; -60,5.7; -39.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y, Source2.pPrescribed) annotation (points=[
                71,14; 59.5,14; 59.5,15; 43.8,15], style(color=74, rgbcolor={0,0,
                  127}));
        end Test1;
        
        partial model Test2 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,40; -44,60]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup, with three-way connections.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the lower right source pressure is changed sinusoidally, possibly causing flow reversal in PressDrop3 and PressDrop4 during some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,80; -80,100]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,40; -18,60]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[72,14; 52,34]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,50; -80,70]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,16; -80,36]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[100,0; 80,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-12,40; 8,60]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=0.3e6,
            wnom=0.10) 
            annotation (extent=[22,60; 42,80]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=0.6e6,
            wnom=0.10) 
            annotation (extent=[22,14; 42,34]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[76,60; 56,80]);
        equation 
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,90;
                -70,90; -70,55; -63.8,55], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,60;
                -76,60; -76,50.7; -63.6,50.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,26;
                -72,26; -72,45.7; -63.8,45.7],style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y,Source3. pPrescribed) annotation (points=[79,
                10; 71.5,10; 71.5,29; 71.8,29],    style(color=74, rgbcolor={0,0,
                  127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,50;
                -37,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                50; -11,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop3.port_a) annotation (points=[7,50;
                12,50; 12,70; 23,70], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop4.port_a) annotation (points=[7,50;
                12,50; 12,24; 23,24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source3.port) annotation (points=[41,24; 51,
                24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, Source2.port) annotation (points=[41,70; 55,
                70], style(color=69, rgbcolor={0,127,255}));
        end Test2;
        annotation (Documentation(info=""));
        partial model Test3 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.05) 
            annotation (extent=[-10,0; 10,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[22,0; 42,20]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir.port_a) annotation (points=[-19,10;
                -9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop2.port_a) annotation (points=[9,10;
                23,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[41,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
        end Test3;
        
        partial model Test4 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Two reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
        end Test4;
        
        partial model Test5 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Three reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.4e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[82,-36; 62,-16]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.2e6) 
            annotation (extent=[34,-36; 54,-16]);
          Components.Plenum Reservoir3(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,-36; 30,-16]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b,Source3. port) annotation (points=[53,-26; 61,
                -26],style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir3.port_b, PressDrop3.port_a) annotation (points=[29,
                -26; 35,-26], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir3.port_a) annotation (points=[5,10;
                6,10; 6,-26; 11,-26], style(color=69, rgbcolor={0,127,255}));
        end Test5;
        
        partial model Test6 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic components with and without mass and energy buildup. <p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero for t>25 .
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-38,2; -18,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[100,8; 80,28]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.1) 
            annotation (extent=[22,24; 42,44]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-8,24; 12,44]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[6,-10; 26,10]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[52,8; 72,28]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -40,10; -40,12; -37,12],
                         style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                12; -14,12; -14,34; -7,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop3.port_a) annotation (points=[-19,
                12; -14,12; -14,0; 7,0], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Reservoir.port_a) annotation (points=[11,
                34; 23,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source2.port) annotation (points=[71,18;
                79,18], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop4.port_a) annotation (points=[41,
                34; 46,34; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, PressDrop4.port_a) annotation (points=[25,
                0; 46,0; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
        end Test6;
      end BaseTests;
      
      package Tests_GasMixture 
        package TestMedium = Media.GasMixture(final useMinimalX=false);
        constant Real TestXHeight[Medium.nX]={0, 0.1, 0,0,-0.1};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
          
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test6;
        
        model Test7 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Complete combustion is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=false) 
            annotation (extent=[8,0; 28,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[27,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test7;
        
        model Test8 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Chemical equilibrium is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=true) 
            annotation (extent=[6,0; 26,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 7,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[25,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test8;
      end Tests_GasMixture;
      
      package Tests_LiquidMixture 
        package TestMedium=Media.LiquidMixture;
        constant Real TestXHeight[Medium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(wnom=0.05),
            PressDrop2(wnom=0.05),
            PressDrop3(wnom=0.05),
            PressDrop4(wnom=0.05));
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test6;
      end Tests_LiquidMixture;
      
      package Tests_FunctionMedium 
        package TestMedium=Media.FunctionMedium;
        constant Real TestXHeight[Medium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test6;
      end Tests_FunctionMedium;
    end TestCases;
    annotation (Documentation(info="<html>
This package test components with non-minimal connectors, i.e. with all the nX mass fractions on the connector variables, and with full, redundant state vectors.
</html>"));
  end NonMinimalFull;
  
  package MinimalFull 
      package Interfaces 
        connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
            replaceable package Medium = 
            Modelica.Media.Interfaces.PartialMedium "Medium model" 
                             annotation (choicesAllMatching=true);
        
            Medium.AbsolutePressure p "Pressure in the connection point";
            flow Medium.MassFlowRate m_flow 
          "Mass flow rate from the connection point into the component";
        
            Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
            flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
            Medium.MassFraction X[Medium.nX-1](quantity=Medium.substanceNames, start=Medium.reference_X[1:Medium.nX-1]) 
          "Mixture mass fractions m_i/m in the connection point";
            flow Medium.MassFlowRate mX_flow[Medium.nX-1](quantity=Medium.substanceNames) 
          "Mass flow rates of substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
        
            Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
            flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
        end FluidPort;
      
        connector FluidPort_a "Fluid connector with filled icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_a;
      
        connector FluidPort_b "Fluid connector with outlined icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_b;
      
      partial model PartialSource 
        "Partial component source with one fluid connector" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model within the source" 
           annotation (choicesAllMatching=true);
        Interfaces.FluidPort_b port(redeclare package Medium = 
              Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        Medium.BaseProperties medium "Medium in the source";
      equation 
        port.p = medium.p;
        port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
        port.mX_flow = semiLinear(port.m_flow, port.X, medium.X[Medium.nX-1]);
        annotation (Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= port.p) is identical to the
     pressure in the volume (= medium.p).</li>
<li> The enthalpy flow rate (= port.H_flow) and the mass flow rates of the
     substances (= port.mX_flow) depend on the direction of the mass flow rate.</li>
</ul>
</html>"));
      end PartialSource;
      end Interfaces;
    
    package Components 
      model Source "Ambient source component" 
        extends Interfaces.PartialSource;
        
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure";
        parameter Medium.Temperature T_ambient=300 "Ambient temperature";
        parameter Medium.MassFraction X_ambient[Medium.nX](quantity=Medium.substanceNames)=Medium.reference_X 
          "Ambient composition";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136,142; 132,80],   string="%name"),
            Text(
              extent=[-106,84; -76,64],
              style(color=3, rgbcolor={0,0,255}),
              string="p"),
            Text(
              extent=[-108,-58; -78,-78],
              style(color=3, rgbcolor={0,0,255}),
              string="X")),
          Documentation(info="<html>
<p>
</p>
</html>"),DymolaStoredErrors,
          Diagram);
        Modelica.Blocks.Interfaces.RealInput pPrescribed 
          annotation (extent=[-108,40; -88,60]);
        Modelica.Blocks.Interfaces.RealInput XPrescribed[Medium.nX] 
          annotation (extent=[-108,-54; -88,-32]);
        Modelica.Blocks.Interfaces.RealInput TPrescribed 
          annotation (extent=[-106,-4; -86,18]);
      equation 
        if cardinality(pPrescribed)==0 then
          medium.p = p_ambient;
          pPrescribed = 0;
        else
          medium.p = pPrescribed;
        end if;
        
        if cardinality(TPrescribed)==0 then
          medium.T = T_ambient;
          TPrescribed = 0;
        else
          medium.T = TPrescribed;
         end if;
        
        if cardinality(XPrescribed)==0 then
          medium.X = X_ambient;
          XPrescribed = zeros(Medium.nX);
        else
          medium.X = XPrescribed;
        end if;
      end Source;
      
      model Plenum "Plenum model with dynamic mass and energy balances" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Volume V "Volume";
        Medium.BaseProperties fluid "Fluid model";
        Mass M "Total mass";
        Mass MX[Medium.nX] "Partial mass of components";
        Energy U "Total internal energy";
        MassFlowRate port_a_mX_flow_full[Medium.nX](start=Medium.reference_X) 
          "Full partial flow rate vector";
        MassFlowRate port_b_mX_flow_full[Medium.nX](start=Medium.reference_X) 
          "Full partial flow rate vector";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities
        M=V*fluid.d;
        MX=M*fluid.X;
        U = M*fluid.u;
        
        // Balance equations
        der(M)=port_a.m_flow+port_b.m_flow;
        port_a_mX_flow_full[1:Medium.nX-1]=port_a.mX_flow;
        port_a_mX_flow_full[Medium.nX]=port_a.m_flow-sum(port_a.mX_flow);
        port_b_mX_flow_full[1:Medium.nX-1]=port_b.mX_flow;
        port_b_mX_flow_full[Medium.nX]=port_b.m_flow-sum(port_b.mX_flow);
        
        der(MX)=port_a_mX_flow_full+port_b_mX_flow_full;
        der(U)=port_a.H_flow+port_b.H_flow;
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_b.p;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Plenum;
      
      model PressureDrop "Nonlinear pressure drop" 
        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Real K "Pressure loss coefficient";
        parameter Medium.MassFlowRate wnom "Nominal mass flow rate";
        
        Medium.BaseProperties fluid "Entering fluid model";
        Medium.MassFlowRate w(start=wnom) "Mass flow rate port_a->port_b";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
                                      annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
                                      annotation (extent=[80,-10; 100,10]);
        annotation (Icon(Rectangle(extent=[-80,32; 80,-34], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=2,
                fillColor=3,
                rgbfillColor={0,0,255})),
                                Text(extent=[-130,100; 138,38], string="%name")),
                                           DymolaStoredErrors);
      equation 
        // Quadratic flow characteristic (never mind if it's implicit...)
        (port_a.p-port_b.p)=K/fluid.d*w*(noEvent(abs(w))+wnom);
        
        fluid.p = if w>=0 then port_a.p else port_b.p;
        fluid.h = if w>=0 then port_a.h else port_b.h;
        fluid.X[1:Medium.nX-1] = if w>=0 then port_a.X[1:Medium.nX-1] else port_b.X[1:Medium.nX-1];
        sum(fluid.X)=1;
        
        // Boundary conditions
        port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
        port_a.mX_flow = semiLinear(port_a.m_flow, port_a.X, port_b.X);
        
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mX_flow + port_b.mX_flow = zeros(Medium.nX-1);
        
        // Design direction of mass flow rate
        w = port_a.m_flow;
        
      end PressureDrop;
    end Components;
    
    package TestCases "Test cases for non-minimal connector components" 
      package BaseTests 
        partial model Test1 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-40,0; -20,20]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the right source pressure is changed sinusoidally, possibly causing flow reversal in some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.25) 
            annotation (extent=[-10,0; 10,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[44,0; 24,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[92,4; 72,24]);
        equation 
          connect(PressDrop.port_b, Source2.port) annotation (points=[9,10; 23,10],
              style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop.port_a) annotation (points=[-19,10; -9,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -52,50; -52,15; -39.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -62,20; -62,10.7; -39.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -60,-14; -60,5.7; -39.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y, Source2.pPrescribed) annotation (points=[
                71,14; 59.5,14; 59.5,15; 43.8,15], style(color=74, rgbcolor={0,0,
                  127}));
        end Test1;
        
        partial model Test2 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,40; -44,60]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup, with three-way connections.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the lower right source pressure is changed sinusoidally, possibly causing flow reversal in PressDrop3 and PressDrop4 during some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,80; -80,100]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,40; -18,60]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[72,14; 52,34]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,50; -80,70]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,16; -80,36]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[100,0; 80,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-12,40; 8,60]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=0.3e6,
            wnom=0.10) 
            annotation (extent=[22,60; 42,80]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=0.6e6,
            wnom=0.10) 
            annotation (extent=[22,14; 42,34]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[76,60; 56,80]);
        equation 
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,90;
                -70,90; -70,55; -63.8,55], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,60;
                -76,60; -76,50.7; -63.6,50.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,26;
                -72,26; -72,45.7; -63.8,45.7],style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y,Source3. pPrescribed) annotation (points=[79,
                10; 71.5,10; 71.5,29; 71.8,29],    style(color=74, rgbcolor={0,0,
                  127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,50;
                -37,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                50; -11,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop3.port_a) annotation (points=[7,50;
                12,50; 12,70; 23,70], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop4.port_a) annotation (points=[7,50;
                12,50; 12,24; 23,24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source3.port) annotation (points=[41,24; 51,
                24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, Source2.port) annotation (points=[41,70; 55,
                70], style(color=69, rgbcolor={0,127,255}));
        end Test2;
        annotation (Documentation(info=""));
        partial model Test3 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.05) 
            annotation (extent=[-10,0; 10,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[22,0; 42,20]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir.port_a) annotation (points=[-19,10;
                -9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop2.port_a) annotation (points=[9,10;
                23,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[41,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
        end Test3;
        
        partial model Test4 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Two reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
        end Test4;
        
        partial model Test5 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Three reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.4e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[82,-36; 62,-16]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.2e6) 
            annotation (extent=[34,-36; 54,-16]);
          Components.Plenum Reservoir3(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,-36; 30,-16]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b,Source3. port) annotation (points=[53,-26; 61,
                -26],style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir3.port_b, PressDrop3.port_a) annotation (points=[29,
                -26; 35,-26], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir3.port_a) annotation (points=[5,10;
                6,10; 6,-26; 11,-26], style(color=69, rgbcolor={0,127,255}));
        end Test5;
        
        partial model Test6 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic components with and without mass and energy buildup. <p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero for t>25 .
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-38,2; -18,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[100,8; 80,28]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.1) 
            annotation (extent=[22,24; 42,44]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-8,24; 12,44]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[6,-10; 26,10]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[52,8; 72,28]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -40,10; -40,12; -37,12],
                         style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                12; -14,12; -14,34; -7,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop3.port_a) annotation (points=[-19,
                12; -14,12; -14,0; 7,0], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Reservoir.port_a) annotation (points=[11,34;
                23,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source2.port) annotation (points=[71,18; 79,
                18], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop4.port_a) annotation (points=[41,34;
                46,34; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, PressDrop4.port_a) annotation (points=[25,0;
                46,0; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
        end Test6;
      end BaseTests;
      
      annotation (Documentation(info="<html>
Test cases for the basic mixture components: components with mass and energy dynamic balances (represented by <tt>Plenum</tt>), and possibly with chemical equilibrium reactions (represented by <tt>Reactor</tt>, as well as components with static balances (represented by <tt>PressureDrop</tt>).
<p>
Test are numbered progressively in each package. <tt>BaseTests</tt> contains the basic model with generic replaceable media, while the other packages redeclare a specific medium model in the test cases. <tt>TestReaction employs the gas mixture model to include chemical equilibrium equations in the <tt>Reactor</tt> model.
</html>"));
      
      package Tests_GasMixture 
        package TestMedium = Media.GasMixture;
        constant Real TestXHeight[Medium.nX]={0, 0.1, 0,0,-0.1};
        
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
          
          annotation (experiment(StopTime=8));
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8));
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8));
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(wnom=0.3),
            PressDrop2(wnom=0.3),
            PressDrop3(wnom=0.3));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
          annotation (Diagram);
        end Test6;
        
      end Tests_GasMixture;
      
      package Tests_LiquidMixture 
        package TestMedium=Media.LiquidMixture;
        constant Real TestXHeight[Medium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop2(wnom=0.05),
            PressDrop3(wnom=0.05),
            PressDrop1(wnom=0.05));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test6;
      end Tests_LiquidMixture;
      
      package Tests_FunctionMedium 
        package TestMedium=Media.FunctionMedium;
        constant Real TestXHeight[Medium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X)=fill(0,Medium.nX);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X)=fill(0,Medium.nX);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X)=fill(0,Medium.nX);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X)=fill(0,Medium.nX);
        end Test6;
      end Tests_FunctionMedium;
    end TestCases;
    annotation (Documentation(info="<html>
This package test components with minimal connectors, i.e. nX-1 mass fractions on the connector variables, and with full, redundant state vectors.
</html>"));
  end MinimalFull;
  
  package MinimalReducedlV2 
      package Interfaces 
        connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
            replaceable package Medium = 
            Modelica.Media.Interfaces.PartialMedium "Medium model" 
                             annotation (choicesAllMatching=true);
        
            Medium.AbsolutePressure p "Pressure in the connection point";
            flow Medium.MassFlowRate m_flow 
          "Mass flow rate from the connection point into the component";
        
            Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
            flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
            Medium.MassFraction X[Medium.nX-1](quantity=Medium.substanceNames, start=Medium.reference_X[1:Medium.nX-1]) 
          "Mixture mass fractions m_i/m in the connection point";
            flow Medium.MassFlowRate mX_flow[Medium.nX-1](quantity=Medium.substanceNames) 
          "Mass flow rates of substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
        
            Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
            flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
        end FluidPort;
      
        connector FluidPort_a "Fluid connector with filled icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_a;
      
        connector FluidPort_b "Fluid connector with outlined icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_b;
      
      partial model PartialSource 
        "Partial component source with one fluid connector" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model within the source" 
           annotation (choicesAllMatching=true);
        Interfaces.FluidPort_b port(redeclare package Medium = 
              Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        Medium.BaseProperties medium "Medium in the source";
      equation 
        port.p = medium.p;
        port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
        port.mX_flow = semiLinear(port.m_flow, port.X, medium.X[Medium.nX-1]);
        annotation (Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= port.p) is identical to the
     pressure in the volume (= medium.p).</li>
<li> The enthalpy flow rate (= port.H_flow) and the mass flow rates of the
     substances (= port.mX_flow) depend on the direction of the mass flow rate.</li>
</ul>
</html>"));
      end PartialSource;
      end Interfaces;
    
    package Components 
      model Source "Ambient source component" 
        extends Interfaces.PartialSource;
        
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure";
        parameter Medium.Temperature T_ambient=300 "Ambient temperature";
        parameter Medium.MassFraction X_ambient[Medium.nX](quantity=Medium.substanceNames)=Medium.reference_X 
          "Ambient composition";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136,142; 132,80],   string="%name"),
            Text(
              extent=[-106,84; -76,64],
              style(color=3, rgbcolor={0,0,255}),
              string="p"),
            Text(
              extent=[-108,-58; -78,-78],
              style(color=3, rgbcolor={0,0,255}),
              string="X")),
          Documentation(info="<html>
<p>
</p>
</html>"),DymolaStoredErrors,
          Diagram);
        Modelica.Blocks.Interfaces.RealInput pPrescribed 
          annotation (extent=[-108,40; -88,60]);
        Modelica.Blocks.Interfaces.RealInput XPrescribed[Medium.nX] 
          annotation (extent=[-108,-54; -88,-32]);
        Modelica.Blocks.Interfaces.RealInput TPrescribed 
          annotation (extent=[-106,-4; -86,18]);
      equation 
        if cardinality(pPrescribed)==0 then
          medium.p = p_ambient;
          pPrescribed = 0;
        else
          medium.p = pPrescribed;
        end if;
        
        if cardinality(TPrescribed)==0 then
          medium.T = T_ambient;
          TPrescribed = 0;
        else
          medium.T = TPrescribed;
         end if;
        
        if cardinality(XPrescribed)==0 then
          medium.X = X_ambient;
          XPrescribed = zeros(Medium.nX);
        else
          medium.X = XPrescribed;
        end if;
      end Source;
      
      model Plenum "Plenum model with dynamic mass and energy balances" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Volume V "Volume";
        Medium.BaseProperties fluid(T(stateSelect=StateSelect.always)) 
          "Fluid model";
        Mass M "Total mass";
        Mass[Medium.nX] MX(stateSelect=StateSelect.always) 
          "Partial mass of components";
        Energy U "Total internal energy";
        Medium.MassFlowRate a_mX_flow[Medium.nX] = cat(1,port_a.mX_flow,{port_a.m_flow - sum(port_a.mX_flow)}) 
          "full flow vector at a";
        Medium.MassFlowRate b_mX_flow[Medium.nX] = cat(1,port_b.mX_flow,{port_b.m_flow - sum(port_b.mX_flow)}) 
          "full flow vector at b";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities
        M=V*fluid.d;
        fluid.X = MX/M;
        U = M*fluid.u;
        
        // Balance equations
        // der(M)=port_a.m_flow+port_b.m_flow;
        der(MX)=a_mX_flow+b_mX_flow;
        der(U)=port_a.H_flow+port_b.H_flow;
        sum(MX)=M;
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
        fluid.p=port_b.p;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Plenum;
      
      model PressureDrop "Nonlinear pressure drop" 
        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Real K "Pressure loss coefficient";
        parameter Medium.MassFlowRate wnom "Nominal mass flow rate";
        
        Medium.BaseProperties fluid "Entering fluid model";
        Medium.MassFlowRate w(start=wnom) "Mass flow rate port_a->port_b";
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
                                      annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
                                      annotation (extent=[80,-10; 100,10]);
        annotation (Icon(Rectangle(extent=[-80,32; 80,-34], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=2,
                fillColor=3,
                rgbfillColor={0,0,255})),
                                Text(extent=[-130,100; 138,38], string="%name")),
                                           DymolaStoredErrors);
      equation 
        // Quadratic flow characteristic (never mind if it's implicit...)
        (port_a.p-port_b.p)=K/fluid.d*w*(noEvent(abs(w))+wnom);
        
        fluid.p = if w>=0 then port_a.p else port_b.p;
        fluid.h = if w>=0 then port_a.h else port_b.h;
        fluid.X[1:Medium.nX-1] = if w>=0 then port_a.X[1:Medium.nX-1] else port_b.X[1:Medium.nX-1];
        sum(fluid.X)=1;
        
        // Boundary conditions
        port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
        port_a.mX_flow = semiLinear(port_a.m_flow, port_a.X, port_b.X);
        
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mX_flow + port_b.mX_flow = zeros(Medium.nX-1);
        
        // Design direction of mass flow rate
        w = port_a.m_flow;
        
      end PressureDrop;
      
    model Reactor "Plenum model with dynamic mass and energy balances" 
      final package Medium = Media.GasMixture "Medium model";
      parameter Volume V "Volume";
      parameter Boolean chemicalEquilibrium=false 
          "if true then chemical equilibrium else complete combustion";
      parameter Real K=1e-12 "Chemical equilibrium constant";
      Medium.BaseProperties fluid "Fluid model";
      Medium.AbsolutePressure p(stateSelect=StateSelect.always) 
          "Fluid pressure";
      Medium.Temperature T(stateSelect=StateSelect.always) "Fluid temperature";
      Medium.MassFraction X[Medium.nX](each stateSelect=StateSelect.default);
      Mass M "Total mass";
      Mass MX[Medium.nX] "Partial mass of components";
      Energy U "Total internal energy";
      Medium.MassFlowRate a_mX_flow[Medium.nX] = cat(1,port_a.mX_flow,{port_a.m_flow - sum(port_a.mX_flow)}) 
          "full flow vector at a";
      Medium.MassFlowRate b_mX_flow[Medium.nX] = cat(1,port_b.mX_flow,{port_b.m_flow - sum(port_b.mX_flow)}) 
          "full flow vector at b";
      MassFlowRate CH4_burned "Flow rate of burned CH4";
      MassFlowRate O2_burned "Flow rate of burned O2";
      MassFlowRate H2O_created "Flow rate of created H2O";
      MassFlowRate CO2_created "Flow rate of created CO2";
        
      Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
        annotation (extent=[-100,-10; -80,10]);
      Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
        annotation (extent=[80,-10; 100,10]);
    equation 
      // Total quantities
      M=V*fluid.d;
      MX=M*fluid.X;
      U = M*fluid.u;
        
      // Balance equations
      // der(M)=port_a.m_flow+port_b.m_flow;
        // Water
      der(MX[1])=a_mX_flow[1]+b_mX_flow[1]+H2O_created;
        // Oxygen
      der(MX[2])=a_mX_flow[2]+b_mX_flow[2]-O2_burned;
        // Methane
      der(MX[3])=a_mX_flow[3]+b_mX_flow[3]-CH4_burned;
        // Carbon dioxide
      der(MX[4])=a_mX_flow[4]+b_mX_flow[4]+CO2_created;
        // Nitrogen
      der(MX[5])=a_mX_flow[5]+b_mX_flow[5];
        //
      sum(MX)=M;
      der(U)=port_a.H_flow+port_b.H_flow+CH4_burned*51e6;
        
      // Stoichiometric relationships (CH4+2O2->CO2+2H2O)
      O2_burned = 2*CH4_burned*32/16;
      CO2_created = CH4_burned*44/16;
      H2O_created = 2*CH4_burned*18/16;
        
      // Combustion flow rate determination
      if chemicalEquilibrium then
        // chemical equilibrium conditions
        K = (X[3]*X[2]^2) / (X[4]*X[1]^2+1e-16);
      else
        // complete combustion
        X[3] = 0;
      end if;
      assert(X[2]>=0, "Insufficient oxygen to complete combustion");
        
      // Boundary conditions
      port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
      port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_a.p;
        
      port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
      port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_b.p;
        
      fluid.p=p;
      fluid.T=T;
      fluid.X=X;
        
      annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3,
              fillColor=3,
              rgbfillColor={0,0,255})), Text(
            extent=[-142,120; 144,76],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),            Diagram);
    end Reactor;
    end Components;
    
    package TestCases "Test cases for non-minimal connector components" 
      package BaseTests 
        partial model Test1 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-40,0; -20,20]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the right source pressure is changed sinusoidally, possibly causing flow reversal in some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.25) 
            annotation (extent=[-10,0; 10,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[44,0; 24,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[92,4; 72,24]);
        equation 
          connect(PressDrop.port_b, Source2.port) annotation (points=[9,10; 23,10],
              style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop.port_a) annotation (points=[-19,10; -9,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -52,50; -52,15; -39.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -62,20; -62,10.7; -39.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -60,-14; -60,5.7; -39.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y, Source2.pPrescribed) annotation (points=[
                71,14; 59.5,14; 59.5,15; 43.8,15], style(color=74, rgbcolor={0,0,
                  127}));
        end Test1;
        
        partial model Test2 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,40; -44,60]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup, with three-way connections.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the lower right source pressure is changed sinusoidally, possibly causing flow reversal in PressDrop3 and PressDrop4 during some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,80; -80,100]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,40; -18,60]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[72,14; 52,34]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,50; -80,70]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,16; -80,36]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[100,0; 80,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-12,40; 8,60]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=0.3e6,
            wnom=0.10) 
            annotation (extent=[22,60; 42,80]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=0.6e6,
            wnom=0.10) 
            annotation (extent=[22,14; 42,34]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[76,60; 56,80]);
        equation 
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,90;
                -70,90; -70,55; -63.8,55], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,60;
                -76,60; -76,50.7; -63.6,50.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,26;
                -72,26; -72,45.7; -63.8,45.7],style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y,Source3. pPrescribed) annotation (points=[79,
                10; 71.5,10; 71.5,29; 71.8,29],    style(color=74, rgbcolor={0,0,
                  127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,50;
                -37,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                50; -11,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop3.port_a) annotation (points=[7,50;
                12,50; 12,70; 23,70], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop4.port_a) annotation (points=[7,50;
                12,50; 12,24; 23,24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source3.port) annotation (points=[41,24; 51,
                24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, Source2.port) annotation (points=[41,70; 55,
                70], style(color=69, rgbcolor={0,127,255}));
        end Test2;
        annotation (Documentation(info=""));
        partial model Test3 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.05) 
            annotation (extent=[-10,0; 10,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[22,0; 42,20]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir.port_a) annotation (points=[-19,10;
                -9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop2.port_a) annotation (points=[9,10;
                23,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[41,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
        end Test3;
        
        partial model Test4 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Two reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
        end Test4;
        
        partial model Test5 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Three reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.4e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[82,-36; 62,-16]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.2e6) 
            annotation (extent=[34,-36; 54,-16]);
          Components.Plenum Reservoir3(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,-36; 30,-16]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b,Source3. port) annotation (points=[53,-26; 61,
                -26],style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir3.port_b, PressDrop3.port_a) annotation (points=[29,
                -26; 35,-26], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir3.port_a) annotation (points=[5,10;
                6,10; 6,-26; 11,-26], style(color=69, rgbcolor={0,127,255}));
        end Test5;
        
        partial model Test6 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic components with and without mass and energy buildup. <p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero for t>25 .
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-38,2; -18,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[100,8; 80,28]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.1) 
            annotation (extent=[22,24; 42,44]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-8,24; 12,44]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[6,-10; 26,10]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[52,8; 72,28]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -40,10; -40,12; -37,12],
                         style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                12; -14,12; -14,34; -7,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop3.port_a) annotation (points=[-19,
                12; -14,12; -14,0; 7,0], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Reservoir.port_a) annotation (points=[11,34;
                23,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source2.port) annotation (points=[71,18; 79,
                18], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop4.port_a) annotation (points=[41,34;
                46,34; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, PressDrop4.port_a) annotation (points=[25,0;
                46,0; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
        end Test6;
      end BaseTests;
      
      annotation (Documentation(info="<html>
Test cases for the basic mixture components: components with mass and energy dynamic balances (represented by <tt>Plenum</tt>), and possibly with chemical equilibrium reactions (represented by <tt>Reactor</tt>, as well as components with static balances (represented by <tt>PressureDrop</tt>).
<p>
Test are numbered progressively in each package. <tt>BaseTests</tt> contains the basic model with generic replaceable media, while the other packages redeclare a specific medium model in the test cases. <tt>TestReaction employs the gas mixture model to include chemical equilibrium equations in the <tt>Reactor</tt> model.
</html>"));
      
      package Tests_GasMixture 
        package TestMedium = Media.GasMixture;
        constant Real TestXHeight[TestMedium.nX]={0, 0.1, 0,0,-0.1};
        
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          
          annotation (experiment(StopTime=8));
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(wnom=0.3),
            PressDrop2(wnom=0.3),
            PressDrop3(wnom=0.3));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (Diagram);
        end Test6;
        
        model Test7 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Complete combustion is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=false) 
            annotation (extent=[8,0; 28,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[27,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test7;
        
        model Test8 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Chemical equilibrium is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=true) 
            annotation (extent=[6,0; 26,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 7,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[25,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test8;
      end Tests_GasMixture;
      
      package Tests_LiquidMixture 
        package TestMedium=Media.LiquidMixture;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop2(wnom=0.05),
            PressDrop3(wnom=0.05),
            PressDrop1(wnom=0.05));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test6;
      end Tests_LiquidMixture;
      
      package Tests_FunctionMedium 
        package TestMedium=Media.FunctionMedium;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test6;
      end Tests_FunctionMedium;
    end TestCases;
    annotation (Documentation(info="<html>
This package test components with minimal connectors, i.e. with nX-1 mass fractions on the connector variables, and with reduced state vectors. Alternative state equations provided by Hubertus
</html>"));
  end MinimalReducedlV2;
  
  package MinimalReducedV3 
      package Interfaces 
        connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
            replaceable package Medium = 
            Modelica.Media.Interfaces.PartialMedium "Medium model" 
                             annotation (choicesAllMatching=true);
        
            Medium.AbsolutePressure p "Pressure in the connection point";
            flow Medium.MassFlowRate m_flow 
          "Mass flow rate from the connection point into the component";
        
            Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
            flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
            Medium.MassFraction X_reduced[Medium.nX-1](quantity=Medium.substanceNames, start=Medium.reference_X[1:Medium.nX-1]) 
          "Independent substance mass fractions m_i/m in the connection point";
            flow Medium.MassFlowRate mX_flow_reduced[Medium.nX-1](quantity=Medium.substanceNames) 
          "Independent substance mass flow rates from the connection point into the component (if m_flow > 0, mX_flow_reduced = m_flow*X_reduced)";
        
            Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
            flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
        end FluidPort;
      
        connector FluidPort_a "Fluid connector with filled icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_a;
      
        connector FluidPort_b "Fluid connector with outlined icon" 
            extends Interfaces.FluidPort;
            annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                       fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                       fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
                 Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                      fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                      fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                       fillColor=7)), Text(
                  extent=[-126, 160; 130, 104],
                  string="%name",
                  style(
                    color=0,
                    fillColor=69,
                    fillPattern=1))));
        end FluidPort_b;
      
      partial model PartialSource 
        "Partial component source with one fluid connector" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model within the source" 
           annotation (choicesAllMatching=true);
        Interfaces.FluidPort_b port(redeclare package Medium = 
              Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        Medium.BaseProperties medium "Medium in the source";
      equation 
        port.p = medium.p;
        port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
        port.mX_flow_reduced = semiLinear(port.m_flow, port.X_reduced, medium.X_reduced);
        annotation (Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= port.p) is identical to the
     pressure in the volume (= medium.p).</li>
<li> The enthalpy flow rate (= port.H_flow) and the mass flow rates of the
     substances (= port.mX_flow) depend on the direction of the mass flow rate.</li>
</ul>
</html>"));
      end PartialSource;
      end Interfaces;
    
    package Components 
      model Source "Ambient source component" 
        extends Interfaces.PartialSource;
        
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure";
        parameter Medium.Temperature T_ambient=300 "Ambient temperature";
        parameter Medium.MassFraction X_ambient[Medium.nX](quantity=Medium.substanceNames)=Medium.reference_X 
          "Ambient composition";
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136,142; 132,80],   string="%name"),
            Text(
              extent=[-106,84; -76,64],
              style(color=3, rgbcolor={0,0,255}),
              string="p"),
            Text(
              extent=[-108,-58; -78,-78],
              style(color=3, rgbcolor={0,0,255}),
              string="X")),
          Documentation(info="<html>
<p>
</p>
</html>"),DymolaStoredErrors,
          Diagram);
        Modelica.Blocks.Interfaces.RealInput pPrescribed 
          annotation (extent=[-108,40; -88,60]);
        Modelica.Blocks.Interfaces.RealInput XPrescribed[Medium.nX] 
          annotation (extent=[-108,-54; -88,-32]);
        Modelica.Blocks.Interfaces.RealInput TPrescribed 
          annotation (extent=[-106,-4; -86,18]);
      equation 
        if cardinality(pPrescribed)==0 then
          medium.p = p_ambient;
          pPrescribed = 0;
        else
          medium.p = pPrescribed;
        end if;
        
        if cardinality(TPrescribed)==0 then
          medium.T = T_ambient;
          TPrescribed = 0;
        else
          medium.T = TPrescribed;
         end if;
        
        if cardinality(XPrescribed)==0 then
          medium.X_reduced = X_ambient[1:Medium.nX-1];
          XPrescribed = zeros(Medium.nX);
        else
          medium.X_reduced = XPrescribed[1:Medium.nX-1];
        end if;
      end Source;
      
      model Plenum "Plenum model with dynamic mass and energy balances" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Volume V "Volume";
        Medium.BaseProperties fluid "Fluid model";
        Mass M "Total mass";
        Mass MX_reduced[Medium.nX-1] "Independent partial masses of components";
        Energy U "Total internal energy";
        
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
          annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
          annotation (extent=[80,-10; 100,10]);
      equation 
        // Total quantities
        M=V*fluid.d;
        MX_reduced=M*fluid.X_reduced;
        U = M*fluid.u;
        
        // Balance equations
        der(M)=port_a.m_flow+port_b.m_flow;
        der(MX_reduced)=port_a.mX_flow_reduced+port_b.mX_flow_reduced;
        der(U)=port_a.H_flow+port_b.H_flow;
        
        // Boundary conditions
        port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
        port_a.mX_flow_reduced=semiLinear(port_a.m_flow,port_a.X_reduced,fluid.X_reduced);
        fluid.p=port_a.p;
        
        port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
        port_b.mX_flow_reduced=semiLinear(port_b.m_flow,port_b.X_reduced,fluid.X_reduced);
        fluid.p=port_b.p;
        
        annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=3,
                fillColor=3,
                rgbfillColor={0,0,255})), Text(
              extent=[-142,120; 144,76],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")),            Diagram);
      end Plenum;
      
      model PressureDrop "Nonlinear pressure drop" 
        import SI = Modelica.SIunits;
        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter Medium.AbsolutePressure dp_nominal "Nominal pressure drop";
        parameter Medium.Density d_nominal "Nominal density";
        parameter Medium.MassFlowRate m_flow_nominal 
          "Nominal mass flow rate at nominal pressure drop and nominal density";
        parameter SI.Pressure p_small = 1 
          "Pressure drop describing the small laminar region"                                 annotation(Dialog(tab="Advanced"));
        
        Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h) 
          "Medium properties in port_a";
        Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h) 
          "Medium properties in port_b";
        
        Medium.MassFlowRate m_flow = port_a.m_flow 
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        Medium.Density d "Upstream density";
        SI.Pressure dp "Pressure drop between port_a and port_b";
        
        Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
                                      annotation (extent=[-100,-10; -80,10]);
        Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
                                      annotation (extent=[80,-10; 100,10]);
        annotation (Icon(Rectangle(extent=[-80,32; 80,-34], style(
                color=3,
                rgbcolor={0,0,255},
                gradient=2,
                fillColor=3,
                rgbfillColor={0,0,255})),
                                Text(extent=[-130,100; 138,38], string="%name")),
                                           DymolaStoredErrors,
          Diagram);
      protected 
        parameter Real C1=0.5/sqrt(p_small) - 3*C3*p_small^2 
          "Coefficient 1 of cubic polynomial"                                                    annotation(Hide=true);
        parameter Real C3=-0.25/(sqrt(p_small)*p_small^2) 
          "Coefficient 3 of cubic polynomial"                                                 annotation(Hide=true);
        parameter Real k=dp_nominal/m_flow_nominal^2 annotation(Hide=true);
      equation 
        medium_a.X_reduced=port_a.X_reduced;
        medium_b.X_reduced=port_b.X_reduced;
        
        /* Quadratic flow characteristic:
     dp = d*xi*v^2/2,  v = m_flow/(d*A)
     dp = d*xi*m_flow^2/(2*d^2*A^2)
        = xi/(2*d*A^2)*m_flow^2
        = k*m_flow^2/d
      k = xi/(2*A^2)

      dp_nominal = k*m_flow_nominal^2/d_nominal
      k = dp_nominal*d_nominal/m_flow_nominal^2
      dp = dp_nominal*(d_nominal/d)*(m_flow/m_flow_nominal)^2
  */
        dp = port_a.p-port_b.p;
        d = if port_a.m_flow > 0 then medium_a.d else medium_b.d;
        m_flow = smooth(1,if dp >  p_small then  sqrt( dp*d/(dp_nominal*d_nominal)) else 
                         (if dp < -p_small then -sqrt(-dp*d/(dp_nominal*d_nominal)) else 
                         (C1 + C3*dp*dp)*dp*sqrt(d/(dp_nominal*d_nominal))))*m_flow_nominal;
        
        // Boundary conditions
        port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
        port_a.mX_flow_reduced= semiLinear(port_a.m_flow, port_a.X_reduced, port_b.X_reduced);
        
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mX_flow_reduced+ port_b.mX_flow_reduced= zeros(Medium.nX-1);
      end PressureDrop;
      
    model Reactor "Plenum model with dynamic mass and energy balances" 
      final package Medium = Media.GasMixture "Medium model";
      parameter Volume V "Volume";
      parameter Boolean chemicalEquilibrium=false 
          "if true then chemical equilibrium else complete combustion";
      parameter Real K=1e-12 "Chemical equilibrium constant";
      Medium.BaseProperties fluid "Fluid model";
      Medium.AbsolutePressure p(stateSelect=StateSelect.always) 
          "Fluid pressure";
      Medium.Temperature T(stateSelect=StateSelect.always) "Fluid temperature";
      Medium.MassFraction X[Medium.nX](each stateSelect=StateSelect.default);
      Mass M "Total mass";
      Mass MX[Medium.nX] "Partial mass of components";
      Energy U "Total internal energy";
      MassFlowRate CH4_burned "Flow rate of burned CH4";
      MassFlowRate O2_burned "Flow rate of burned O2";
      MassFlowRate H2O_created "Flow rate of created H2O";
      MassFlowRate CO2_created "Flow rate of created CO2";
        
      Interfaces.FluidPort_a port_a(redeclare package Medium=Medium) 
        annotation (extent=[-100,-10; -80,10]);
      Interfaces.FluidPort_b port_b(redeclare package Medium=Medium) 
        annotation (extent=[80,-10; 100,10]);
    equation 
      // Total quantities
      M=V*fluid.d;
      MX=M*fluid.X;
      U = M*fluid.u;
        
      // Balance equations
      der(M)=port_a.m_flow+port_b.m_flow;
        // Water
      der(MX[1])=port_a.mX_flow[1]+port_b.mX_flow[1]+H2O_created;
        // Oxygen
      der(MX[2])=port_a.mX_flow[2]+port_b.mX_flow[2]-O2_burned;
        // Methane
      der(MX[3])=port_a.mX_flow[3]+port_b.mX_flow[3]-CH4_burned;
        // Carbon dioxide
      der(MX[4])=port_a.mX_flow[4]+port_b.mX_flow[4]+CO2_created;
        // Nitrogen
      sum(MX)=M;
      der(U)=port_a.H_flow+port_b.H_flow+CH4_burned*51e6;
        
      // Stoichiometric relationships (CH4+2O2->CO2+2H2O)
      O2_burned = 2*CH4_burned*32/16;
      CO2_created = CH4_burned*44/16;
      H2O_created = 2*CH4_burned*18/16;
        
      // Combustion flow rate determination
      if chemicalEquilibrium then
        // chemical equilibrium conditions
        K = (X[3]*X[2]^2) / (X[4]*X[1]^2+1e-16);
      else
        // complete combustion
        X[3] = 0;
      end if;
      assert(X[2]>=0, "Insufficient oxygen to complete combustion");
        
      // Boundary conditions
      port_a.H_flow=semiLinear(port_a.m_flow,port_a.h,fluid.h);
      port_a.mX_flow=semiLinear(port_a.m_flow,port_a.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_a.p;
        
      port_b.H_flow=semiLinear(port_b.m_flow,port_b.h,fluid.h);
      port_b.mX_flow=semiLinear(port_b.m_flow,port_b.X,fluid.X[1:Medium.nX-1]);
      fluid.p=port_b.p;
        
      fluid.p=p;
      fluid.T=T;
      fluid.X=X;
        
      annotation (Icon(Ellipse(extent=[-80,80; 80,-80], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3,
              fillColor=3,
              rgbfillColor={0,0,255})), Text(
            extent=[-142,120; 144,76],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),            Diagram);
    end Reactor;
    end Components;
    
    package TestCases "Test cases for non-minimal connector components" 
      package BaseTests 
        partial model Test1 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-40,0; -20,20]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the right source pressure is changed sinusoidally, possibly causing flow reversal in some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.25) 
            annotation (extent=[-10,0; 10,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[44,0; 24,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[92,4; 72,24]);
        equation 
          connect(PressDrop.port_b, Source2.port) annotation (points=[9,10; 23,10],
              style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop.port_a) annotation (points=[-19,10; -9,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -52,50; -52,15; -39.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -62,20; -62,10.7; -39.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -60,-14; -60,5.7; -39.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y, Source2.pPrescribed) annotation (points=[
                71,14; 59.5,14; 59.5,15; 43.8,15], style(color=74, rgbcolor={0,0,
                  127}));
        end Test1;
        
        partial model Test2 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,40; -44,60]);
          annotation (Diagram,
            experiment(StopTime=8),
            Documentation(info="<html>
Testing of the basic component without mass or energy buildup, with three-way connections.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3. From time 5 onwards, the lower right source pressure is changed sinusoidally, possibly causing flow reversal in PressDrop3 and PressDrop4 during some time intervals.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            height=0.2e5,
            offset=1.5e5)                    annotation (extent=[-100,80; -80,100]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,40; -18,60]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[72,14; 52,34]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,50; -80,70]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,16; -80,36]);
          Modelica.Blocks.Sources.Sine DownstreamPressure(
            offset=1e5,
            startTime=5,
            amplitude=0.9e5) annotation (extent=[100,0; 80,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-12,40; 8,60]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=0.3e6,
            wnom=0.10) 
            annotation (extent=[22,60; 42,80]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=0.6e6,
            wnom=0.10) 
            annotation (extent=[22,14; 42,34]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[76,60; 56,80]);
        equation 
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,90;
                -70,90; -70,55; -63.8,55], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,60;
                -76,60; -76,50.7; -63.6,50.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,26;
                -72,26; -72,45.7; -63.8,45.7],style(color=74, rgbcolor={0,0,127}));
          connect(DownstreamPressure.y,Source3. pPrescribed) annotation (points=[79,
                10; 71.5,10; 71.5,29; 71.8,29],    style(color=74, rgbcolor={0,0,
                  127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,50;
                -37,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                50; -11,50], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop3.port_a) annotation (points=[7,50;
                12,50; 12,70; 23,70], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, PressDrop4.port_a) annotation (points=[7,50;
                12,50; 12,24; 23,24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source3.port) annotation (points=[41,24; 51,
                24], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, Source2.port) annotation (points=[41,70; 55,
                70], style(color=69, rgbcolor={0,127,255}));
        end Test2;
        annotation (Documentation(info=""));
        partial model Test3 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
             m_flow_nominal = 0.2,
            dp_nominal = 0.22e5,
            d_nominal = 1.75) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.05) 
            annotation (extent=[-10,0; 10,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            m_flow_nominal = 0.2,
            dp_nominal = 0.22e5,
            d_nominal = 1.75) 
            annotation (extent=[22,0; 42,20]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir.port_a) annotation (points=[-19,10;
                -9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop2.port_a) annotation (points=[9,10;
                23,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[41,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
        end Test3;
        
        partial model Test4 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Two reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
        end Test4;
        
        partial model Test5 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic component with mass and energy buildup. Three reservoirs are connected together to test index reduction.
<p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero once the perturbations have settled.
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.5e6) 
            annotation (extent=[-38,0; -18,20]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[82,0; 62,20]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir1(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[-14,0; 6,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.4e6) 
            annotation (extent=[34,0; 54,20]);
          Components.Plenum Reservoir2(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,0; 30,20]);
          Components.Source Source3(redeclare package Medium = Medium) 
            annotation (extent=[82,-36; 62,-16]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            wnom=0.25,
            K=0.2e6) 
            annotation (extent=[34,-36; 54,-16]);
          Components.Plenum Reservoir3(redeclare package Medium = Medium, V=0.025) 
            annotation (extent=[10,-36; 30,-16]);
        equation 
          Xerror = sum(Reservoir2.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(PressDrop1.port_b, Reservoir1.port_a) 
                                                       annotation (points=[-19,10;
                -13,10],style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[53,10; 61,
                10], style(color=69, rgbcolor={0,127,255}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -37,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir2.port_a) annotation (points=[5,10;
                11,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir2.port_b, PressDrop2.port_a) annotation (points=[29,10;
                35,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b,Source3. port) annotation (points=[53,-26; 61,
                -26],style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir3.port_b, PressDrop3.port_a) annotation (points=[29,
                -26; 35,-26], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir1.port_b, Reservoir3.port_a) annotation (points=[5,10;
                6,10; 6,-26; 11,-26], style(color=69, rgbcolor={0,127,255}));
        end Test5;
        
        partial model Test6 
          replaceable package Medium =  Modelica.Media.Interfaces.PartialMedium;
          constant Real[Medium.nX] XHeight;
          Medium.MassFraction Xerror "Residual=sum(X)-1";
          Components.Source Source1(redeclare package Medium = Medium) 
            annotation (extent=[-64,0; -44,20]);
          annotation (Diagram,
            experiment(StopTime=10),
            Documentation(info="<html>
Testing of the basic components with and without mass and energy buildup. <p>
Pressure, temperature, and composition of the left source are changed stepwise at time 1, 2, and 3.
<p>
Check Xerror = sum(Reservoir.fluid.X)-1: the error goes asymptotically to zero for t>25 .
</html>"));
          Modelica.Blocks.Sources.Step Pressure(
            startTime=1,
            offset=1.5e5,
            height=0.05e5)                   annotation (extent=[-100,40; -80,60]);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-38,2; -18,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[100,8; 80,28]);
          Modelica.Blocks.Sources.Step Temperature(
            offset=300,
            startTime=2,
            height=10)                       annotation (extent=[-100,10; -80,30]);
          Modelica.Blocks.Sources.Step Composition[Medium.nX](
            offset=Medium.reference_X,
            each startTime=3,
            height=XHeight)                  annotation (extent=[-100,-24; -80,-4]);
          Components.Plenum Reservoir(redeclare package Medium = Medium, V=0.1) 
            annotation (extent=[22,24; 42,44]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-8,24; 12,44]);
          Components.PressureDrop PressDrop3(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[6,-10; 26,10]);
          Components.PressureDrop PressDrop4(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[52,8; 72,28]);
        equation 
          Xerror = sum(Reservoir.fluid.X)-1;
          connect(Pressure.y, Source1.pPrescribed) annotation (points=[-79,50;
                -68,50; -68,15; -63.8,15], style(color=74, rgbcolor={0,0,127}));
          connect(Temperature.y, Source1.TPrescribed) annotation (points=[-79,20;
                -74,20; -74,10.7; -63.6,10.7], style(color=74, rgbcolor={0,0,127}));
          connect(Composition.y, Source1.XPrescribed) annotation (points=[-79,-14;
                -74,-14; -74,5.7; -63.8,5.7], style(color=74, rgbcolor={0,0,127}));
          connect(Source1.port, PressDrop1.port_a) annotation (points=[-43,10;
                -40,10; -40,12; -37,12],
                         style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop2.port_a) annotation (points=[-19,
                12; -14,12; -14,34; -7,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, PressDrop3.port_a) annotation (points=[-19,
                12; -14,12; -14,0; 7,0], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Reservoir.port_a) annotation (points=[11,34;
                23,34], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop4.port_b, Source2.port) annotation (points=[71,18; 79,
                18], style(color=69, rgbcolor={0,127,255}));
          connect(Reservoir.port_b, PressDrop4.port_a) annotation (points=[41,34;
                46,34; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop3.port_b, PressDrop4.port_a) annotation (points=[25,0;
                46,0; 46,18; 53,18], style(color=69, rgbcolor={0,127,255}));
        end Test6;
      end BaseTests;
      
      annotation (Documentation(info="<html>
Test cases for the basic mixture components: components with mass and energy dynamic balances (represented by <tt>Plenum</tt>), and possibly with chemical equilibrium reactions (represented by <tt>Reactor</tt>, as well as components with static balances (represented by <tt>PressureDrop</tt>).
<p>
Test are numbered progressively in each package. <tt>BaseTests</tt> contains the basic model with generic replaceable media, while the other packages redeclare a specific medium model in the test cases. <tt>TestReaction employs the gas mixture model to include chemical equilibrium equations in the <tt>Reactor</tt> model.
</html>"));
      
      package Tests_GasMixture 
        package TestMedium = Media.GasMixture;
        constant Real TestXHeight[TestMedium.nX]={0, 0.1, 0,0,-0.1};
        
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8));
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(medium_a(state(
                                T(      start=300))),medium_b(state(
                                                              T(      start=300)))),
            PressDrop2(medium_b(state(
                                T(      start=300))),medium_a(state(
                                                              T(      start=300)))));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X_reduced)=fill(0,Medium.nX-1);
          
          annotation (experiment(StopTime=8), Diagram);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.p)=0;
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8));
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop1(wnom=0.3),
            PressDrop2(wnom=0.3),
            PressDrop3(wnom=0.3));
        initial equation 
          der(Reservoir.fluid.p)=0;
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (Diagram);
        end Test6;
        
        model Test7 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Complete combustion is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=false) 
            annotation (extent=[8,0; 28,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 9,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[27,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test7;
        
        model Test8 
          replaceable package Medium = Media.GasMixture;
          constant Real XHeight[Medium.nX]=(Medium.reference_X+{0, 0, 0.05, 0, 0})/
                    sum(Medium.reference_X+{0, 0, 0.05, 0, 0})-
                    Medium.reference_X;
          Real Xerror;
          Components.Source Source1(redeclare package Medium = Medium, p_ambient=1.5e5) 
            annotation (extent=[-56,0; -36,20]);
          annotation (Diagram,
            experiment(StopTime=2),
            Documentation(info="<html>
Testing of the basic component with and energy buildup, and with chemical equilibria.
<p>
The initial flow is pure air. At time t=1, some methane is added to the source gas mixture, and combustion takes place in the reactor. Chemical equilibrium is assumed.
</html>"),  experimentSetupOutput);
          Components.PressureDrop PressDrop1(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[-26,2; -6,22]);
          Components.Source Source2(redeclare package Medium = Medium) 
            annotation (extent=[94,0; 74,20]);
          Components.Reactor Reactor1(V=0.01, chemicalEquilibrium=true) 
            annotation (extent=[6,0; 26,20]);
          Components.PressureDrop PressDrop2(
            redeclare package Medium = Medium,
            K=1e6,
            wnom=0.1) 
            annotation (extent=[40,0; 60,20]);
          Modelica.Blocks.Sources.Ramp Ramp1[Medium.nX](
            height=XHeight,
            offset=Medium.reference_X,
            each duration=0.01,
            each startTime=1) annotation (extent=[-100,22; -80,42]);
        equation 
        Xerror=sum(Reactor1.X)-1;
          connect(Source1.port, PressDrop1.port_a) 
                                                  annotation (points=[-35,10;
                -30,10; -30,12; -25,12],
                     style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop1.port_b, Reactor1.port_a) annotation (points=[-7,12;
                0,12; 0,10; 7,10], style(color=69, rgbcolor={0,127,255}));
          connect(Reactor1.port_b, PressDrop2.port_a) annotation (points=[25,10;
                41,10], style(color=69, rgbcolor={0,127,255}));
          connect(PressDrop2.port_b, Source2.port) annotation (points=[59,10;
                73,10], style(color=69, rgbcolor={0,127,255}));
          connect(Ramp1.y, Source1.XPrescribed) annotation (points=[-79,32; -68,
                32; -68,5.7; -55.8,5.7], style(color=74, rgbcolor={0,0,127}));
        initial equation 
          der(Reactor1.fluid.p)=0;
          der(Reactor1.fluid.T)=0;
          Reactor1.fluid.X[{1,2,5}]=Medium.reference_X[{1,2,5}];
        end Test8;
      end Tests_GasMixture;
      
      package Tests_LiquidMixture 
        package TestMedium=Media.LiquidMixture;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight,
            PressDrop2(wnom=0.05),
            PressDrop3(wnom=0.05),
            PressDrop1(wnom=0.05));
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          annotation (experiment(StopTime=8), experimentSetupOutput);
        end Test6;
      end Tests_LiquidMixture;
      
      package Tests_FunctionMedium 
        package TestMedium=Media.FunctionMedium;
        constant Real TestXHeight[TestMedium.nX]={0.1,-0.1,0};
        model Test1 
          extends BaseTests.Test1(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test1;
        
        model Test2 
          extends BaseTests.Test2(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        end Test2;
        
        model Test3 
          extends BaseTests.Test3(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test3;
        
        model Test4 
          extends BaseTests.Test4(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test4;
        
        model Test5 
          extends BaseTests.Test5(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir1.fluid.T)=0;
          der(Reservoir1.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir2.fluid.T)=0;
          der(Reservoir2.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
          der(Reservoir3.fluid.T)=0;
          der(Reservoir3.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test5;
        
        model Test6 
          extends BaseTests.Test6(
          redeclare package Medium = TestMedium,
          XHeight=TestXHeight);
        initial equation 
          der(Reservoir.fluid.T)=0;
          der(Reservoir.fluid.X[1:Medium.nX-1])=fill(0,Medium.nX-1);
        end Test6;
      end Tests_FunctionMedium;
    end TestCases;
    annotation (Documentation(info="<html>
This package test components with minimal connectors, i.e. with nX-1 mass fractions on the connector variables, and with reduced state vectors.
</html>"));
  end MinimalReducedV3;
  
  package Media "Media models" 
    
    package GasMixture "Gas mixture" 
    extends Modelica.Media.IdealGases.Common.MixtureGasNasa(mediumName="Gas Mixture",
         data={Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
        Modelica.Media.IdealGases.Common.SingleGasesData.O2,
        Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
        Modelica.Media.IdealGases.Common.SingleGasesData.N2},
        useMinimalX=false,
        substanceNames = {"Water","Oxygen","Methane","Carbon dioxide","Nitrogen"},
        reference_X={0,0.232,0,0,0.768});
    end GasMixture;
    
    package LiquidMixture "Fictitious liquid mixture for testing" 
      extends Modelica.Media.Interfaces.PartialMixtureMedium(
         mediumName="Fictitous Liquid Mixture",
         substanceNames={"Kryptene","Simulene","Hysteric Acid"},
         incompressible=true,
         reference_X={0.3, 0.3, 0.4},
         SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
         Density(start=1000, nominal=1000),
         AbsolutePressure(start=50e5, nominal=10e5),
         Temperature(start=300, nominal=300));
      
      constant Pressure p0=1e5 "Reference pressure";
      constant Temperature T0=293.15 "Reference temperature";
      constant SpecificHeatCapacity cp0[nX]={4000,2500,2000};
      constant Density rho0[nX]={1000,500,700};
      constant RelativePressureCoefficient beta[nX]={1e-3,3e-3,5e-3};
      constant SpecificEnthalpy h0[nX]=fill(0,nX);
      redeclare record extends ThermodynamicState 
        Temperature T;
        MassFraction X[nX];
      end ThermodynamicState;
      
      redeclare model extends BaseProperties "Base properties of medium" 
      equation 
        d = 1/sum(X[i]/(rho0[i]*(1-beta[i]*(T-T0))) for i in 1:nX);
        for i in 1:nX loop
          h_component[i] = (cp0[i]*(T-T0)+h0[i]);
        end for;
        h = sum(h_component*X);
        u = h;
        R=1;
        state.p=p;
        state.T=T;
        state.X=X;
        MM=0.1;
      end BaseProperties;
      
      model Test 
         BaseProperties prop;
      equation 
         prop.p=1e5;
         prop.T=300;
         prop.X={0.4,0.4,0.2};
      end Test;
      
      redeclare function extends heatCapacity_cp 
        "Return specific heat capacity at constant pressure" 
      algorithm 
        cp := sum(cp0[i]*state.X[i] for i in 1:nX);
      end heatCapacity_cp;
      
      redeclare function extends heatCapacity_cv 
        "Return specific heat capacity at constant volume" 
      algorithm 
        cv := sum(cp0[i]*state.X[i] for i in 1:nX);
      end heatCapacity_cv;
      
      redeclare function extends density_derT_p 
        "density derivative by specific enthalpy at const pressure" 
      algorithm 
        ddTp:=sum(-rho0[i]*beta[i]/cp0[i]*state.X[i] for i in 1:nX);
      end density_derT_p;
      
      redeclare function extends density_derp_T 
        "density derivative by pressure at const specific enthalpy" 
      algorithm 
        ddpT:=0;
      end density_derp_T;
      
      redeclare function extends density_derX 
        "density derivative by pressure at const specific enthalpy" 
      protected 
        Density dX[nX];
        Density d;
      algorithm 
        for i in 1:nX loop
          dX[i] := rho0[i]*(1-beta[i]*(state.T-T0));
        end for;
        d :=1/sum(state.X[i]/dX[i] for i in 1:nX);
        for i in 1:nX loop
          dddX[i]:=-d^2/dX[i];
        end for;
      end density_derX;
      
    end LiquidMixture;
    
    package FunctionMedium 
      "Fictitious liquid mixture with function-computed properties - emulates externally supplied media models" 
      
      extends Modelica.Media.Interfaces.PartialMixtureMedium(
         mediumName="Fictitous Liquid Mixture",
         substanceNames={"Kryptene","Simulene","Hysteric Acid"},
         incompressible=true,
         reference_X={0.3, 0.3, 0.4},
         SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
         Density(start=1000, nominal=1000),
         AbsolutePressure(start=50e5, nominal=10e5),
         Temperature(start=300, nominal=300));
      
      constant Pressure p0=1e5 "Reference pressure";
      constant Modelica.SIunits.Temperature T0=293.15 "Reference temperature";
      constant Modelica.SIunits.SpecificHeatCapacity cp0[nX]={4000,2500,2000};
      constant Modelica.SIunits.Density rho0[nX]={1000,500,700};
      constant RelativePressureCoefficient beta[nX]={1e-3,3e-3,5e-3};
      constant Modelica.SIunits.SpecificEnthalpy h0[nX]=fill(0, nX);
      redeclare record extends ThermodynamicState 
        Modelica.SIunits.Temperature T(start=300);
        Modelica.SIunits.MassFraction X[nX];
      end ThermodynamicState;
      
      redeclare model extends BaseProperties "Base properties of medium" 
      equation 
        d = f_density(T,X);
        for i in 1:nX loop
          h_component[i] = 0;
        end for;
        h = f_enthalpy(T,X);
        u = h;
        R=1;
        state.p=p;
        state.T=T;
        state.X=X;
        MM=0.1;
      end BaseProperties;
      
      model Test 
         BaseProperties prop;
      equation 
         prop.p=1e5;
         prop.T=300;
         prop.X={0.3,0.3,0.4};
      end Test;
      
      redeclare function extends heatCapacity_cp 
        "Return specific heat capacity at constant pressure" 
      algorithm 
        cp := sum(cp0[i]*state.X[i] for i in 1:nX);
      end heatCapacity_cp;
      
      redeclare function extends heatCapacity_cv 
        "Return specific heat capacity at constant volume" 
      algorithm 
        cv := sum(cp0[i]*state.X[i] for i in 1:nX);
      end heatCapacity_cv;
      
      redeclare function extends density_derT_p 
        "density derivative by specific enthalpy at const pressure" 
      algorithm 
        ddTp:=sum(-rho0[i]*beta[i]/cp0[i]*state.X[i] for i in 1:nX);
      end density_derT_p;
      
      redeclare function extends density_derp_T 
        "density derivative by pressure at const specific enthalpy" 
      algorithm 
        ddpT:=0;
      end density_derp_T;
      
      redeclare function extends density_derX 
        "density derivative by pressure at const specific enthalpy" 
      protected 
        Modelica.SIunits.Density dX[nX];
        Modelica.SIunits.Density d;
      algorithm 
        for i in 1:nX loop
          dX[i] := rho0[i]*(1-beta[i]*(state.T-T0));
        end for;
        d :=1/sum(state.X[i]/dX[i] for i in 1:nX);
        for i in 1:nX loop
          dddX[i]:=-d^2/dX[i];
        end for;
      end density_derX;
      
      function f_density 
        annotation(derivative=f_density_der);
        input Modelica.SIunits.Temperature T;
        input Modelica.SIunits.MassFraction X[nX];
        output Modelica.SIunits.Density d;
      algorithm 
        d := 1/sum(X[i]/(rho0[i]*(1-beta[i]*(T-T0))) for i in 1:nX);
      end f_density;
      
      function f_density_der 
        input Modelica.SIunits.Temperature T;
        input Modelica.SIunits.MassFraction X[nX];
        input Real T_der;
        input Real X_der[nX];
        output Modelica.SIunits.Density d_der;
      protected 
                  ThermodynamicState state;
      algorithm 
        state.T:=T;
        state.X:=X;
        state.p:=1e5;
        d_der := density_derT_p(state)*T_der+density_derX(state)*X_der;
      end f_density_der;
      
      function f_enthalpy 
        input Modelica.SIunits.Temperature T;
        input Modelica.SIunits.MassFraction X[nX];
        output Modelica.SIunits.SpecificEnthalpy h;
      protected 
        SpecificEnthalpy h_component[nX];
        annotation(derivative=f_enthalpy_der);
      algorithm 
        for i in 1:nX loop
          h_component[i] :=(cp0[i]*(T - T0) + h0[i]);
        end for;
        h:= sum(h_component*X);
      end f_enthalpy;
      
      function f_enthalpy_der 
        input Modelica.SIunits.Temperature T;
        input Modelica.SIunits.MassFraction X[nX];
        input Real T_der;
        input Real X_der[nX];
        output Modelica.SIunits.SpecificEnthalpy h_der;
        annotation(derivative=f_enthalpy_der);
      algorithm 
        h_der := sum((cp0[i]*(T-T0)+h0[i])*X_der[i] for i in 1:nX)+
                 sum(cp0[i]*X[i]*T_der for i in 1:nX);
        
      end f_enthalpy_der;
      
    end FunctionMedium;
    
  end Media;
end TestConnectors;

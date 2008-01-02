package MultiPhase "Library for electrical multiphase models" 
  extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains packages for electrical multiphase components, based on Modelica.Electrical.Analog:
<ul>
<li>Basic: basic components (resistor, capacitor, inductor, ...)</li>
<li>Ideal: ideal elements (switches, diode, transformer, ...)</li>
<li>Sensors: sensors to measure potentials, voltages, and currents</li>
<li>Sources: time-dependend and controlled voltage and current sources</li>
</ul>
This package is intended to be used the same way as Modelica.Electrical.Analog 
but to make design of multiphase models easier.<br>
The package is based on the plug: a composite connector containing m pins.<br>
It is possible to connect plugs to plugs or single pins of a plug to single pins.<br>
Potentials may be accessed as <tt>plug.pin[].v</tt>, currents may be accessed as <tt>plug.pin[].i</tt>.
</p>
<p>
Further development:
<ul>
<li>temperature-dependent resistor</li>
<li>lines (m-phase models)</li>
</ul>
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"), uses(Modelica(version="1.6")));
  
  package Basic "Basic components for electrical multiphase models" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains basic analog electrical multiphase components.
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model Star "Star-connection" 
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
        annotation (extent=[90, -10; 110, 10]);
      annotation (Icon(
          Text(extent=[-100, 50; 100, 99], string="%name"),
          Line(points=[80, 0; 0, 0], style(thickness=2, fillPattern=1)),
          Line(points=[0, 0; -39, 68], style(thickness=2, fillPattern=1)),
          Line(points=[0, 0; -38, -69], style(thickness=2, fillPattern=1)),
          Text(extent=[-100, -100; 100, -40], string="m=%m")), Documentation(
            info="<HTML>
<p>
Connects all pins of plug_p to pin_n, thus establishing a so-called star-connection.
</p>
</HTML>"));
    equation 
      for j in 1:m loop
        connect(plug_p.pin[j],pin_n);
      end for;
    end Star;
    
    model Delta "Delta (polygon) connection" 
      parameter Integer m(final min=2) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.NegativePlug plug_n(final m=m) 
        annotation (extent=[90, -10; 110, 10]);
      annotation (Icon(
          Text(extent=[-100, 50; 100, 99], string="%name"),
          Line(points=[-40, 68; -40, -70; 79, 0; -40, 68; -40, 67], style(
                thickness=2, fillPattern=1)),
          Text(extent=[-100, -100; 100, -40], string="m=%m")), Documentation(
            info="<HTML>
<p>
Connects in a cyclic way plug_n.pin[j] to plug_p.pin[j+1], 
thus establishing a so-called delta (or polygon) connection 
when used in parallel to another component.
</p>
</HTML>"));
    equation 
      for j in 1:m loop
        if j<m then
          connect(plug_n.pin[j],plug_p.pin [j+1]);
        else
          connect(plug_n.pin[j],plug_p.pin [1]);
        end if;
      end for;
    end Delta;
    
    model PlugToPin_p "Connect one (positive) Pin to a Plug Connector" 
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "phase index";
      Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
        annotation (extent=[90, -10; 110, 10]);
      annotation (
        Icon(
          Line(points=[-90, 0; 90, 0]),
          Text(extent=[-80, 80; 80, 20], string="%name"),
          Text(extent=[-80, -20; 80, -80], string="k = %k"),
          Polygon(points=[-100, 10; 90, 0; -100, -10; -100, 10], style(
              color=3,
              fillColor=3,
              fillPattern=1))),
        Documentation(info="<HTML>
<p>
Connects pin <i>k</i> of plug_p to pin_p, leaving the other pins of plug_p unconnected.
</p>
</HTML>"),
        Diagram);
    equation 
      pin_p.v = plug_p.pin[k].v;
      for j in 1:m loop
        plug_p.pin[j].i = if j == k then -pin_p.i else 0;
      end for;
    end PlugToPin_p;
    
    model PlugToPin_n "Connect one (negative) Pin to a Plug connector" 
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "phase index";
      Interfaces.NegativePlug plug_n(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
        annotation (extent=[92, -10; 112, 10]);
      annotation (Icon(
          Line(points=[-90, 0; 92, 0]),
          Text(extent=[-80, 80; 80, 20], string="%name"),
          Text(extent=[-80, -20; 80, -80], string="k = %k"),
          Polygon(points=[-100, 10; 92, 0; -100, -10; -100, 10], style(color=3))),
           Documentation(info="<HTML>
<p>
Connects pin <i>k</i> of plug_n to pin_n, leaving the other pins of plug_n unconnected.
</p>
</HTML>"));
    equation 
      pin_n.v = plug_n.pin[k].v;
      for j in 1:m loop
        plug_n.pin[j].i = if j == k then -pin_n.i else 0;
      end for;
    end PlugToPin_n;
    
    model Resistor "Ideal linear electrical resistors" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance R[m]=fill(1, m) "Resistance";
      Modelica.Electrical.Analog.Basic.Resistor resistor[m](final R=R) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Rectangle(extent=[-70, 30; 70, -30], style(
              color=3,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-90, 0; -70, 0]),
          Line(points=[70, 0; 90, 0]),
          Text(extent=[-100, 40; 100, 100], string="%name"),
          Text(extent=[-100, -100; 100, -40], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m resistors (Modelica.Electrical.Analog.Basic.Resistor)
</p>
</HTML>"),
        Diagram);
    equation 
      connect(resistor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(resistor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end Resistor;
    
    model Conductor "Ideal linear electrical conductors" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance G[m]=fill(1, m) "Conductance";
      Modelica.Electrical.Analog.Basic.Conductor conductor[m](final G=G) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Rectangle(extent=[-70, 30; 70, -30], style(
              color=3,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-90, 0; -70, 0]),
          Line(points=[70, 0; 90, 0]),
          Text(extent=[-100, 40; 100, 100], string="%name"),
          Text(extent=[-100, -100; 100, -40], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m conductors (Modelica.Electrical.Analog.Basic.Conductor)
</p>
</HTML>"),
        Diagram);
    equation 
      connect(plug_p.pin, conductor.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(plug_n.pin, conductor.n) 
        annotation (points=[100, 0; 10, 0], style(color=3));
    end Conductor;
    
    model Capacitor "Ideal linear electrical capacitors" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance C[m]=fill(1, m) "Capacitance";
      Modelica.Electrical.Analog.Basic.Capacitor capacitor[m](final C=C) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-100, 39; 100, 99], string="%name"),
          Line(points=[-14, 28; -14, -28], style(thickness=2)),
          Line(points=[14, 28; 14, -28], style(thickness=2)),
          Line(points=[-90, 0; -14, 0]),
          Line(points=[14, 0; 90, 0]),
          Text(extent=[-100, -100; 100, -40], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m capacitors (Modelica.Electrical.Analog.Basic.Capacitor)
</p>
</HTML>"),
        Diagram);
    equation 
      connect(capacitor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(capacitor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end Capacitor;
    
    model Inductor "Ideal linear electrical inductors" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance L[m]=fill(1, m) "Inductance";
      Modelica.Electrical.Analog.Basic.Inductor inductor[m](final L=L) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Ellipse(extent=[-60, -15; -30, 15]),
          Ellipse(extent=[-30, -15; 0, 15]),
          Ellipse(extent=[0, -15; 30, 15]),
          Ellipse(extent=[30, -15; 60, 15]),
          Rectangle(extent=[-60, -30; 60, 0], style(color=7, fillColor=7)),
          Line(points=[60, 0; 90, 0]),
          Line(points=[-90, 0; -60, 0]),
          Text(extent=[-100, 40; 100, 100], string="%name"),
          Text(extent=[-100, -100; 100, -40], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m inductors (Modelica.Electrical.Analog.Basic.Inductor)
</p>
</HTML>"),
        Diagram);
    equation 
      connect(inductor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(inductor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end Inductor;
    
    model SaturatingInductor "Simple model of inductors with saturation" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current Inom[m]=fill(1,m) "Nominal current";
      parameter Modelica.SIunits.Inductance Lnom[m]=fill(1,m) 
        "Nominal inductance at Nominal current";
      parameter Modelica.SIunits.Inductance Lzer[m]={2*Lnom[j] for j in 1:m} 
        "Inductance near current=0";
      parameter Modelica.SIunits.Inductance Linf[m]={Lnom[j]/2 for j in 1:m} 
        "Inductance at large currents";
      Modelica.Electrical.Analog.Basic.SaturatingInductor saturatingInductor[m](
        final Inom=Inom,
        final Lnom=Lnom,
        final Lzer=Lzer,
        final Linf=Linf) 
        annotation (extent=[-10,-10; 10,10]);
      annotation (Icon(
          Ellipse(extent=[-60,-15; -30,15]),
          Ellipse(extent=[-30,-15; 0,15]),
          Ellipse(extent=[0,-15; 30,15]),
          Ellipse(extent=[30,-15; 60,15]),
          Rectangle(extent=[-60,-20; 60,0],   style(color=7, fillColor=7)),
          Line(points=[60,0; 90,0]),
          Line(points=[-90,0; -60,0]),
          Rectangle(extent=[-60,-10; 60,-20], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3,
              fillColor=3,
              rgbfillColor={0,0,255})),
          Text(extent=[-100,40; 100,100],   string="%name"),
          Text(extent=[-100,-100; 100,-40],   string="m=%m")), Documentation(
            info="<HTML>
<p>
Contains m saturating inductors (Modelica.Electrical.Analog.Basic.SaturatingInductor)
</p>
<p>
<b>Attention!!!</b><br>
Each element of the array of saturatingInductors is only dependent on the current flowing through this element.
</p>
</HTML>"));
    equation 
      connect(saturatingInductor.p, plug_p.pin) 
        annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
      connect(saturatingInductor.n, plug_n.pin) 
        annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    end SaturatingInductor;
    
    model Transformer "Multiphase Transformer" 
      extends Interfaces.FourPlug;
      parameter Modelica.SIunits.Inductance L1[m]=fill(1, m) 
        "Primary inductance";
      parameter Modelica.SIunits.Inductance L2[m]=fill(1, m) 
        "Secondary inductance";
      parameter Modelica.SIunits.Inductance M[m]=fill(1, m) 
        "Coupling inductance";
      Modelica.Electrical.Analog.Basic.Transformer transformer[m](
        final L1=L1,
        final L2=L2,
        final M=M) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Ellipse(extent=[-45, -50; -20, -25]),
          Ellipse(extent=[-45, -25; -20, 0]),
          Ellipse(extent=[-45, 0; -20, 25]),
          Ellipse(extent=[-45, 25; -20, 50]),
          Rectangle(extent=[-72, -60; -33, 60], style(color=7, fillColor=7)),
          Line(points=[-90, 50; -32, 50]),
          Line(points=[-90, -50; -32, -50]),
          Ellipse(extent=[20, -50; 45, -25]),
          Ellipse(extent=[20, -25; 45, 0]),
          Ellipse(extent=[20, 0; 45, 25]),
          Ellipse(extent=[20, 25; 45, 50]),
          Rectangle(extent=[33, -60; 72, 60], style(color=7, fillColor=7)),
          Line(points=[32, 50; 90, 50]),
          Line(points=[32, -50; 90, -50]),
          Text(extent=[-100, 20; -58, -20], string="L1"),
          Text(extent=[60, 20; 100, -20], string="L2"),
          Text(extent=[-20, 20; 20, -20], string="M"),
          Text(extent=[-80, 60; 80, 100], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m transformers (Modelica.Electrical.Analog.Basic.Transformer)
</p>
</HTML>"),
        Diagram);
    equation 
      
      connect(plug_p1.pin, transformer.p1) annotation (points=[-100, 100; -10,
            100; -10, 5], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(plug_p2.pin, transformer.p2) annotation (points=[100, 100; 10,
            100; 10, 5], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(plug_n1.pin, transformer.n1) annotation (points=[-100, -100; -10,
             -100; -10, -5], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(plug_n2.pin, transformer.n2) annotation (points=[100, -100; 10, -100;
             10, -5], style(
          color=3,
          fillColor=7,
          fillPattern=1));
    end Transformer;
    
    model VariableResistor 
      "Ideal linear electrical resistors with variable resistance" 
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.InPort R_Port(final n=m) 
        annotation (extent=[-10,90; 10,110],   rotation=-90);
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor[m] 
        annotation (extent=[-10,-10; 10,10]);
      annotation (Icon(
          Line(points=[-90,0; -70,0]),
          Rectangle(extent=[-70,30; 70,-30],   style(
              color=3,
              fillColor=7,
              fillPattern=1)),
          Line(points=[70,0; 90,0]),
          Line(points=[0,90; 0,30],   style(color=73)),
          Text(extent=[-100,-100; 100,-40], string="%name"),
          Text(extent=[-100,40; 100,100],     string="m=%m")), Documentation(info="<HTML>
<p>
Contains m variable resistors (Modelica.Electrical.Analog.Basic.VariableResistor)
</p>
<P>
<b>Attention!!!</b><br>
  It is recomended that none of the R_Port signals should not cross the zero value. 
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</P>
</HTML>"),
        Diagram);
    equation 
      variableResistor.R_Port.signal[1]=R_Port.signal;
      connect(variableResistor.p, plug_p.pin) annotation (points=[-10,0; -100,0],
          style(color=3, rgbcolor={0,0,255}));
      connect(variableResistor.n, plug_n.pin) 
        annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    end VariableResistor;
    
    model VariableConductor 
      "Ideal linear electrical conductors with variable conductance" 
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.InPort G_Port(final n=m) 
        annotation (extent=[-10,90; 10,110],   rotation=-90);
      Modelica.Electrical.Analog.Basic.VariableConductor variableConductor[m] 
        annotation (extent=[-10,-10; 10,10]);
      annotation (Icon(
          Line(points=[-90,0; -70,0]),
          Rectangle(extent=[-70,30; 70,-30],   style(
              color=3,
              fillColor=7,
              fillPattern=1)),
          Line(points=[70,0; 90,0]),
          Line(points=[0,90; 0,30],   style(color=73)),
          Text(extent=[-100,-100; 100,-40], string="%name"),
          Text(extent=[-100,40; 100,100],     string="m=%m")), Documentation(info="<HTML>
<p>
Contains m variable conductors (Modelica.Electrical.Analog.Basic.VariableConductor)
</p>
<P>
<b>Attention!!!</b><br>
  It is recomended that none of the G_Port signals should not cross the zero value. 
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</P>
</HTML>"),
        Diagram);
    equation 
      variableConductor.G_Port.signal[1]=G_Port.signal;
      connect(variableConductor.p, plug_p.pin) 
        annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
      connect(variableConductor.n, plug_n.pin) 
        annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    end VariableConductor;
    
    model VariableCapacitor 
      "Ideal linear electrical capacitors with variable capacitance" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance Cmin[m]=fill(Modelica.Constants.eps,m);
      Modelica.Blocks.Interfaces.InPort C_Port(final n=m) 
        annotation (extent=[-10,90; 10,110],   rotation=-90);
      Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor[m](final Cmin
          =    Cmin) 
        annotation (extent=[-10,-10; 10,10]);
      annotation (Icon(
          Line(points=[0,90; 0,30],   style(color=73)),
          Text(extent=[-100,-100; 100,-40], string="%name"),
          Text(extent=[-100,40; 100,100],     string="m=%m"),
          Line(points=[-90,0; -14,0]),
          Line(points=[14,0; 90,0]),
          Line(points=[-14,28; -14,-28],   style(thickness=2)),
          Line(points=[14,28; 14,-28],   style(thickness=2))), Documentation(info="<HTML>
<p>
Contains m variable capacitors (Modelica.Electrical.Analog.Basic.VariableCapacitor)
</p>
<P>
It is required that each C_Port.signal &ge; 0, otherwise an 
assertion is raised. To avoid a variable index system,<br>
C = Cmin, if 0 &le; C_Port.signal &lt; Cmin, where
Cmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>"),
        Diagram);
    equation 
      variableCapacitor.C_Port.signal[1]=C_Port.signal;
      connect(variableCapacitor.p, plug_p.pin) 
        annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
      connect(variableCapacitor.n, plug_n.pin) 
        annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    end VariableCapacitor;
    
    model VariableInductor 
      "Ideal linear electrical inductors with variable inductance" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance Lmin[m]=fill(Modelica.Constants.eps,m);
      Modelica.Blocks.Interfaces.InPort L_Port(final n=m) 
        annotation (extent=[-10,90; 10,110],   rotation=-90);
      Modelica.Electrical.Analog.Basic.VariableInductor variableInductor[m](final Lmin
          =    Lmin) 
        annotation (extent=[-10,-10; 10,10]);
      annotation (Icon(
          Text(extent=[-100,-100; 100,-40], string="%name"),
          Text(extent=[-100,40; 100,100],     string="m=%m"),
          Line(points=[-90,0; -60,0]),
          Line(points=[60,0; 90,0]),
          Line(points=[0,90; 0,8],   style(color=73)),
          Ellipse(extent=[-60,-15; -30,15]),
          Ellipse(extent=[-30,-15; 0,15]),
          Ellipse(extent=[0,-15; 30,15]),
          Ellipse(extent=[30,-15; 60,15]),
          Rectangle(extent=[-60,-30; 60,0],   style(color=7, fillColor=7))),
                                                               Documentation(info="<HTML>
<p>
Contains m variable inductors (Modelica.Electrical.Analog.Basic.VariableInductor)
</p>
<P>
It is required that each L_Port.signal &ge; 0, otherwise an 
assertion is raised. To avoid a variable index system,<br>
L = Lmin, if 0 &le; L_Port.signal &lt; Lmin, where
Lmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>"),
        Diagram);
    equation 
      variableInductor.L_Port.signal[1]=L_Port.signal;
      connect(variableInductor.p, plug_p.pin) 
        annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
      connect(variableInductor.n, plug_n.pin) 
        annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    end VariableInductor;
  end Basic;
  
  package Examples "Multiphase test examples" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains test examples of analog electrical multiphase circuits.
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model TransformerYY "Test example with multiphase components" 
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance LT=0.003 
        "Transformer stray inductance";
      parameter Modelica.SIunits.Resistance RT=0.05 "Transformer resistance";
      parameter Modelica.SIunits.Resistance RL=1 "Load Resistance";
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-Y-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</HTML>"), Diagram);
      Sources.SineVoltage SineVoltage1(
        V=fill(V, m),
        freqHz=fill(f, m),
        m=m) annotation (extent=[-90, 10; -70, 30], rotation=-180);
      Basic.Star StarS1(m=m) 
        annotation (extent=[-100, -72; -80, -52], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundS1 
        annotation (extent=[-100, -100; -80, -80]);
      Ideal.IdealTransformer IdealTransformer1(m=m) 
        annotation (extent=[-40, 0; -20, 20]);
      Basic.Star StarT1(m=m) 
        annotation (extent=[-50, -72; -30, -52], rotation=-90);
      Basic.Star StarT2(m=m) 
        annotation (extent=[-30, -72; -10, -52], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundT2 
        annotation (extent=[-30, -100; -10, -80]);
      Basic.Resistor RT1(m=m, R=fill(RT, m)) annotation (extent=[0, 10; 20, 30]);
      Basic.Inductor LT1(m=m, L=fill(LT, m)) 
        annotation (extent=[30, 10; 50, 30]);
      Basic.Resistor RL1(m=m, R=fill(RL, m)) 
        annotation (extent=[70, 10; 90, 30], rotation=0);
      Basic.Star StarL1(m=m) 
        annotation (extent=[80, -72; 100, -52], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundT1 
        annotation (extent=[-50, -100; -30, -80]);
    equation 
      connect(StarS1.pin_n, GroundS1.p) 
        annotation (points=[-90, -72; -90, -80], style(color=3));
      connect(StarT1.pin_n, GroundT1.p) 
        annotation (points=[-40, -72; -40, -72; -40, -80], style(color=3));
      connect(StarT2.pin_n, GroundT2.p) 
        annotation (points=[-20, -72; -20, -80], style(color=3));
      connect(StarS1.plug_p, SineVoltage1.plug_n) 
        annotation (points=[-90, -52; -90, 20; -90, 20], style(color=3));
      connect(SineVoltage1.plug_p, IdealTransformer1.plug_p1) 
        annotation (points=[-70, 20; -40, 20], style(color=3));
      connect(IdealTransformer1.plug_n1, StarT1.plug_p) 
        annotation (points=[-40, 0; -40, -52], style(color=3));
      connect(StarT2.plug_p, IdealTransformer1.plug_n2) 
        annotation (points=[-20, -52; -20, 0], style(color=3));
      connect(IdealTransformer1.plug_p2, RT1.plug_p) 
        annotation (points=[-20, 20; 0, 20], style(color=3));
      connect(RT1.plug_n, LT1.plug_p) 
        annotation (points=[20, 20; 30, 20], style(color=3));
      connect(LT1.plug_n, RL1.plug_p) 
        annotation (points=[50, 20; 70, 20], style(color=3));
      connect(RL1.plug_n, StarL1.plug_p) 
        annotation (points=[90, 20; 90, -52], style(color=3));
    end TransformerYY;
    
    model TransformerYD "Test example with multiphase components" 
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance LT=0.003 
        "Transformer stray inductance";
      parameter Modelica.SIunits.Resistance RT=0.05 "Transformer resistance";
      parameter Modelica.SIunits.Resistance RL=1 "Load Resistance";
      parameter Real nT=1/sqrt((1 - Modelica.Math.cos(2*Modelica.Constants.pi/m))
          ^2 + (Modelica.Math.sin(2*Modelica.Constants.pi/m))^2) 
        "Transformer ratio";
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-D-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</HTML>"), Diagram);
      Sources.SineVoltage SineVoltage1(
        V=fill(V, m),
        freqHz=fill(f, m),
        m=m) annotation (extent=[-90, 10; -70, 30], rotation=-180);
      Basic.Star StarS1(m=m) 
        annotation (extent=[-100, -72; -80, -52], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundS1 
        annotation (extent=[-100, -100; -80, -80]);
      Ideal.IdealTransformer IdealTransformer1(m=m, n=fill(nT, m)) 
        annotation (extent=[-40, 0; -20, 20]);
      Basic.Star StarT1(m=m) 
        annotation (extent=[-50, -72; -30, -52], rotation=-90);
      Basic.Delta Delta1(m=m) annotation (extent=[60, 0; 40, 20], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundT1 
        annotation (extent=[-50, -100; -30, -80]);
      Basic.Resistor RT1(m=m, R=fill(RT/nT^2, m)) 
        annotation (extent=[-10, 10; 10, 30]);
      Basic.Inductor LT1(m=m, L=fill(LT/nT^2, m)) 
        annotation (extent=[20, 10; 40, 30]);
      Basic.Resistor RL1(m=m, R=fill(RL, m)) 
        annotation (extent=[70, 10; 90, 30], rotation=0);
      Basic.Star StarL1(m=m) 
        annotation (extent=[80, -72; 100, -52], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundL1 
        annotation (extent=[80, -100; 100, -80]);
    equation 
      connect(GroundS1.p, StarS1.pin_n) 
        annotation (points=[-90, -80; -90, -72], style(color=3));
      connect(GroundT1.p, StarT1.pin_n) 
        annotation (points=[-40, -80; -40, -72], style(color=3));
      connect(StarS1.plug_p, SineVoltage1.plug_n) 
        annotation (points=[-90, -52; -90, 20; -90, 20], style(color=3));
      connect(SineVoltage1.plug_p, IdealTransformer1.plug_p1) 
        annotation (points=[-70, 20; -40, 20], style(color=3));
      connect(IdealTransformer1.plug_n1, StarT1.plug_p) 
        annotation (points=[-40, 0; -40, -52], style(color=3));
      connect(IdealTransformer1.plug_p2, RT1.plug_p) 
        annotation (points=[-20, 20; -10, 20], style(color=3));
      connect(RT1.plug_n, LT1.plug_p) 
        annotation (points=[10, 20; 20, 20], style(color=3));
      connect(LT1.plug_n, Delta1.plug_p) 
        annotation (points=[40, 20; 50, 20], style(color=3));
      connect(Delta1.plug_n, IdealTransformer1.plug_n2) 
        annotation (points=[50, 0; -20, 0], style(color=3));
      connect(Delta1.plug_p, RL1.plug_p) 
        annotation (points=[50, 20; 70, 20], style(color=3));
      connect(RL1.plug_n, StarL1.plug_p) 
        annotation (points=[90, 20; 90, -52; 90, -52], style(color=3));
      connect(StarL1.pin_n, GroundL1.p) 
        annotation (points=[90, -72; 90, -80], style(color=3));
    end TransformerYD;
    
    model Rectifier "Test example with multiphase components" 
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance L=0.001 "Line Inductance";
      parameter Modelica.SIunits.Resistance RL=2 "Load Resistance";
      parameter Modelica.SIunits.Capacitance C=0.05 "Total DC-Capacitance";
      parameter Modelica.SIunits.Resistance RE=1E6 "Earthing Resistance";
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a line reactor a diode bridge rectifier with a DC burden.<br>
Using f=5 Hz, simulate for 1 second (2 periods) and compare voltages and currents of source and DC burden, 
neglecting initial transient.
</p>
</HTML>"), Diagram);
      Sources.SineVoltage SineVoltage1(
        m=m,
        V=fill(V, m),
        freqHz=fill(f, m)) annotation (extent=[-70, -10; -90, 10]);
      Basic.Star StarS(m=m) 
        annotation (extent=[-100, -60; -80, -40], rotation=-90);
      Basic.Inductor L1(m=m, L=fill(L, m)) 
        annotation (extent=[-52, -10; -32, 10]);
      Ideal.IdealDiode IdealDiode1(m=m) 
        annotation (extent=[0, 10; 20, 30], rotation=90);
      Basic.Star Star1(m=m) annotation (extent=[0, 40; 20, 60], rotation=90);
      Ideal.IdealDiode IdealDiode2(m=m) 
        annotation (extent=[0, -30; 20, -10], rotation=90);
      Basic.Star Star2(m=m) annotation (extent=[0, -60; 20, -40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor RLoad(R=RL) 
        annotation (extent=[40, -10; 60, 10], rotation=-90);
      Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=2*C) 
        annotation (extent=[60, 20; 80, 40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Capacitor Capacitor2(C=2*C) 
        annotation (extent=[60, -40; 80, -20], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground GroundDC 
        annotation (extent=[80, -80; 100, -60]);
    equation 
      connect(Capacitor1.n, Capacitor2.p) 
        annotation (points=[70, 20; 70, -20], style(color=3));
      connect(Capacitor1.n, GroundDC.p) 
        annotation (points=[70, 20; 70, 0; 90, 0; 90, -60], style(color=3));
      connect(StarS.plug_p, SineVoltage1.plug_n) 
        annotation (points=[-90, -40; -90, 0], style(color=3));
      connect(SineVoltage1.plug_p, L1.plug_p) 
        annotation (points=[-70, 0; -52, 0], style(color=3));
      connect(IdealDiode1.plug_p, L1.plug_n) 
        annotation (points=[10, 10; 10, 0; -32, 0], style(color=3));
      connect(IdealDiode2.plug_n, L1.plug_n) 
        annotation (points=[10, -10; 10, 0; -32, 0], style(color=3));
      connect(IdealDiode1.plug_n, Star1.plug_p) 
        annotation (points=[10, 30; 10, 40], style(color=3));
      connect(IdealDiode2.plug_p, Star2.plug_p) 
        annotation (points=[10, -30; 10, -40], style(color=3));
      connect(Star2.pin_n, RLoad.n) 
        annotation (points=[10, -60; 50, -60; 50, -10], style(color=3));
      connect(Star2.pin_n, Capacitor2.n) 
        annotation (points=[10, -60; 70, -60; 70, -40], style(color=3));
      connect(Star1.pin_n, RLoad.p) 
        annotation (points=[10, 60; 50, 60; 50, 10], style(color=3));
      connect(Star1.pin_n, Capacitor1.p) 
        annotation (points=[10, 60; 70, 60; 70, 40], style(color=3));
    end Rectifier;
  end Examples;
  
  package Ideal "Multiphase components with idealized behaviour" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains analog electrical multiphase components with idealized behaviour, 
like thyristor, diode, switch, transformer.
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model IdealThyristor "Multiphase ideal thyristor" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Roff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Gon[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m)) = zeros(m) 
        "Treshold voltage";
      Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=m) 
        annotation (extent=[60, 90; 80, 110], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor[m](final Roff
          =    Roff, final Gon=Gon, final Vknee=Vknee) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Line(points=[-90, 0; 40, 0]),
          Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
              color=3,
              gradient=0,
              fillColor=7)),
          Line(points=[30, 40; 30, -40], style(color=3)),
          Line(points=[40, 0; 90, 0]),
          Line(points=[40, 50; 60, 30]),
          Line(points=[30, 20; 70, 60; 70, 90]),
          Text(extent=[-100, 100; 60, 60], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor).
</p>
</HTML>"),
        Diagram);
    equation 
      idealThyristor.firePort.signal[1] = firePort.signal;
      connect(plug_p.pin, idealThyristor.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(idealThyristor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end IdealThyristor;
    
    model IdealGTOThyristor "Multiphase ideal GTO thyristor" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Roff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Gon[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m)) = zeros(m) 
        "Treshold voltage";
      Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=m) 
        annotation (extent=[60, 90; 80, 110], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor[m](
          final Roff=Roff, final Gon=Gon, final Vknee=Vknee) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Line(points=[-90, 0; 40, 0]),
          Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
              color=3,
              gradient=0,
              fillColor=7)),
          Line(points=[30, 40; 30, -40], style(color=3)),
          Line(points=[40, 0; 90, 0]),
          Line(points=[40, 50; 60, 30]),
          Line(points=[30, 20; 70, 60; 70, 90]),
          Text(extent=[-100, 100; 60, 60], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m ideal GTO thyristors (Modelica.Electrical.Analog.Ideal.IdealGTOThyristor).
</p>
</HTML>"),
        Diagram);
    equation 
      idealGTOThyristor.firePort.signal[1] = firePort.signal;
      connect(idealGTOThyristor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(idealGTOThyristor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end IdealGTOThyristor;
    
    model IdealCommutingSwitch "Multiphase ideal commuting switch" 
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened switch conductance";
      Modelica.Blocks.Interfaces.BooleanInPort control(final n=m) 
        annotation (extent=[-10, 88; 10, 108], rotation=-90);
      Interfaces.PositivePlug plug_p(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.NegativePlug plug_n2(final m=m) 
        annotation (extent=[90, -10; 110, 10]);
      Interfaces.NegativePlug plug_n1(final m=m) 
        annotation (extent=[90, 40; 110, 60]);
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch 
        idealCommutingSwitch[m](final Ron=Ron, final Goff=Goff) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Text(
            extent=[-100, 100; -20, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m="),
          Text(
            extent=[20, 100; 100, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="%m"),
          Ellipse(extent=[-44, 4; -36, -4]),
          Line(points=[-90, 0; -44, 0]),
          Line(points=[-37, 2; 40, 50]),
          Line(points=[40, 50; 90, 50]),
          Line(points=[0, 90; 0, 25]),
          Line(points=[40, 0; 90, 0])),
        Documentation(info="<HTML>
<p>
Contains m ideal commuting switches (Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch).
</p>
</HTML>"),
        Diagram);
    equation 
      idealCommutingSwitch.control.signal[1] = control.signal;
      connect(plug_p.pin, idealCommutingSwitch.p) annotation (points=[-100, 0;
            -10, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idealCommutingSwitch.n2, plug_n2.pin) annotation (points=[10, 0;
            100, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idealCommutingSwitch.n1, plug_n1.pin) annotation (points=[10, 5;
            10, 50; 100, 50], style(
          color=3,
          fillColor=7,
          fillPattern=1));
    end IdealCommutingSwitch;
    
    model IdealIntermediateSwitch "Multiphase ideal intermediate switch" 
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened switch conductance";
      Modelica.Blocks.Interfaces.BooleanInPort control(final n=m) 
        annotation (extent=[-10, 88; 10, 108], rotation=-90);
      Interfaces.PositivePlug plug_p1(final m=m) 
        annotation (extent=[-110, 40; -90, 60]);
      Interfaces.PositivePlug plug_p2(final m=m) 
        annotation (extent=[-110, -10; -90, 10]);
      Interfaces.NegativePlug plug_n2(final m=m) 
        annotation (extent=[90, -10; 110, 10]);
      Interfaces.NegativePlug plug_n1(final m=m) 
        annotation (extent=[90, 40; 110, 60]);
      Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch 
        idealIntermediateSwitch[m](final Ron=Ron, final Goff=Goff) 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Text(
            extent=[-100, 100; -20, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m="),
          Text(
            extent=[20, 100; 100, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="%m"),
          Ellipse(extent=[-4, 30; 4, 22]),
          Line(points=[-90, 0; -44, 0]),
          Line(points=[-90, 50; -44, 50]),
          Line(points=[-44, 0; 40, 50]),
          Line(points=[-44, 50; 40, 0]),
          Line(points=[40, 50; 90, 50]),
          Line(points=[0, 90; 0, 25]),
          Line(points=[40, 0; 90, 0])),
        Documentation(info="<HTML>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch).
</p>
</HTML>"),
        Diagram);
    equation 
      idealIntermediateSwitch.control.signal[1] = control.signal;
      connect(plug_p2.pin, idealIntermediateSwitch.p2) annotation (points=[-100,
             0; -10, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idealIntermediateSwitch.n2, plug_n2.pin) annotation (points=[10,
            0; 100, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idealIntermediateSwitch.p1, plug_p1.pin) annotation (points=[-10,
             5; -10, 50; -100, 50], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idealIntermediateSwitch.n1, plug_n1.pin) annotation (points=[10,
            5; 10, 50; 100, 50], style(
          color=3,
          fillColor=7,
          fillPattern=1));
    end IdealIntermediateSwitch;
    
    model IdealDiode "Multiphase ideal diode" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Roff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed diode resistance";
      parameter Modelica.SIunits.Conductance Gon[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened diode conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m)) = zeros(m) 
        "Treshold voltage";
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode[m](final Roff=Roff,
           final Gon=Gon, final Vknee=Vknee) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Line(points=[-90, 0; 40, 0]),
          Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
              color=3,
              gradient=0,
              fillColor=7)),
          Line(points=[30, 40; 30, -40], style(color=3)),
          Line(points=[40, 0; 90, 0]),
          Text(extent=[-100, 100; 60, 60], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m ideal diodes (Modelica.Electrical.Analog.Ideal.IdealDiode).
</p>
</HTML>"),
        Diagram);
    equation 
      connect(plug_p.pin, idealDiode.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(idealDiode.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end IdealDiode;
    
    model IdealTransformer "Multiphase ideal transformer" 
      extends Interfaces.FourPlug;
      parameter Real n[m]=fill(1, m) "Turns ratio";
      Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer[m](
          final n=n) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Ellipse(extent=[-45, -50; -20, -25]),
          Ellipse(extent=[-45, -25; -20, 0]),
          Ellipse(extent=[-45, 0; -20, 25]),
          Ellipse(extent=[-45, 25; -20, 50]),
          Rectangle(extent=[-72, -60; -33, 60], style(color=7, fillColor=7)),
          Line(points=[-90, 50; -32, 50]),
          Line(points=[-90, -50; -32, -50]),
          Ellipse(extent=[20, -50; 45, -25]),
          Ellipse(extent=[20, -25; 45, 0]),
          Ellipse(extent=[20, 0; 45, 25]),
          Ellipse(extent=[20, 25; 45, 50]),
          Rectangle(extent=[33, -60; 72, 60], style(color=7, fillColor=7)),
          Line(points=[32, 50; 90, 50]),
          Line(points=[32, -50; 90, -50]),
          Text(extent=[-80, 100; 80, 60], string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m ideal transformers (Modelica.Electrical.Analog.Ideal.IdealTransformer).
</p>
</HTML>"),
        Diagram);
    equation 
      connect(plug_p1.pin, idealTransformer.p1) 
        annotation (points=[-100, 100; -10, 100; -10, 5], style(color=3));
      connect(plug_p2.pin, idealTransformer.p2) 
        annotation (points=[100, 100; 10, 100; 10, 5], style(color=3));
      connect(plug_n1.pin, idealTransformer.n1) 
        annotation (points=[-100, -100; -10, -100; -10, -5], style(color=3));
      connect(plug_n2.pin, idealTransformer.n2) 
        annotation (points=[100, -100; 10, -100; 10, -5], style(color=3));
    end IdealTransformer;
    
    model Idle "Multiphase idle branch" 
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Idle idle[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-100, 50; 100, 110], string="%name"),
          Text(extent=[-100, -110; 100, -50], string="m=%m"),
          Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)),
          Line(points=[-90, 0; -41, 0]),
          Line(points=[91, 0; 40, 0])),
        Documentation(info="<HTML>
<p>
Contains m idles (Modelica.Electrical.Analog.Ideal.Idle)
</p>
</HTML>"),
        Diagram);
    equation 
      
      connect(plug_p.pin, idle.p) annotation (points=[-100, 0; -10, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(idle.n, plug_n.pin) annotation (points=[10, 0; 100, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
    end Idle;
    
    model Short "Multiphase short cut branch" 
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Short short[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-100, 50; 100, 110], string="%name"),
          Text(extent=[-100, -110; 100, -50], string="m=%m"),
          Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)),
          Line(points=[-90, 0; 90, 0])),
        Documentation(info="<HTML>
<p>
Contains m short cuts (Modelica.Electrical.Analog.Ideal.Short)
</p>
</HTML>"),
        Diagram);
    equation 
      
      connect(plug_p.pin, short.p) annotation (points=[-100, 0; -10, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
      connect(short.n, plug_n.pin) annotation (points=[10, 0; 100, 0], style(
          color=3,
          fillColor=7,
          fillPattern=1));
    end Short;
    
    model IdealOpener "Multiphase ideal opener" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened switch conductance";
      Modelica.Blocks.Interfaces.BooleanInPort control(final n=m) 
        annotation (extent=[-10, 88; 10, 108], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealOpener idealOpener[m](final Ron=Ron,
           final Goff=Goff) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Line(points=[-90, 0; -44, 0]),
          Ellipse(extent=[-44, 4; -36, -4]),
          Line(points=[-37, 2; 40, 50]),
          Line(points=[0, 88; 0, 26]),
          Line(points=[40, 0; 90, 0]),
          Text(
            extent=[-100, 100; -20, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m="),
          Text(
            extent=[20, 100; 100, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="%m"),
          Line(points=[40, 20; 40, 0])),
        Documentation(info="<HTML>
<p>
Contains m ideal opening switches (Modelica.Electrical.Analog.Ideal.IdealOpener).
</p>
</HTML>"),
        Diagram);
    equation 
      idealOpener.control.signal[1] = control.signal;
      connect(plug_p.pin, idealOpener.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(idealOpener.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end IdealOpener;
    
    model IdealCloser "Multiphase ideal closer" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m)) = fill(
        1.E-5, m) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m)) = fill(
        1.E-5, m) "Opened switch conductance";
      Modelica.Blocks.Interfaces.BooleanInPort control(final n=m) 
        annotation (extent=[-10, 88; 10, 108], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealCloser idealCloser[m](final Ron=Ron,
           final Goff=Goff) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Text(extent=[-80, -60; 80, -100], string="%name"),
          Line(points=[-90, 0; -44, 0]),
          Ellipse(extent=[-44, 4; -36, -4]),
          Line(points=[-37, 2; 40, 50]),
          Line(points=[0, 88; 0, 26]),
          Line(points=[40, 0; 90, 0]),
          Text(
            extent=[-100, 100; -20, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m="),
          Text(
            extent=[20, 100; 100, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="%m")),
        Documentation(info="<HTML>
<p>
Contains m ideal closing switches (Modelica.Electrical.Analog.Ideal.IdealCloser).
</p><
/HTML>"),
        Diagram);
    equation 
      idealCloser.control.signal[1] = control.signal;
      connect(plug_p.pin, idealCloser.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(idealCloser.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end IdealCloser;
  end Ideal;
  
  package Interfaces "Interfaces for electrical multiphase models" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains connectors and interfaces (partial models) for
electrical multiphase components, based on Modelica.Electrical.Analog.
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    connector Plug "Plug with m pins for an electric component" 
      parameter Integer m(final min=1) = 3 "number of phases";
      Modelica.Electrical.Analog.Interfaces.Pin pin[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical. 
The only difference is that the icons are different in order 
to identify more easily the plugs of a component. 
Usually, connector PositivePlug is used for the positive and 
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"));
    end Plug;
    
    connector PositivePlug "Positive plug with m pins" 
      extends Plug;
      annotation (
        Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=3, fillColor=3))),
        Diagram(Ellipse(extent=[-100, 100; 100, -100], style(
              color=3,
              fillColor=3,
              fillPattern=1)), Text(
            extent=[-100, -99; 100, -179],
            style(color=3),
            string="%name")),
        Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical. 
The only difference is that the icons are different in order 
to identify more easily the plugs of a component. 
Usually, connector PositivePlug is used for the positive and 
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"));
      
    end PositivePlug;
    
    connector NegativePlug "Negative plug with m pins" 
      extends Plug;
      annotation (
        Icon(Ellipse(extent=[-100, 100; 100, -100], style(
              color=3,
              fillColor=7,
              fillPattern=1))),
        Diagram(Ellipse(extent=[-100, 100; 100, -100], style(
              color=3,
              fillColor=7,
              fillPattern=1)), Text(
            extent=[-100, -100; 100, -180],
            style(color=3),
            string="%name")),
        Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical. 
The only difference is that the icons are different in order 
to identify more easily the plugs of a component. 
Usually, connector PositivePlug is used for the positive and 
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"));
    end NegativePlug;
    
    partial model TwoPlug "Component with one m-phase electric port" 
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.Voltage v[m] "Voltage drops between the two plugs";
      Modelica.SIunits.Current i[m] "Currents flowing into positive plugs";
      PositivePlug plug_p(final m=m) annotation (extent=[-110, -10; -90, 10]);
      NegativePlug plug_n(final m=m) annotation (extent=[90, -10; 110, 10]);
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>two</b> electrical plugs: 
the positive plug connector <i>plug_p</i>, and the negative plug connector <i>plug_n</i>. 
The currents flowing into plug_p are provided explicitly as currents i[m].
</p>
</HTML>"), Diagram);
    equation 
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
    end TwoPlug;
    
    partial model OnePort 
      "Component with two electrical plugs and currents from plug_p to plug_n" 
      extends TwoPlug;
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>two</b> electrical plugs: 
the positive plug connector <i>plug_p</i>, and the negative plug connector <i>plug_n</i>. 
The currents flowing into plug_p are provided explicitly as currents i[m]. 
It is assumed that the currents flowing into plug_p are identical to the currents flowing out of plug_n.
</p>
</HTML>"));
    equation 
      plug_p.pin.i + plug_n.pin.i = zeros(m);
    end OnePort;
    
    partial model FourPlug "Component with two m-phase electric ports" 
      parameter Integer m(final min=1) = 3 "number of phases";
      Modelica.SIunits.Voltage v1[m] "Voltage drops over the left port";
      Modelica.SIunits.Voltage v2[m] "Voltage drops over the right port";
      Modelica.SIunits.Current i1[m] 
        "Current flowing into positive plug of the left port";
      Modelica.SIunits.Current i2[m] 
        "Current flowing into positive plug of the right port";
      PositivePlug plug_p1(final m=m) annotation (extent=[-110, 90; -90, 110]);
      PositivePlug plug_p2(final m=m) annotation (extent=[90, 90; 110, 110]);
      NegativePlug plug_n1(final m=m) annotation (extent=[-110, -110; -90, -90]);
      NegativePlug plug_n2(final m=m) annotation (extent=[90, -110; 110, -90]);
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>four</b> electrical plugs.
</p>
</HTML>"));
    equation 
      v1 = plug_p1.pin.v - plug_n1.pin.v;
      v2 = plug_p2.pin.v - plug_n2.pin.v;
      i1 = plug_p1.pin.i;
      i2 = plug_p2.pin.i;
    end FourPlug;
    
    partial model TwoPort 
      "Component with two m-phase electric ports, including currents" 
      extends FourPlug;
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>four</b> electrical plugs. 
It is assumed that the currents flowing into plug_p1 are identical to the currents flowing out of plug_n1, 
and that the currents flowing into plug_p2 are identical to the currents flowing out of plug_n2.
</p>
</HTML>"));
    equation 
      plug_p1.pin.i + plug_n1.pin.i = zeros(m);
      plug_p2.pin.i + plug_n2.pin.i = zeros(m);
    end TwoPort;
    
    partial model AbsoluteSensor "Base partial model for measuring potentials" 
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "number of phases";
      PositivePlug plug_p(m) annotation (extent=[-110, -10; -90, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=m) 
        annotation (extent=[100, -10; 120, 10]);
      annotation (
        Icon(
          Line(points=[70, 0; 100, 0]),
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Text(
            extent=[-60, -60; 60, -100],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m"),
          Text(extent=[-100, 60; 100, 100], string="%name")),
        Documentation(info="<HTML>
<p>
Superclass for models measuring potentials.
</p>
</HTML>"),
        Diagram);
    end AbsoluteSensor;
    
    partial model RelativeSensor 
      "Base partial model for measuring relative variables between two plugs" 
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "number of phases";
      Modelica.Blocks.Interfaces.OutPort outPort(final n=m) 
        annotation (extent=[-10, -110; 10, -90], rotation=-90);
      PositivePlug plug_p(final m=m) annotation (extent=[-110, -10; -90, 10]);
      NegativePlug plug_n(final m=m) annotation (extent=[90, -10; 110, 10]);
      annotation (Icon(
          Line(points=[0, -90; 0, -70]),
          Line(points=[70, 0; 90, 0], style(color=0)),
          Line(points=[-70, 0; -90, 0], style(color=0)),
          Text(
            extent=[-60, -60; 60, -100],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m"),
          Text(extent=[-100, 60; 100, 100], string="%name")), Documentation(
            info="<HTML>
<p>
Superclass for models measuring relative variables between plugs.
</p>
</HTML>"));
    end RelativeSensor;
  end Interfaces;
  
  package Sensors "Multiphase potential, voltage and current Sensors" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains multiphase potential, voltage, and current sensors.
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model PotentialSensor "Multiphase potential sensor" 
      extends Interfaces.AbsoluteSensor;
      Modelica.SIunits.ElectricPotential phi[m] "Absolute voltage potentials";
      Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (Documentation(info="<HTML>
<p>
Contains m potential sensors (Modelica.Electrical.Analog.Sensors.PotentialSensor), 
thus measuring the m potentials <i>phi[m]</i> of the m pins of plug_p.
</p>
</HTML>"), Diagram);
    equation 
      phi = potentialSensor.outPort.signal[1];
      outPort.signal = phi;
      connect(potentialSensor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
    end PotentialSensor;
    
    model VoltageSensor "Multiphase voltage sensor" 
      extends Interfaces.RelativeSensor;
      Modelica.SIunits.Voltage v[m] "Voltages between plug_p and plug_n";
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(Text(
            extent=[-29, -11; 30, -70],
            style(color=0),
            string="V")),
        Documentation(info="<HTML>
<p>
Contains m voltage sensors (Modelica.Electrical.Analog.Sensors.VoltageSensor), 
thus measuring the m potential differences <i>v[m]</i> between the m pins of plug_p and plug_n. 
</p>
</HTML>"),
        Diagram);
    equation 
      v = voltageSensor.outPort.signal[1];
      outPort.signal = v;
      connect(voltageSensor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
      connect(voltageSensor.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
    end VoltageSensor;
    
    model CurrentSensor "Multiphase current sensor" 
      extends Interfaces.RelativeSensor;
      Modelica.SIunits.Current i[m] "Currents flowing from plug_p to plug_n";
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(Text(
            extent=[-31, -11; 28, -70],
            string="A",
            style(color=0))),
        Documentation(info="<HTML>
<p>
Contains m current sensors (Modelica.Electrical.Analog.Sensors.CurrentSensor), 
thus measuring the m currents <i>i[m]</i> flowing from the m pins of plug_p to the m pins of plug_n. 
</p>
</HTML>"),
        Diagram);
    equation 
      i = currentSensor.outPort.signal[1];
      outPort.signal = i;
      connect(plug_p.pin, currentSensor.p) 
        annotation (points=[-100, 0; -10, 0], style(color=3));
      connect(currentSensor.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end CurrentSensor;
  end Sensors;
  
  package Sources "Multiphase voltage and current sources" 
    extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains time-dependend and controlled multiphase voltage and current sources:
<ul>
<li>SignalVoltage: fed by Modelica.Blocks.Sources arbitrary waveforms of voltages are possible</li>
<li>SineVoltage : phase shift between consecutive voltages by default <tt>= pi/m</tt></li>
<li>SignalCurrent: fed by Modelica.Blocks.Sources arbitrary waveforms of currents are possible</li>
<li>SineCurrent : phase shift between consecutive currents by default <tt>= pi/m</tt></li>
</ul>
</p>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.00 2004/06/25 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2004, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</HTML>"));
    
    model SignalVoltage "Multiphase signal voltage source" 
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.InPort inPort(final n=m) 
        annotation (extent=[-20, 50; 20, 90], rotation=-90);
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Line(points=[-90, 0; -50, 0]),
          Line(points=[50, 0; 90, 0]),
          Ellipse(extent=[-50, 50; 50, -50], style(color=3, fillColor=7)),
          Line(points=[-50, 0; 50, 0]),
          Text(extent=[-100, -100; 100, -60], string="%name"),
          Text(
            extent=[-60, 20; 60, -20],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m signal controlled voltage sources (Modelica.Electrical.Analog.Sources.SignalVoltage)
</p>
</HTML>"),
        Diagram);
    equation 
      signalVoltage.inPort.signal[1] = inPort.signal;
      connect(signalVoltage.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(signalVoltage.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end SignalVoltage;
    
    model SineVoltage "Multiphase sine voltage source" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m]=fill(1, m) 
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-{(j - 1)/m*2*Modelica.
          Constants.pi for j in 1:m} "Phases of sine waves";
      parameter Modelica.SIunits.Frequency freqHz[m]=fill(1, m) 
        "Frequencies of sine waves";
      parameter Modelica.SIunits.Voltage offset[m]=zeros(m) "Voltage offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage[m](
        final V=V,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Line(points=[-90, 0; -50, 0]),
          Line(points=[50, 0; 90, 0]),
          Ellipse(extent=[-50, 50; 50, -50], style(color=3, fillColor=7)),
          Line(points=[-50, 0; 50, 0]),
          Line(points=[-70, 0; -60.2, 29.9; -53.8, 46.5; -48.2, 58.1; -43.3,
                65.2; -38.3, 69.2; -33.4, 69.8; -28.5, 67; -23.6, 61; -18.6, 52;
                 -13, 38.6; -5.98, 18.6; 8.79, -26.9; 15.1, -44; 20.8, -56.2;
                25.7, -64; 30.6, -68.6; 35.5, -70; 40.5, -67.9; 45.4, -62.5;
                50.3, -54.1; 55.9, -41.3; 63, -21.7; 70, 0], style(color=8)),
          Text(extent=[-100, -100; 100, -60], string="%name"),
          Text(
            extent=[-60, 100; 60, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m sine voltage sources (Modelica.Electrical.Analog.Sources.SineVoltage) 
with a default phase shift of -(j-1)/m * 2*pi for j in 1:m.
</p>
</HTML>"),
        Diagram);
    equation 
      connect(sineVoltage.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(sineVoltage.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end SineVoltage;
    
    model SignalCurrent "Multiphase sine current source" 
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.InPort inPort(final n=m) 
        annotation (extent=[-20, 50; 20, 90], rotation=-90);
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent[m] 
        annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Line(points=[-90, 0; -50, 0]),
          Line(points=[50, 0; 90, 0]),
          Ellipse(extent=[-50, 50; 50, -50], style(color=3, fillColor=7)),
          Line(points=[0, 50; 0, -50]),
          Text(extent=[-100, -100; 100, -60], string="%name"),
          Text(
            extent=[-60, 20; 60, -20],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m signal controlled current sources (Modelica.Electrical.Analog.Sources.SignalCurrent) 
</p>
</HTML>"),
        Diagram);
    equation 
      signalCurrent.inPort.signal[1] = inPort.signal;
      connect(signalCurrent.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(signalCurrent.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end SignalCurrent;
    
    model SineCurrent "Multiphase sine current source" 
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m]=fill(1, m) 
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-{(j - 1)/m*2*Modelica.
          Constants.pi for j in 1:m} "Phases of sine waves";
      parameter Modelica.SIunits.Frequency freqHz[m]=fill(1, m) 
        "Frequencies of sine waves";
      parameter Modelica.SIunits.Voltage offset[m]=zeros(m) "Voltage offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent[m](
        final I=I,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (extent=[-10, -10; 10, 10]);
      annotation (
        Icon(
          Line(points=[-90, 0; -50, 0]),
          Line(points=[50, 0; 90, 0]),
          Ellipse(extent=[-50, 50; 50, -50], style(color=3, fillColor=7)),
          Line(points=[0, 50; 0, -50]),
          Line(points=[-70, 0; -60.2, 29.9; -53.8, 46.5; -48.2, 58.1; -43.3,
                65.2; -38.3, 69.2; -33.4, 69.8; -28.5, 67; -23.6, 61; -18.6, 52;
                 -13, 38.6; -5.98, 18.6; 8.79, -26.9; 15.1, -44; 20.8, -56.2;
                25.7, -64; 30.6, -68.6; 35.5, -70; 40.5, -67.9; 45.4, -62.5;
                50.3, -54.1; 55.9, -41.3; 63, -21.7; 70, 0], style(color=8)),
          Text(extent=[-100, -100; 100, -60], string="%name"),
          Text(
            extent=[-60, 100; 60, 60],
            style(
              color=3,
              fillColor=3,
              fillPattern=1),
            string="m=%m")),
        Documentation(info="<HTML>
<p>
Contains m sine current sources (Modelica.Electrical.Analog.Sources.SineCurrent) 
with a default phase shift of -(j-1)/m * 2*pi for j in 1:m.
</p>
</HTML>"),
        Diagram);
    equation 
      connect(sineCurrent.p, plug_p.pin) 
        annotation (points=[-10, 0; -100, 0], style(color=3));
      connect(sineCurrent.n, plug_n.pin) 
        annotation (points=[10, 0; 100, 0], style(color=3));
    end SineCurrent;
  end Sources;
end MultiPhase;

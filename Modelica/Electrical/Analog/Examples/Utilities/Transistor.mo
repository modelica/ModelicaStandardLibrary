model Transistor 
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Icon(
      Rectangle(extent=[-80, 80; 80, -80]),
      Line(points=[80, 60; 100, 60]),
      Line(points=[80, -60; 100, -60]),
      Line(points=[-100, 0; -80, 0]),
      Line(points=[-60, 0; -10, 0]),
      Line(points=[-10, 40; -10, -40]),
      Line(points=[60, 60; 40, 60; -10, 10]),
      Line(points=[-10, -10; 40, -60; 60, -60])),
    Window(
      x=0.25,
      y=0.24,
      width=0.6,
      height=0.6));
  Basic.Resistor rtb(R=0.05) annotation (extent=[-80, -10; -60, 10]);
  Basic.Resistor rtc(R=0.1) annotation (extent=[40, 0; 60, 20]);
  Basic.Capacitor ct(C=1e-10) annotation (extent=[-50, -40; -30, -20], rotation=
       -90);
  Semiconductors.NPN Tr(
    Bf=50,
    Br=0.1,
    Is=1e-16,
    Vak=0.02,
    Tauf=0.12e-9,
    Taur=5e-9,
    Ccs=1e-12,
    Cje=0.4e-12,
    Cjc=0.5e-12,
    Phie=0.8,
    Me=0.4,
    Phic=0.8,
    Mc=0.333,
    Gbc=1e-15,
    Gbe=1e-15,
    Vt=0.02585) annotation (extent=[-20, -20; 20, 20]);
  Basic.Ground Ground1 annotation (extent=[-50, -80; -30, -60]);
  Interfaces.Pin c annotation (extent=[90, 50; 110, 70]);
  Interfaces.Pin b annotation (extent=[-110, -10; -90, 10]);
  Interfaces.Pin e annotation (extent=[90, -70; 110, -50]);
equation 
  connect(rtb.n, Tr.B) annotation (points=[-60, 0; -20, 0]);
  connect(rtb.n, ct.p) annotation (points=[-60, 0; -40, 0; -40, -20]);
  connect(ct.n, Ground1.p) annotation (points=[-40, -40; -40, -60]);
  connect(Tr.C, rtc.p) annotation (points=[20, 10; 40, 10]);
  connect(rtc.n, c) annotation (points=[60, 10; 80, 10; 80, 60; 100, 60]);
  connect(b, rtb.p) annotation (points=[-100, 0; -80, 0]);
  connect(Tr.E, e) annotation (points=[20, -10; 80, -10; 80, -60; 100, -60]);
end Transistor;

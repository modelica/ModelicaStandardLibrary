model RealSwitch 
  Ideal.ControlledIdealCommutingSwitch S(level=2.5) annotation (extent=[11.3333,
          18; 58, 64.6667]);
  Basic.Resistor R(R=0.01) annotation (extent=[-66, 16; -19.3333, 62.6667]);
  Interfaces.Pin p annotation (extent=[-110, 30; -90, 50]);
  Interfaces.Pin n1 annotation (extent=[90, 50; 110, 70]);
  Interfaces.Pin n2 annotation (extent=[90, 4; 110, 24]);
  Interfaces.Pin control annotation (extent=[24, 90; 44, 110]);
equation 
  connect(p, R.p) annotation (points=[-100, 40; -66, 39.3333]);
  connect(R.n, S.p) annotation (points=[-19.3333, 39.3333; 11.3333, 41.3333]);
  connect(n1, S.n1) annotation (points=[100, 60; 58, 53]);
  connect(n2, S.n2) annotation (points=[100, 14; 58, 41.3333]);
  connect(control, S.control) annotation (points=[34, 100; 34.6667, 64.6667]);
  annotation (Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]), Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6));
end RealSwitch;

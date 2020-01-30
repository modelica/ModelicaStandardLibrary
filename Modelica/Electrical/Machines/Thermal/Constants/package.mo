within Modelica.Electrical.Machines.Thermal;
package Constants "Material Constants"
  extends Modelica.Icons.Package;
  constant SI.LinearTemperatureCoefficient alpha20Zero=0
    "Not temperature dependent";
  constant SI.LinearTemperatureCoefficient alpha20Aluminium=
      4.000e-3 "Aluminium";
  constant SI.LinearTemperatureCoefficient alpha20Brass=
      1.100e-3 "Brass";
  constant SI.LinearTemperatureCoefficient alpha20Bronze=
      0.800e-3 "Bronze";
  constant SI.LinearTemperatureCoefficient alpha20Copper=
      3.920e-3 "Copper";

  annotation (Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={Polygon(
              origin={-9.2597,25.6673},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,
            10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,
            -15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,
            -0.097}},
              smooth=Smooth.Bezier),Polygon(
              origin={-19.9923,-8.3993},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,
            -20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,
            37.145}},
              smooth=Smooth.Bezier),Polygon(
              origin={23.753,-11.5422},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,
            -24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,
            0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,
            41.214},{-2.671,41.214}},
              smooth=Smooth.Bezier)}), Documentation(info="<html>
Material constants, especially linear temperature coefficients of commonly used conductor materials
</html>"));
end Constants;

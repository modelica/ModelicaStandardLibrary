within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model Generic "Partial Tellinen hysteresis model"
  extends Interfaces.TwoPorts;

  // Group Fixed Geometry (Cuboid)
  parameter SI.Length l=0.1 "Length in direction of flux" annotation (Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Interfaces/GenericParallelFlux.png"));

  parameter SI.Area A=1e-4 "Area of cross section" annotation (Dialog(group="Fixed geometry", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericParallelFlux.png"));
  final parameter SI.Volume V = A * l "Volume of FluxTube";
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-70,0},{-100,0}}, color={255,128,0}),
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{70,0},{100,0}}, color={255,128,0})}),
                                 Documentation(info="<html>
</html>"));
end Generic;

within Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities;
function sineSurface
  "Function defining the characteristic of a moving sine in three dimensions"
   extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic;
   input Real x_min "Minimum value of x";
   input Real x_max "Maximum value of x";
   input Real y_min "Minimum value of y";
   input Real y_max "Maximum value of y";
   input Real z_min "Minimum value of z";
   input Real z_max "Maximum value of z";
   input Real wz "Factor for angular frequency";
protected
   Real aux_y;
   Real A=(z_max-z_min)/2;
algorithm
   for i in 1:nu loop
      aux_y := y_min + (y_max - y_min)*(i-1)/(nu-1);
      for j in 1:nv loop
         X[i,j] := x_min + (x_max - x_min)*(j - 1)/(nv - 1);
         Y[i,j] := aux_y;
         Z[i,j] := A*Modelica.Math.sin(wz + 0.1*j + 0.1*i)+A;
      end for;
   end for;

   if multiColoredSurface then
      C := {{(Z[i,j]+1)*200,255,0} for j in 1:nv, i in 1:nu};
   end if;
  annotation (Documentation(info="<html>
<p>
Function defining the characteristics of a moving sine in three dimensions.
This function is used in example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Elementary.Surfaces</a>.
</p>
</html>"));
end sineSurface;

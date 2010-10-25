within Modelica.Mechanics.MultiBody.Examples.Elementary;
package Utilities
  "Utility models and functions used by MultiBody.Examples.Elementary"
  extends Modelica.Icons.Package;
  function theoreticalNormalGravityWGS84
    "WGS84 normal gravity over earth ellipsoid in negativ y-direction"
     extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
    input Modelica.SIunits.Conversions.NonSIunits.Angle_deg phi
      "Geodetic latitute" annotation(Dialog);
  protected
    constant Modelica.SIunits.Position a = 6378137.0
      "Semi-major axis of the earth ellipsoid";
    constant Modelica.SIunits.Position b = 6356752.3142
      "Semi-minor axis of the earth ellipsoid";
    constant Modelica.SIunits.AngularAcceleration g_e = 9.7803253359
      "Theoretical gravity acceleration at the equator";
    constant Modelica.SIunits.AngularAcceleration g_p = 9.8321849378
      "Theoretical gravity acceleration at the poles";
    constant Real k =   (b/a)*(g_p/g_e) - 1;

    constant Real e2 = (8.1819190842622e-2)^2
      "Square of the first ellipsoidal eccentricity";
    constant Real f = 1/298.257223563 "Ellipsoidal flattening";
    constant Modelica.SIunits.AngularVelocity w =   7292115e-11
      "Angular velocity of earth";
    constant Real GM(unit="m3/s2")=3986004.418e8
      "Earths Gravitational Constant";
    constant Real m(unit="1")=w^2*a^2*b/GM;
    Real sinphi2(unit="1");
    Modelica.SIunits.AngularAcceleration gn
      "Normal gravity at the earth ellipsoid";
    Modelica.SIunits.AngularAcceleration gh
      "Normal gravity at height h over the earth ellipsoid";
    Modelica.SIunits.Position h "Height over the WGS84 earth ellipsoid";
    Real ha(unit="1") "h/a";
  algorithm
    h := r[2];
    sinphi2 :=Modelica.Math.sin(Modelica.SIunits.Conversions.from_deg(phi))^2;
    gn := g_e*(1 + k*sinphi2)/sqrt(1 - e2*sinphi2);
    ha := h/a;
    gh := gn*(1 - ha*(2*(1+f+m-2*f*sinphi2)+3*ha));
    gravity :={0,-gh,0};
    annotation (Documentation(info="<html>
<p>
Function that computes the theoretical gravity of the
<a href=\"http://earth-info.nga.mil/GandG/publications/tr8350.2/wgs84fin.pdf\">WGS84 ellipsoid earth model</a> at and close to the earth ellipsoid surface, for the
given \"geodeticLatitude\" and the given \"height=r[2]\" over the
ellipsoid surface.
</p>

</html>"));
  end theoreticalNormalGravityWGS84;

  function sineSurface
    "Function defining the characteristic of a moving sine in three dimensions"
     extends
      Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic;
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
           Z[i,j] := A*sin(wz + 0.1*j + 0.1*i)+A;
        end for;
     end for;

     if multiColoredSurface then
        C := {{(Z[i,j]+1)*200,255,0} for j in 1:nv, i in 1:nu};
     end if;
  end sineSurface;
end Utilities;

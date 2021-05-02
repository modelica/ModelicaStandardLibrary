within Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities;
function theoreticalNormalGravityWGS84
  "WGS84 normal gravity over earth ellipsoid in negative y-direction"
   extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
  input Modelica.Units.NonSI.Angle_deg phi
    "Geodetic latitude" annotation(Dialog);
protected
  constant SI.Position a = 6378137.0
    "Semi-major axis of the earth ellipsoid";
  constant SI.Position b = 6356752.3142
    "Semi-minor axis of the earth ellipsoid";
  constant SI.AngularAcceleration g_e = 9.7803253359
    "Theoretical gravity acceleration at the equator";
  constant SI.AngularAcceleration g_p = 9.8321849378
    "Theoretical gravity acceleration at the poles";
  constant Real k =   (b/a)*(g_p/g_e) - 1;

  constant Real e2 = (8.1819190842622e-2)^2
    "Square of the first ellipsoidal eccentricity";
  constant Real f = 1/298.257223563 "Ellipsoidal flattening";
  constant SI.AngularVelocity w =   7292115e-11
    "Angular velocity of earth";
  constant Real GM(unit="m3/s2")=3986004.418e8
    "Earths Gravitational Constant";
  constant Real m(unit="1")=w^2*a^2*b/GM;
  Real sinphi2(unit="1");
  SI.AngularAcceleration gn
    "Normal gravity at the earth ellipsoid";
  SI.AngularAcceleration gh
    "Normal gravity at height h over the earth ellipsoid";
  SI.Position h "Height over the WGS84 earth ellipsoid";
  Real ha(unit="1") "h/a";
algorithm
  h := r[2];
  sinphi2 :=Modelica.Math.sin(Modelica.Units.Conversions.from_deg(phi))^2;
  gn := g_e*(1 + k*sinphi2)/sqrt(1 - e2*sinphi2);
  ha := h/a;
  gh := gn*(1 - ha*(2*(1+f+m-2*f*sinphi2)+3*ha));
  gravity :={0,-gh,0};
  annotation (Documentation(info="<html>
<p>
Function that computes the theoretical gravity of the
<a href=\"https://earth-info.nga.mil/php/download.php?file=coord-wgs84\">WGS84 ellipsoid earth model</a> at and close to the earth ellipsoid surface, for the
given \"geodeticLatitude\" and the given \"height=r[2]\" over the
ellipsoid surface.
</p>

</html>"));
end theoreticalNormalGravityWGS84;

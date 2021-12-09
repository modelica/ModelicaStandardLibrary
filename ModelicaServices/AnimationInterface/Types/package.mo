within ModelicaServices.AnimationInterface;

package Types
type Length = Real (final quantity="Length", final unit="m");
type Position = Length;
type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");
end Types;

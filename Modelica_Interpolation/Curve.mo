record Curve "Spline interpolation of n-dimensional curves in space" 
  extends Modelica.Icons.Record;
  annotation (
    Documentation(info="<html>
<p>
This record provides the data-structure and functions
to perform spline interpolation of n-dimensional
curves.
</p>
</html>
 
"));
  
  Modelica_Interpolation.Bspline1D spline;
  Boolean arcLengthParam "True, if arc-length parameterization shall be used";
  Modelica_Interpolation.Bspline1D arcSpline 
    "Bspline for arclength computation";
  
encapsulated function constructor "Initialize curve interpolation" 
    import Modelica;
    import Modelica_Interpolation;
    import Modelica_Interpolation.Curve;
    extends Modelica.Icons.Function;
    input Real r[:, :] "r[i,:] is position vector to point i on the curve";
    input Boolean arcLengthParam=false 
      "true, if curve parameter is arc length, otherwise it is in the range 0..1";
    input Integer degree(min=1) = 3 "Polynomial degree of interpolation";
    output Curve curve(
        spline(
           redeclare Real controlPoints[
               Modelica_Interpolation.Utilities.getNumberControlPoints(r,degree), size(r,2)],
           redeclare Real knots[Modelica_Interpolation.Utilities.getNumberControlPoints(r,degree)+degree+1]),
        arcLengthParam=arcLengthParam,
        arcSpline(
           redeclare Real controlPoints[
               6*Modelica_Interpolation.Utilities.getNumberControlPoints(r,degree),1],
           redeclare Real knots[6*Modelica_Interpolation.Utilities.getNumberControlPoints(r,degree)+3+1])) 
      "curve data in a form which can be quickly interpolated";
  protected 
    Integer ncontrol = Modelica_Interpolation.Utilities.getNumberControlPoints(r,degree);
    Integer ndim = size(r,2);
    Real param[size(r,1)];
    Integer n;
    Integer n_ctrl;
    Real u[3*ncontrol];
    Real s[3*ncontrol];
    Real xd[size(r,2)];
    Real derivs[3*ncontrol];
    Real vdata[degree+1,size(r,2)];
    Integer multi;
    Integer begin;
   Real delta[size(r,2)];
    Integer j;
    Integer jstart;
    Integer k;
    Integer span;
    Integer nvdata;
    Real piece_ctrl[ncontrol,ndim];
    Real piece_k[ncontrol+degree+1];
    Real N[degree];
    Integer counter;
    Real t;
algorithm 
  n := size(r,1);
  n_ctrl := ncontrol;
  //delete multiple start data points
  multi := 1;
    
  for j in 1:n-1 loop
   delta := r[1,:] - r[1+j,:];
      
   if sqrt(delta*delta) < 1e-12 then
    multi := multi + 1;
        
   end if;
      
  end for;
  begin := multi;
    
  //delete multiple end data points
  multi := 0;
    
  for j in 1:n-1 loop
   delta := r[n,:] - r[n-j,:];
      
   if sqrt(delta*delta) < 1e-12 then
    multi := multi + 1;
        
   end if;
      
  end for;
  n := n-multi;
    
  jstart := begin;
  nvdata := 0;
  counter := 1;
    
  for j in begin+1:n-1 loop
    delta := r[j,:] - r[j-1,:];
      
    if sqrt(delta*delta) < 1e-12 then
        
      if j-1-jstart >= 1 and j-1-jstart < degree then
        //-----------------------
        //an interpolation with a Bspline of degree = p needs 
        //p+1 data points. If there are less than p+1, insert
        //virtual data points to get p+1.
        //-----------------------
          param[1:j - jstart] :=
            Modelica_Interpolation.Utilities.parametrizeSpline(r[jstart:j - 1, :]);
          (piece_ctrl[1:j - jstart, :],piece_k[1:2*(j - jstart)]) :=
            Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
              param[1:j - jstart],
              r[jstart:j - 1, :],
              j - 1 - jstart);
          
        for i in 1:j-jstart-1 loop
            span := Modelica_Interpolation.Bspline1D.Internal.n_findSpan(
                j - 1 - jstart,
                param[i],
                piece_k[1:2*(j - jstart)]);
            N[1:j - jstart] :=
              Modelica_Interpolation.Bspline1D.Internal.n_BasisFuns(
                span,
                param[i],
                j - 1 - jstart,
                piece_k[1:2*(j - jstart)]);
            
            for k in 1:ndim loop
              vdata[i,k] := N[1:j-jstart]*piece_ctrl[span-j+jstart+1:span,k];
            end for;
        end for;
          
        for i in j-jstart:degree+1 loop
            t := param[j-jstart-1]+i*(param[j-jstart]-param[j-jstart-1])/(degree+1);
            span := Modelica_Interpolation.Bspline1D.Internal.n_findSpan(
                j - 1 - jstart,
                t,
                piece_k[1:2*(j - jstart)]);
            N[1:j - jstart] :=
              Modelica_Interpolation.Bspline1D.Internal.n_BasisFuns(
                span,
                t,
                j - 1 - jstart,
                piece_k[1:2*(j - jstart)]);
            
            for k in 1:ndim loop
               vdata[i,k] := N[1:j-jstart]*piece_ctrl[span-j+jstart+1:span,k];
            end for;
        end for;
          
          param[1:degree + 1] :=
            Modelica_Interpolation.Utilities.parametrizeSpline(vdata);
          (piece_ctrl[1:degree + 1, :],piece_k[1:2*(degree + 1)]) :=
            Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
              param[1:degree + 1],
              vdata,
              degree);
          
        if jstart == begin then
         //the beginning of the curve
         curve.spline.controlPoints[1:degree+1,:] := piece_ctrl[1:degree+1,:];
         curve.spline.knots[1:2*(degree+1)] := piece_k[1:2*(degree+1)]*(j-jstart)/n_ctrl;
         counter := counter + degree + 1;
            
        else
          //somewhere in the middle
         curve.spline.controlPoints[counter:counter+degree,:] := piece_ctrl[1:degree+1,:];
         curve.spline.knots[counter+degree+1:counter+2*(degree+1)-1] := piece_k[degree+2:2*(degree+1)]*(j-jstart)/n_ctrl + ones(degree+1)* curve.spline.knots[counter+degree];
         counter := counter + degree + 1;
            
        end if;
        nvdata := nvdata + degree - (j-1-jstart);
          
     elseif j-1-jstart >= 1 and j-1-jstart >= degree then
       //-----------------------
      // no virtual data points
      //-----------------------
          param[1:j - jstart] :=
            Modelica_Interpolation.Utilities.parametrizeSpline(r[jstart:j - 1, :]);
          (piece_ctrl[1:j - jstart, :],piece_k[1:j - jstart + degree + 1]) :=
            Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
              param[1:j - jstart],
              r[jstart:j - 1, :],
              degree);
          
      if jstart == begin then
         //the beginning of the curve
         curve.spline.controlPoints[1:j-1,:] := piece_ctrl[1:j-1,:];
         curve.spline.knots[1:j+degree] := piece_k[1:j+degree]*(j-jstart)/n_ctrl;
         counter := counter + j - jstart;
            
        else
         //somewhere in the middle
       curve.spline.controlPoints[counter:counter+j-jstart-1,:] := piece_ctrl[1:j-jstart,:];
         curve.spline.knots[counter+degree+1:counter+j-jstart+degree] := piece_k[degree+2:j-jstart+degree+1]*(j-jstart)/n_ctrl + ones(j-jstart)* curve.spline.knots[counter+degree];
         counter := counter + j - jstart;
            
        end if;
          
     end if;
     jstart := j;
     delta := r[j+1,:] - r[j,:];
        
     if sqrt(delta*delta) < 1e-12 then
      //triple data point; delete one data point (jump over)
      jstart := j+1;
          
     end if;
        
    end if;
      
   end for;
    
   //the end of the curve
    
   if n-jstart < degree then
    //-----------------------
     // virtual data points needed
     //-----------------------
    nvdata := nvdata + degree - (n-jstart);
      param[1:n - jstart + 1] :=
        Modelica_Interpolation.Utilities.parametrizeSpline(r[jstart:n, :]);
      (piece_ctrl[1:n - jstart + 1, :],piece_k[1:2*(n - jstart + 1)]) :=
        Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
          param[1:n - jstart + 1],
          r[jstart:n, :],
          n - jstart);
      
     for i in 1:n-jstart loop
        span := Modelica_Interpolation.Bspline1D.Internal.n_findSpan(
            n - jstart,
            param[i],
            piece_k[1:2*(n - jstart + 1)]);
        N[1:n - jstart + 1] :=
          Modelica_Interpolation.Bspline1D.Internal.n_BasisFuns(
            span,
            param[i],
            n - jstart,
            piece_k[1:2*(n - jstart + 1)]);
        
      for k in 1:ndim loop
      vdata[i,k] := N[1:n-jstart+1]*piece_ctrl[span-n+jstart:span,k];
          
     end for;
        
    end for;
      
    for i in n-jstart+1:degree+1 loop
      t := param[n-jstart]+i*(param[n-jstart+1]-param[n-jstart])/(degree+1);
        span := Modelica_Interpolation.Bspline1D.Internal.n_findSpan(
            n - jstart,
            t,
            piece_k[1:2*(n - jstart + 1)]);
        N[1:n - jstart + 1] :=
          Modelica_Interpolation.Bspline1D.Internal.n_BasisFuns(
            span,
            t,
            n - jstart,
            piece_k[1:2*(n - jstart + 1)]);
        
      for k in 1:ndim loop
      vdata[i,k] := N[1:n-jstart+1]*piece_ctrl[span-n+jstart:span,k];
          
     end for;
        
    end for;
      
      param[1:degree + 1] := Modelica_Interpolation.Utilities.parametrizeSpline(
        vdata);
      (piece_ctrl[1:degree + 1, :],piece_k[1:2*(degree + 1)]) :=
        Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
          param[1:degree + 1],
          vdata,
          degree);
     curve.spline.controlPoints[n_ctrl-degree:n_ctrl,:] := piece_ctrl[1:degree+1,:];
     curve.spline.knots[n_ctrl+1:n_ctrl+degree+1] := piece_k[degree+2:2*(degree+1)]*(n-jstart+1)/n_ctrl + ones(degree+1)* curve.spline.knots[n_ctrl];
      
   else
     //-----------------------
     // no virtual data points
     //-----------------------
      param[1:n - jstart + 1] :=
        Modelica_Interpolation.Utilities.parametrizeSpline(r[jstart:n, :]);
      (piece_ctrl[1:n - jstart + 1, :],piece_k[1:n - jstart + 1 + degree + 1])
        := Modelica_Interpolation.Bspline1D.Internal.interpolation_raw(
          param[1:n - jstart + 1],
          r[jstart:n, :],
          degree);
     curve.spline.controlPoints[counter:counter+n-jstart,:] := piece_ctrl[1:n-jstart+1,:];
     curve.spline.knots[counter+degree+1:counter+degree+1+n-jstart] := piece_k[degree+2:n-jstart+1+degree+1]*(n-jstart+1)/n_ctrl + ones(n-jstart+1)* curve.spline.knots[counter+degree];
      
   end if;
   curve.spline.knots := curve.spline.knots / curve.spline.knots[size(curve.spline.knots,1)];
    
    // compute the Bspline for arc length
    if arcLengthParam then
      n := 3*ncontrol;
      u := linspace(0,1,n);
      s[1] := 0;
      xd := Modelica_Interpolation.Bspline1D.evaluateDerN(
          curve.spline,
          0,
          1);
     derivs[1] := 1/abs(sqrt(xd*xd));
      
     for i in 2:n loop
        s[i] := s[i - 1] + Modelica_Interpolation.Utilities.curveLength(
            curve.spline,
            u[i - 1],
            u[i]);
        xd := Modelica_Interpolation.Bspline1D.evaluateDerN(
            curve.spline,
            u[i],
            1);
       derivs[i] := 1/sqrt(xd*xd);
        
     end for;
      
     curve.arcSpline := Modelica_Interpolation.Bspline1D.fromPointsAndDerivatives(
         param=s,
         points=[u],
         derivs=[derivs],
         degree=3);
   end if;
    
end constructor;
  
encapsulated function getLength "Return the length of the curve" 
  import Modelica;
  import Modelica_Interpolation.Curve;
  extends Modelica.Icons.Function;
  input Curve curve "Bspline curve data";
  output Real length "length of the curve";
    
algorithm 
 if curve.arcLengthParam then
  // the last knot of the arcSpline is the curve length
  length := curve.arcSpline.knots[size(curve.arcSpline.knots,1)];
      
 else
  length := curve.spline.knots[size(curve.spline.knots,1)];
      
 end if;
    
end getLength;
  
encapsulated function evaluate "Evaluate curve at one point" 
    import Modelica;
    import Modelica_Interpolation.Curve;
    extends Modelica.Icons.Function;
    input Curve curve "Bspline curve data to be evaluated";
    input Real s "Parameter value at which the curve shall be evaluated";
    output Real r[size(curve.spline.controlPoints,2)] "Value of the curve at s";
  protected 
    Real s_loc=s "local path parameter";
    Real x[1];
algorithm 
    if curve.arcLengthParam then
      // determine local path parameter from arc-length s
      x := Modelica_Interpolation.Bspline1D.evaluate(curve.arcSpline, s);
      s_loc := x[1];
    end if;
    r := Modelica_Interpolation.Bspline1D.evaluate(curve.spline, s_loc);
end evaluate;
  
encapsulated function evaluateDer 
    "Evaluate curve and its first derivative at one point" 
   import Modelica;
   import Modelica_Interpolation.Curve;
   extends Modelica.Icons.Function;
   input Curve curve "Bspline curve data";
   input Real s "Parameter value at which the curve shall be evaluated";
    output Real r[size(curve.spline.controlPoints,2)] "Value of the curve at s";
    output Real rd[size(curve.spline.controlPoints,2)] 
      "Value of the first derivative";
  protected 
   Real s_loc=s "local path parameter";
    Real x[1];
    Real xd[1];
algorithm 
    
   if curve.arcLengthParam then
      (x,xd) := Modelica_Interpolation.Bspline1D.evaluateDer(curve.arcSpline, s);
      s_loc := x[1];
      (r,rd) := Modelica_Interpolation.Bspline1D.evaluateDer(curve.spline,
        s_loc);
      rd := rd*xd[1];
      
   else
      (r,rd) := Modelica_Interpolation.Bspline1D.evaluateDer(curve.spline,
        s_loc);
      
   end if;
    
end evaluateDer;
  
encapsulated function evaluateDer2 
    "Evaluate curve and its first and second derivative at one point" 
   import Modelica;
   import Modelica_Interpolation.Curve;
   extends Modelica.Icons.Function;
   input Curve curve "Bspline curve data";
   input Real s "Parameter value at which the curve shall be evaluated";
    output Real r[size(curve.spline.controlPoints,2)] "Value of the curve at s";
    output Real rd[size(curve.spline.controlPoints,2)] 
      "Value of the first derivative";
    output Real rdd[size(curve.spline.controlPoints,2)] 
      "Value of the second derivative";
  protected 
   Real s_loc=s "local path parameter";
    Real x[1];
    Real xd[1];
    Real xdd[1];
algorithm 
    
   if curve.arcLengthParam then
      (x,xd,xdd) := Modelica_Interpolation.Bspline1D.evaluateDer2(curve.
        arcSpline, s);
      s_loc := x[1];
      (r,rd,rdd) := Modelica_Interpolation.Bspline1D.evaluateDer2(curve.spline,
        s_loc);
      rd := rd*xd[1];
      rdd := rdd*(xd[1])^2 + rd*xdd[1];
      
   else
      (r,rd,rdd) := Modelica_Interpolation.Bspline1D.evaluateDer2(curve.spline,
        s_loc);
      
   end if;
    
end evaluateDer2;
  
end Curve;

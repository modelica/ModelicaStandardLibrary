within Modelica.Math;
package Random "Library of functions for random number generation"
  extends Modelica.Icons.Package;
  package Examples
    "Examples demonstrating the usage of the functions in package Random"
    extends Modelica.Icons.ExamplesPackage;
    model UniformRandomNumberSequence
      "Generates a sequence of uniformly distributed random numbers"
      extends Modelica.Icons.Example;
      parameter Real min = 2 "Minimum value";
      parameter Real max = 6 "Maximum value";
      parameter Types.Seed s0 = {15, 12, 50}
        "Seed for the random variate sequence";
      Types.Seed s(start = s0, each fixed = true)
        "State of random number generator";
      Real x "Random variate";
    equation
       when sample(0,1) then
         (x, s) = uniform(pre(s), min, max);
       end when;
       annotation(experiment(StopTime = 1000));
    end UniformRandomNumberSequence;

    model NormalRandomNumberSequence
      "Generates a sequence of normally distributed random numbers"
      extends Modelica.Icons.Example;
      parameter Real mu = 10 "Mean value";
      parameter Real sigma = 2 "Standard deviation";
      parameter Types.Seed s0 = {4, 10, 8}
        "Seed for the random variate sequence";
      Types.Seed s(start = s0, each fixed = true)
        "State of random number generator";
      discrete Real x "Random variate";
      discrete Real mu_s "Sample means";
      discrete Real sigma_s "Sample standard deviation";
      discrete Real cumsum(start = 0, fixed = true) "Cumulative sum of samples";
      discrete Real cumvar(start = 0, fixed = true)
        "Cumulative variance of samples";
      Integer N( start = 0, fixed = true) "Number of computed samples";
    equation
       when sample(0,1) then
         (x, s) = normal(pre(s), mu, sigma);
         cumsum = pre(cumsum) + x;
         cumvar = pre(cumvar) + x^2;
         N = pre(N)+1;
         mu_s = cumsum/N;
         sigma_s = sqrt(cumvar/N - mu_s^2);
       end when;
       annotation(experiment(StopTime = 5000));
    end NormalRandomNumberSequence;

    model Queue "Model of an M/M/1 queue"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Time T_c = 20
        "Average time interval between customers";
      parameter Modelica.SIunits.Time T_s = 8 "Average service time";
      constant Real eps = 1e-9 "Small constant to avoid division by zero";
      discrete Modelica.SIunits.Time next_arrival(start = 0, fixed = true)
        "Time of next customer arrival";
      discrete Modelica.SIunits.Time next_completed(start = 0, fixed = true)
        "Time of next service completion";
      Integer N "Number of customers currently in the queue";
      Integer N_t "Total number of customers that have entered the queue";
      Real N_a "Actual Average number of customers in the queue";
      Real N_a_th = T_s/(T_c - T_s)
        "Theoretical average number of customers in the queue at steady state";
      Types.Seed si(start = {10, 5, 100}, each fixed = true)
        "State of incoming customer random number generator";
      Types.Seed ss(start = {4, 12, 120}, each fixed = true)
        "State of service time random number generator";
      Modelica.SIunits.Time T_s_c "Current service time";
      Modelica.SIunits.Time T_n_c "Time to next customer arrival";
      Modelica.SIunits.Time T_c_s
        "Sample average time interval between customers";
      Modelica.SIunits.Time T_c_cumsum
        "Cumulative sum of time intervals between customers";
      Modelica.SIunits.Time N_int(start = 0, fixed = true)
        "Integral of N over time";
    equation
      der(N_int) = N;
      N_a = N_int/(time+eps);
    algorithm
      // New customer enters the queue
      when time > next_arrival then
        N := N + 1;
        N_t :=N_t + 1;
        (T_n_c, si) := exponential(si, 1/T_c);
        next_arrival :=time + T_n_c;
        T_c_cumsum :=T_c_cumsum + T_n_c;
        T_c_s :=T_c_cumsum/N_t;
        if N == 1 then
          (T_s_c, ss) := exponential(ss, 1/T_s);
          next_completed :=time + T_s_c;
        end if;
      end when;

      // Customer exits the queue when service is complete
      when N > 0 and time > next_completed then
        N := N - 1;
        (T_s_c, ss) := exponential(ss, 1/T_s);
        next_completed :=time + T_s_c;
      end when;

      annotation (experiment(StopTime=40000));
    end Queue;
  end Examples;

  package Types "Types and constants for random number generation functions"
    extends Modelica.Icons.TypesPackage;
    type Seed = Integer[3];
    constant Real NV_MAGICCONST=4*exp(-0.5)/sqrt(2.0);
  end Types;

  function uniform "Generates random numbers with a uniform distribution"
    extends Modelica.Icons.Function;
    input Types.Seed si "Input random seed";
    input Real min = 0 "Minimum value";
    input Real max = 1 "Maximum value";
    output Real x "Uniform random variate";
    output Types.Seed so "Output random seed";
  algorithm
    so[1] := abs(rem((171 * si[1]),30269));
    so[2] := abs(rem((172 * si[2]),30307));
    so[3] := abs(rem((170 * si[3]),30323));
    // zero is a poor Seed, therfore substitute 1;
    if so[1] == 0 then
      so[1] := 1;
    end if;
    if so[2] == 0 then
      so[2] := 1;
    end if;
    if so[3] == 0 then
      so[3] := 1;
    end if;
    x := rem((so[1]/30269.0 + so[2]/30307.0 + so[3]/30323.0),1.0)*(max-min) + min;
  end uniform;

  function normal
    "Generates random numbers with a normal (Gaussian) distribution"
    extends Modelica.Icons.Function;
    input Types.Seed si "Input random seed";
    input Real mu = 0 "Mean value";
    input Real sigma = 1 "Standard deviation";
    output Real x "Normal random variate";
    output Types.Seed so "Output random seed";
  protected
    Types.Seed s1, s2;
    Real z, zz, u1, u2;
  algorithm
    s1 := si;
    u2 := 1;
    while true loop
      (u1,s2) := uniform(s1);
      (u2,s1) := uniform(s2);
      z := Types.NV_MAGICCONST*(u1-0.5)/u2;
      zz := z*z/4.0;
      if zz <= (-log(u2)) then
        break;
      end if;
    end while;
    x := mu + z*sigma;
    so := s1;
  end normal;

  function exponential
    "Generates random numbers with an exponential distribution"
    extends Modelica.Icons.Function;
    input Types.Seed si "Input random seed";
    input Real lambda "Rate parameter";
    output Real x "Exponential random variate";
    output Types.Seed so "Output random seed";
  protected
    Real xu "Uniformly distributed random variate";
  algorithm
    (xu, so) := uniform(si);
    x := log(1 - xu)/(-lambda);
  end exponential;
  annotation (Documentation(info="<html>
<p>
This library contains function to compute random numbers. As Modelica
functions are pure, i.e., memoryless, all functions have a seed input,
and provide a seed output that must be used to compute the next value
in the sequence. In other words, the state of the random number generator
must be stored externally, e.g., as a discrete variable in a model.
</p>
</html>"));
end Random;

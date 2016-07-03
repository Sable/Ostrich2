function [U] = crnich(a, b, c, n, m)
%-----------------------------------------------------------------------
%
%   This function M-file finds the Crank-Nicholson solution
%   to the one-dimensional heat equation
%
%                   2
%           u (x, t)=c u  (x, t).
%            t        xx
%
%   The function u(x, t) denotes the temperature in a
%   one-dimensional metal rod as a function of both the
%   displacement x and the time t. The expression c^2 is the
%   thermal conductivity constant. The subscript t indicates
%   the partial derivative of u(x, t) with respect to time.
%   The subscript xx indicates the second partial derivative of
%   u(x, t) with respect to displacement.
%
%   The one-dimensional heat equation can be solved under a
%   variety of boundary conditions. This program considers
%   the following:
%
%       u(x, 0)=sin(pi*x)+sin(3*pi*x) for 0 < x < a,
%
%       u(0, t)=0, and u(a, t)=0 for 0 <= t <= b,
%
%   where a is the length of the rod, and b is the time duration.
%
%   For a concise background on the one-dimensional heat equation,
%   see "Modelling: Derivation of the Heat Equation" at
%   http://www-solar.mcs.st-and.ac.uk/~alan/MT2003/PDE/node20.html.
%
%   Invocation:
%       >> U=crnich(a, b, c, n, m)
%
%       where
%
%       i. a is the length of the metal rod,
%
%       i. b is the time duration,
%
%       i. c is the square root of the thermal
%          conductivity constant in the heat equation,
%
%       i. n is the number of grid points over [0, a],
%
%       i. m is the number of grid points over [0, b],
%
%       o. U is the solution matrix.
%
%   Requirements:
%       None.
%
%   Examples:
%       >> U=crnich(2.5, 1.5, 2, 321, 321)
%
%   Source:
%       Numerical Methods: MATLAB Programs,
%       (c) John H. Mathews, 1995.
%
%       Accompanying text:
%       Numerical Methods for Mathematics, Science and
%       Engineering, 2nd Edition, 1992.
%
%       Prentice Hall, Englewood Cliffs,
%       New Jersey, 07632, USA.
%
%       Also part of the FALCON project.
%
%   Author:
%       John H. Mathews (mathews@fullerton.edu).
%
%   Date:
%       March 1995.
%
%-----------------------------------------------------------------------
  C_PI = 3.14159265358979323846;
  mc_t130 = a;
  mc_t170 = 1;
  [mc_t131] = minus(n, mc_t170);
  [h] = rdivide(mc_t130, mc_t131);
  mc_t132 = b;
  mc_t171 = 1;
  [mc_t133] = minus(m, mc_t171);
  [k] = rdivide(mc_t132, mc_t133);
  mc_t172 = 2;
  [mc_t136] = power(c, mc_t172);
  mc_t137 = k;
  [mc_t134] = times(mc_t136, mc_t137);
  mc_t173 = 2;
  [mc_t135] = power(h, mc_t173);
  [r] = rdivide(mc_t134, mc_t135);
  mc_t174 = 2;
  [mc_t138] = rdivide(mc_t174, r);
  mc_t175 = 2;
  [s1] = plus(mc_t175, mc_t138);
  mc_t176 = 2;
  [mc_t139] = rdivide(mc_t176, r);
  mc_t177 = 2;
  [s2] = minus(mc_t139, mc_t177);
  [U] = zeros(n, m);
  mc_t178 = 1;
  [mc_t150] = minus(n, mc_t178);
  mc_t183 = 2;
  [i1] = colon(mc_t183, mc_t150);
  mc_t179 = 1;
  mc_t146 = h;
  mc_t180 = 3;
  mc_t181 = 1;
  mc_t182 = 1;
  [mc_t148] = times(C_PI, h);
  [mc_t149] = minus(i1, mc_t179);
  [mc_t144] = minus(i1, mc_t181);
  [mc_t145] = times(mc_t180, C_PI);
  [mc_t143] = times(mc_t145, mc_t146);
  [mc_t147] = times(mc_t148, mc_t149);
  [mc_t140] = sin(mc_t147);
  [mc_t142] = times(mc_t143, mc_t144);
  [mc_t141] = sin(mc_t142);
  [mc_t124] = plus(mc_t140, mc_t141);
  U(i1, mc_t182) = mc_t124;
  mc_t151 = s1;
  mc_t184 = 1;
  [mc_t152] = ones(mc_t184, n);
  [Vd] = times(mc_t151, mc_t152);
  mc_t185 = 1;
  mc_t186 = 1;
  Vd(mc_t186) = mc_t185;
  mc_t187 = 1;
  Vd(n) = mc_t187;
  mc_t188 = 1;
  [mc_t154] = minus(n, mc_t188);
  mc_t189 = 1;
  [mc_t153] = ones(mc_t189, mc_t154);
  [Va] = uminus(mc_t153);
  mc_t190 = 1;
  [mc_t127] = minus(n, mc_t190);
  mc_t191 = 0;
  Va(mc_t127) = mc_t191;
  mc_t192 = 1;
  [mc_t156] = minus(n, mc_t192);
  mc_t193 = 1;
  [mc_t155] = ones(mc_t193, mc_t156);
  [Vc] = uminus(mc_t155);
  mc_t194 = 0;
  mc_t195 = 1;
  Vc(mc_t195) = mc_t194;
  mc_t196 = 1;
  [Vb] = zeros(mc_t196, n);
  mc_t197 = 0;
  mc_t198 = 1;
  Vb(mc_t198) = mc_t197;
  mc_t199 = 0;
  Vb(n) = mc_t199;
  mc_t208 = 2;
  for j1 = (mc_t208 : m);
    mc_t200 = 1;
    [mc_t169] = minus(n, mc_t200);
    mc_t206 = 2;
    [i1] = colon(mc_t206, mc_t169);
    mc_t202 = 1;
    mc_t203 = 1;
    mc_t161 = i1;
    mc_t159 = s2;
    mc_t201 = 1;
    mc_t204 = 1;
    mc_t205 = 1;
    [mc_t167] = minus(i1, mc_t201);
    [mc_t166] = minus(j1, mc_t204);
    [mc_t162] = minus(j1, mc_t205);
    [mc_t168] = minus(j1, mc_t202);
    [mc_t165] = plus(i1, mc_t203);
    [mc_t160] = U(mc_t161, mc_t162);
    [mc_t164] = U(mc_t165, mc_t166);
    [mc_t163] = U(mc_t167, mc_t168);
    [mc_t158] = times(mc_t159, mc_t160);
    [mc_t157] = plus(mc_t163, mc_t164);
    [mc_t125] = plus(mc_t157, mc_t158);
    Vb(i1) = mc_t125;
    [X] = tridiagonal(Va, Vd, Vc, Vb, n);
    [mc_t126] = transpose(X);
    mc_t207 = 1;
    [mc_t128] = colon(mc_t207, n);
    mc_t129 = j1;
    U(mc_t128, mc_t129) = mc_t126;
  end
end
function [X] = tridiagonal(A, D, C, B, n)
%-----------------------------------------------------------------------
%
%   This function M-file finds the solution of a tridiagonal
%   linear system. It is assumed that D and B have dimension
%   n, and that A and C have dimension n-1.
%
%   Invocation:
%       >> X=tridiagonal(A, D, C, B)
%
%       where
%
%       i. A is a subdiagonal row vector,
%
%       i. D is a diagonal row vector,
%
%       i. C is the superdiagonal row vector,
%
%       i. B is the right-hand side row vector,
%
%       o. X is the solution row vector.
%
%   Requirements:
%       None.
%
%   Examples:
%       >> X=tridiagonal([1, 2, 3], [1, 2, 3, 4], ...
%       [1, 2, 3], [1, 2, 3, 4])
%
%   Source:
%       Numerical Methods: MATLAB Programs,
%       (c) John H. Mathews, 1995.
%
%       Accompanying text:
%       Numerical Methods for Mathematics, Science and
%       Engineering, 2nd Edition, 1992.
%
%       Prentice Hall, Englewood Cliffs,
%       New Jersey, 07632, USA.
%
%   Author:
%       John H. Mathews (mathews@fullerton.edu).
%
%   Date:
%       March 1995.
%
%-----------------------------------------------------------------------
% n=size(B, 2);
  mc_t242 = 2;
  for k = (mc_t242 : n);
    mc_t238 = 1;
    [mc_t216] = minus(k, mc_t238);
    [mc_t213] = A(mc_t216);
    mc_t239 = 1;
    [mc_t215] = minus(k, mc_t239);
    [mc_t214] = D(mc_t215);
    [mult] = rdivide(mc_t213, mc_t214);
    [mc_t217] = D(k);
    mc_t219 = mult;
    mc_t240 = 1;
    [mc_t221] = minus(k, mc_t240);
    [mc_t220] = C(mc_t221);
    [mc_t218] = times(mc_t219, mc_t220);
    [mc_t209] = minus(mc_t217, mc_t218);
    D(k) = mc_t209;
    [mc_t222] = B(k);
    mc_t224 = mult;
    mc_t241 = 1;
    [mc_t226] = minus(k, mc_t241);
    [mc_t225] = B(mc_t226);
    [mc_t223] = times(mc_t224, mc_t225);
    [mc_t210] = minus(mc_t222, mc_t223);
    B(k) = mc_t210;
  end
  mc_t243 = 1;
  [X] = zeros(mc_t243, n);
  [mc_t227] = B(n);
  [mc_t228] = D(n);
  [mc_t211] = rdivide(mc_t227, mc_t228);
  X(n) = mc_t211;
  mc_t244 = 1;
  [mc_t236] = minus(n, mc_t244);
  mc_t245 = 1;
  [mc_t237] = uminus(mc_t245);
  mc_t247 = 1;
  [k] = colon(mc_t236, mc_t237, mc_t247);
  mc_t246 = 1;
  [mc_t233] = C(k);
  [mc_t230] = D(k);
  [mc_t231] = B(k);
  [mc_t235] = plus(k, mc_t246);
  [mc_t234] = X(mc_t235);
  [mc_t232] = times(mc_t233, mc_t234);
  [mc_t229] = minus(mc_t231, mc_t232);
  [mc_t212] = rdivide(mc_t229, mc_t230);
  X(k) = mc_t212;
end

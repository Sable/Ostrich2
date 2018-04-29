function [cap] = capacitor(a, b, c, d, n, tol, rel)
%-----------------------------------------------------------------------
%
%   This function M-file computes the capacitance
%   per unit length of a coaxial pair of rectangles.
%
%   Invocation:
%       >> cap=capacitor(a, b, c, d, n, tol, rel)
%
%       where
%
%       i. a is the width of the inner conductor,
%
%       i. b is the height of the inner conductor,
%
%       i. c is the width of the outer conductor,
%
%       i. d is the height of the outer conductor,
%
%       i. n is the number of points along the x-axis,
%
%       i. tol is the tolerance,
%
%       i. rel is the relaxation parameter,
%
%       o. cap is the capacitance per unit length.
%
%   Requirements:
%       None.
%
%   Examples:
%       >> cap=capacitor(1, 2, 2, 3, 50, 1e-9, 1.90)
%
%   Source:
%       Computational Electromagnetics - EEK 170 course at
%       http://www.elmagn.chalmers.se/courses/CEM/.
%
%-----------------------------------------------------------------------
  mc_t172 = 0.5;
  [mc_t150] = times(mc_t172, c);
  mc_t151 = n;
  [h] = rdivide(mc_t150, mc_t151);
% Grid size.
  mc_t173 = 0.5;
  [mc_t153] = times(mc_t173, a);
  mc_t154 = h;
  [mc_t152] = rdivide(mc_t153, mc_t154);
  [na] = round(mc_t152);
%x=linspace(0, 0.5*c, n+1);
  mc_t174 = 0.5;
  [mc_t156] = times(mc_t174, d);
  mc_t157 = h;
  [mc_t155] = rdivide(mc_t156, mc_t157);
  [m] = round(mc_t155);
  mc_t175 = 0.5;
  [mc_t159] = times(mc_t175, b);
  mc_t160 = h;
  [mc_t158] = rdivide(mc_t159, mc_t160);
  [mb] = round(mc_t158);
%y=linspace(0, 0.5*d, m+1);
% Initialize potential and mask array.
  mc_t176 = 1;
  [mc_t161] = plus(n, mc_t176);
  mc_t177 = 1;
  [mc_t162] = plus(m, mc_t177);
  [f] = zeros(mc_t161, mc_t162);
  mc_t178 = 1;
  [mc_t165] = plus(n, mc_t178);
  mc_t179 = 1;
  [mc_t166] = plus(m, mc_t179);
  [mc_t163] = ones(mc_t165, mc_t166);
  mc_t164 = rel;
  [mask] = times(mc_t163, mc_t164);
  mc_t180 = 1;
  [mc_t168] = plus(na, mc_t180);
  mc_t185 = 1;
  [ii] = colon(mc_t185, mc_t168);
  mc_t181 = 1;
  mc_t184 = 1;
  mc_t183 = 1;
  mc_t182 = 0;
  [mc_t167] = plus(mb, mc_t181);
  [jj] = colon(mc_t184, mc_t167);
  f(ii, jj) = mc_t183;
  mask(ii, jj) = mc_t182;
  oldcap = 0;
  mc_t187 = 1;
  mc_t188 = 1000;
  for iter = (mc_t187 : mc_t188);
    [f] = seidel(f, mask, n, m, na, mb);
    [cap] = gauss(n, m, h, f);
    [mc_t171] = minus(cap, oldcap);
    [mc_t169] = abs(mc_t171);
    mc_t170 = cap;
    [mc_t148] = rdivide(mc_t169, mc_t170);
    [mc_t186] = lt(mc_t148, tol);
    if mc_t186
      break;
    else 
      oldcap = cap;
    end
  end
end
function [cap] = gauss(n, m, h, f)
%-----------------------------------------------------------------------
%
%   This function M-file computes capacitance from the
%   potential.
%
%   Invocation:
%       >> cap=gauss(n, m, h, f)
%
%       where
%
%       i. n is the number of points along the x-axis,
%
%       i. m is the number of points along the height of
%          the outer conductor,
%
%       i. f is the potential array,
%
%       i. h is the grid size,
%
%       o. cap is the capacitance.
%
%   Requirements:
%       None.
%
%   Source:
%       Computational Electromagnetics - EEK 170 course at
%       http://www.elmagn.chalmers.se/courses/CEM/.
%
%-----------------------------------------------------------------------
  q = 0;
  mc_t205 = 1;
  [ii] = colon(mc_t205, n);
  [mc_t192] = f(ii, m);
  mc_t204 = 0.5;
  mc_t203 = 1;
%mc_t189 = q;
  mc_t195 = m;
  [mc_t194] = plus(ii, mc_t203);
  [mc_t193] = f(mc_t194, mc_t195);
  [mc_t191] = plus(mc_t192, mc_t193);
  [mc_t190] = times(mc_t191, mc_t204);
%[q] = plus(mc_t189, mc_t190);
  [mc_sum0] = sum(mc_t190);
  [q] = plus(q, mc_sum0);
  mc_t208 = 1;
  [jj] = colon(mc_t208, m);
%mc_t196 = q;
  mc_t201 = n;
  [mc_t199] = f(n, jj);
  mc_t206 = 1;
  mc_t207 = 0.5;
  [mc_t202] = plus(jj, mc_t206);
  [mc_t200] = f(mc_t201, mc_t202);
  [mc_t198] = plus(mc_t199, mc_t200);
  [mc_t197] = times(mc_t198, mc_t207);
%[q] = plus(mc_t196, mc_t197);
  [mc_sum0] = sum(mc_t197);
  [q] = plus(q, mc_sum0);
  mc_t209 = 4;
  [cap] = times(q, mc_t209);
% Four quadrants.
  mc_t210 = 8.854187;
  [cap] = times(cap, mc_t210);
end
function [f] = seidel(f, mask, n, m, na, mb)
%-----------------------------------------------------------------------
%
%   This function M-file makes one Seidel iteration.
%
%   Invocation:
%       >> g=seidel(f, mask, n, m, na, mb)
%
%       where
%
%       i. f is the potential array,
%
%       i. mask is the mask array,
%
%       i. n is the number of points along the x-axis,
%
%       i. m is the number of points along the height of
%          the outer conductor,
%
%       i. na is the number of points along the width of
%          the inner conductor,
%
%       i. mb is the number of points along the height of
%          the inner conductor,
%
%       o. g is the updated potential array.
%
%   Requirements:
%       None.
%
%   Source:
%       Computational Electromagnetics - EEK 170 course at
%       http://www.elmagn.chalmers.se/courses/CEM/.
%
%-----------------------------------------------------------------------
  mc_t283 = 2;
  for ii = (mc_t283 : n);
    mc_t282 = 2;
    for jj = (mc_t282 : m);
      [mc_t214] = f(ii, jj);
      [mc_t216] = mask(ii, jj);
      mc_t277 = 1;
      [mc_t233] = minus(ii, mc_t277);
      mc_t234 = jj;
      [mc_t229] = f(mc_t233, mc_t234);
      mc_t278 = 1;
      [mc_t231] = plus(ii, mc_t278);
      mc_t232 = jj;
      [mc_t230] = f(mc_t231, mc_t232);
      [mc_t225] = plus(mc_t229, mc_t230);
      mc_t227 = ii;
      mc_t279 = 1;
      [mc_t228] = minus(jj, mc_t279);
      [mc_t226] = f(mc_t227, mc_t228);
      [mc_t221] = plus(mc_t225, mc_t226);
      mc_t223 = ii;
      mc_t280 = 1;
      [mc_t224] = plus(jj, mc_t280);
      [mc_t222] = f(mc_t223, mc_t224);
      [mc_t220] = plus(mc_t221, mc_t222);
      mc_t281 = 0.25;
      [mc_t218] = times(mc_t281, mc_t220);
      [mc_t219] = f(ii, jj);
      [mc_t217] = minus(mc_t218, mc_t219);
      [mc_t215] = times(mc_t216, mc_t217);
      [mc_t211] = plus(mc_t214, mc_t215);
      f(ii, jj) = mc_t211;
    end
  end
  ii = 1;
% Symmetry on left boundary ii-1 -> ii+1.
  mc_t289 = 2;
  for jj = (mc_t289 : m);
    [mc_t235] = f(ii, jj);
    [mc_t237] = mask(ii, jj);
    mc_t284 = 1;
    [mc_t254] = plus(ii, mc_t284);
    mc_t255 = jj;
    [mc_t250] = f(mc_t254, mc_t255);
    mc_t285 = 1;
    [mc_t252] = plus(ii, mc_t285);
    mc_t253 = jj;
    [mc_t251] = f(mc_t252, mc_t253);
    [mc_t246] = plus(mc_t250, mc_t251);
    mc_t248 = ii;
    mc_t286 = 1;
    [mc_t249] = minus(jj, mc_t286);
    [mc_t247] = f(mc_t248, mc_t249);
    [mc_t242] = plus(mc_t246, mc_t247);
    mc_t244 = ii;
    mc_t287 = 1;
    [mc_t245] = plus(jj, mc_t287);
    [mc_t243] = f(mc_t244, mc_t245);
    [mc_t241] = plus(mc_t242, mc_t243);
    mc_t288 = 0.25;
    [mc_t239] = times(mc_t288, mc_t241);
    [mc_t240] = f(ii, jj);
    [mc_t238] = minus(mc_t239, mc_t240);
    [mc_t236] = times(mc_t237, mc_t238);
    [mc_t212] = plus(mc_t235, mc_t236);
    f(ii, jj) = mc_t212;
  end
  jj = 1;
% Symmetry on lower boundary jj-1 -> jj+1.
  mc_t295 = 2;
  for ii = (mc_t295 : n);
    [mc_t256] = f(ii, jj);
    [mc_t258] = mask(ii, jj);
    mc_t290 = 1;
    [mc_t275] = minus(ii, mc_t290);
    mc_t276 = jj;
    [mc_t271] = f(mc_t275, mc_t276);
    mc_t291 = 1;
    [mc_t273] = plus(ii, mc_t291);
    mc_t274 = jj;
    [mc_t272] = f(mc_t273, mc_t274);
    [mc_t267] = plus(mc_t271, mc_t272);
    mc_t269 = ii;
    mc_t292 = 1;
    [mc_t270] = plus(jj, mc_t292);
    [mc_t268] = f(mc_t269, mc_t270);
    [mc_t263] = plus(mc_t267, mc_t268);
    mc_t265 = ii;
    mc_t293 = 1;
    [mc_t266] = plus(jj, mc_t293);
    [mc_t264] = f(mc_t265, mc_t266);
    [mc_t262] = plus(mc_t263, mc_t264);
    mc_t294 = 0.25;
    [mc_t260] = times(mc_t294, mc_t262);
    [mc_t261] = f(ii, jj);
    [mc_t259] = minus(mc_t260, mc_t261);
    [mc_t257] = times(mc_t258, mc_t259);
    [mc_t213] = plus(mc_t256, mc_t257);
    f(ii, jj) = mc_t213;
  end
end

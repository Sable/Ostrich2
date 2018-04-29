function [] = lgdr(x, n)
  [PNa] = PN_Legendre_vectN(x, n);
  [PNxa] = PNx_Legendre_vectN(x, n);
  [PNxxa] = PNxx_Legendre_vectN(x, n);
end
function [PNxxa] = PNxx_Legendre_vectN(x, n)
% This evaluates the  SECOND DERIVATIVE of the NORMALIZED, ORTHOGONORMAL
% Legendre polynomials P_{n)(x) for all degrees up to and including N.
% x may be either a scalar or a vector
% Input:  x = scalar or vector of grid points where Legendre polynomials
%             are to be evaluated.
%         n = degree of highest Legendre polynomial needed.
% Output: PNxxa is a  size(x) times (n+1) array
% Example:
%  let x = [0.1 0.3 ], n=3. Then the output will be the 2 x 4 array
%  PNxxa= | P_{0,xx}(x(1)=0.1) P_{1,xx}(x(1)) P_{2,xx}(x(1)) P_{3,xx}(x(1))|
%         | P_{0,xx}(x(2)=0.3) P_{1,xx}(x(2)) P_{2,xx}(x(2)) P_{3,xx}(x(2))|
%  P"_{n+3} = (1/(n+1))*{2(n+5/2)*x*P"_{n+2}-(n+4) P"_{n+1}}
  [mc_t274] = length(x);
  mc_t300 = 1;
  [mc_t275] = plus(n, mc_t300);
  [PNxxa] = zeros(mc_t274, mc_t275);
  mc_t301 = 0;
  mc_t302 = 1;
  PNxxa(:, mc_t302) = mc_t301;
  mc_t306 = 0;
  [mc_t305] = gt(n, mc_t306);
  if mc_t305
    mc_t303 = 0;
    mc_t304 = 2;
    PNxxa(:, mc_t304) = mc_t303;
  else 
  end
% if
  mc_t310 = 1;
  [mc_t309] = gt(n, mc_t310);
  if mc_t309
    mc_t307 = 3;
    mc_t308 = 3;
    PNxxa(:, mc_t308) = mc_t307;
  else 
  end
% if
  mc_t314 = 2;
  [mc_t313] = gt(n, mc_t314);
  if mc_t313
    [mc_t276] = transpose(x);
    mc_t311 = 15;
    [mc_t270] = times(mc_t311, mc_t276);
    mc_t312 = 4;
    PNxxa(:, mc_t312) = mc_t270;
  else 
  end
% if
  mc_t327 = 3;
  [mc_t326] = gt(n, mc_t327);
  if mc_t326
    mc_t315 = 3;
    [mc_t293] = minus(n, mc_t315);
    mc_t325 = 1;
    for j = (mc_t325 : mc_t293);
      mc_t316 = 1;
      [mc_t292] = plus(j, mc_t316);
      mc_t317 = 1;
      [mc_t277] = rdivide(mc_t317, mc_t292);
      mc_t290 = j;
      mc_t318 = 5;
      mc_t319 = 2;
      [mc_t291] = rdivide(mc_t318, mc_t319);
      [mc_t289] = plus(mc_t290, mc_t291);
      mc_t320 = 2;
      [mc_t287] = times(mc_t320, mc_t289);
      [mc_t288] = transpose(x);
      [mc_t284] = times(mc_t287, mc_t288);
      mc_t321 = 3;
      [mc_t286] = plus(j, mc_t321);
      [mc_t285] = PNxxa(:, mc_t286);
      [mc_t279] = times(mc_t284, mc_t285);
      mc_t322 = 4;
      [mc_t281] = plus(j, mc_t322);
      mc_t323 = 2;
      [mc_t283] = plus(j, mc_t323);
      [mc_t282] = PNxxa(:, mc_t283);
      [mc_t280] = times(mc_t281, mc_t282);
      [mc_t278] = minus(mc_t279, mc_t280);
      [mc_t271] = times(mc_t277, mc_t278);
      mc_t324 = 4;
      [mc_t273] = plus(j, mc_t324);
      PNxxa(:, mc_t273) = mc_t271;
    end
% j
  else 
  end
% if
  mc_t328 = 1;
  [mc_t299] = plus(n, mc_t328);
  mc_t331 = 1;
  for j = (mc_t331 : mc_t299);
    [mc_t294] = PNxxa(:, j);
    mc_t297 = j;
    mc_t329 = 1;
    mc_t330 = 2;
    [mc_t298] = rdivide(mc_t329, mc_t330);
    [mc_t296] = minus(mc_t297, mc_t298);
    [mc_t295] = sqrt(mc_t296);
    [mc_t272] = times(mc_t294, mc_t295);
    PNxxa(:, j) = mc_t272;
  end
% j
end
function [PNxa] = PNx_Legendre_vectN(x, n)
% This evaluates the FIRST DERIVATIVE of the NORMALIZED, ORTHOGONORMAL
% Legendre polynomials P_{n)(x) for all degrees up to and including N.
% x may be either a scalar or a vector.
% Input:  x = scalar or vector of grid points where Legendre polynomials
%             are to be evaluated.
%         n = degree of highest Legendre polynomial needed.
% Output: PNxa is a  size(x) times (n+1) array
% Example:
%  let x = [0 0.3 0.9], n=3. Then the output will be the 3x4 array
%  PNxa = |dP_0/dx(x(1)=0)   dP_{1}/dx(x(1)) dP_{2}/dx(x(1)) dP_{3}/dx(x(1))|
%         |dP_0/dx(x(2)=0.3) dP_{1}/dx(x(2)) dP_{2}/dx(x(2)) dP_{3}/dx(x(2))|
%         |dP_0/dx(x(3)=0.9) dP_{1}/dx(x(3)) dP_{2}/dx(x(3)) dP_{3}/dx(x(3))|
  [mc_t216] = length(x);
  mc_t242 = 1;
  [mc_t217] = plus(n, mc_t242);
  [PNxa] = zeros(mc_t216, mc_t217);
  mc_t243 = 0;
  mc_t244 = 1;
  PNxa(:, mc_t244) = mc_t243;
  mc_t248 = 0;
  [mc_t247] = gt(n, mc_t248);
  if mc_t247
    mc_t245 = 1;
    mc_t246 = 2;
    PNxa(:, mc_t246) = mc_t245;
  else 
  end
% if
  mc_t252 = 1;
  [mc_t251] = gt(n, mc_t252);
  if mc_t251
    [mc_t218] = transpose(x);
    mc_t249 = 3;
    [mc_t212] = times(mc_t249, mc_t218);
    mc_t250 = 3;
    PNxa(:, mc_t250) = mc_t212;
  else 
  end
% if
  mc_t265 = 2;
  [mc_t264] = gt(n, mc_t265);
  if mc_t264
    mc_t253 = 2;
    [mc_t235] = minus(n, mc_t253);
    mc_t263 = 1;
    for j = (mc_t263 : mc_t235);
      mc_t254 = 1;
      [mc_t234] = plus(j, mc_t254);
      mc_t255 = 1;
      [mc_t219] = rdivide(mc_t255, mc_t234);
      mc_t232 = j;
      mc_t256 = 3;
      mc_t257 = 2;
      [mc_t233] = rdivide(mc_t256, mc_t257);
      [mc_t231] = plus(mc_t232, mc_t233);
      mc_t258 = 2;
      [mc_t229] = times(mc_t258, mc_t231);
      [mc_t230] = transpose(x);
      [mc_t226] = times(mc_t229, mc_t230);
      mc_t259 = 2;
      [mc_t228] = plus(j, mc_t259);
      [mc_t227] = PNxa(:, mc_t228);
      [mc_t221] = times(mc_t226, mc_t227);
      mc_t260 = 2;
      [mc_t223] = plus(j, mc_t260);
      mc_t261 = 1;
      [mc_t225] = plus(j, mc_t261);
      [mc_t224] = PNxa(:, mc_t225);
      [mc_t222] = times(mc_t223, mc_t224);
      [mc_t220] = minus(mc_t221, mc_t222);
      [mc_t213] = times(mc_t219, mc_t220);
      mc_t262 = 3;
      [mc_t215] = plus(j, mc_t262);
      PNxa(:, mc_t215) = mc_t213;
    end
% j
  else 
  end
% if
  mc_t266 = 1;
  [mc_t241] = plus(n, mc_t266);
  mc_t269 = 1;
  for j = (mc_t269 : mc_t241);
    [mc_t236] = PNxa(:, j);
    mc_t239 = j;
    mc_t267 = 1;
    mc_t268 = 2;
    [mc_t240] = rdivide(mc_t267, mc_t268);
    [mc_t238] = minus(mc_t239, mc_t240);
    [mc_t237] = sqrt(mc_t238);
    [mc_t214] = times(mc_t236, mc_t237);
    PNxa(:, j) = mc_t214;
  end
% j
end
function [PNa] = PN_Legendre_vectN(x, n)
% This evaluates the NORMALIZED, ORTHOGONORMAL Legendre polynomials
% P_{n)(x) for all degrees up to and including n. x may be either
% a scalar or a vector.
% Input:  x = scalar or vector of grid points where Legendre polynomials
%             are to be evaluated.
%         n = degree of highest Legendre polynomial needed.
% Output: PNa is a size(x) times (n+1) array
% Example:
%  let x = [0 0.3 0.9], n=3. Then the output will be the 3x4 array
%  PNa = | P_0(x(1)=0)   P_{1}(x(1))  P_{2}(x(1))  P_{3}(x(1)) |
%        | P_0(x(2)=0.3) P_{1}(x(2))  P_{2}(x(2))  P_{3}(x(2)) |
%        | P_0(x(3)=0.9) P_{1}(x(3))  P_{2}(x(3))  P_{3}(x(3)) |
  [mc_t170] = length(x);
  mc_t192 = 1;
  [mc_t171] = plus(n, mc_t192);
  [PNa] = zeros(mc_t170, mc_t171);
  mc_t193 = 1;
  mc_t194 = 1;
  PNa(:, mc_t194) = mc_t193;
  mc_t197 = 0;
  [mc_t196] = gt(n, mc_t197);
  if mc_t196
    [mc_t166] = transpose(x);
    mc_t195 = 2;
    PNa(:, mc_t195) = mc_t166;
  else 
  end
% if
  mc_t207 = 1;
  [mc_t206] = gt(n, mc_t207);
  if mc_t206
    mc_t198 = 1;
    [mc_t185] = minus(n, mc_t198);
    mc_t205 = 1;
    for j = (mc_t205 : mc_t185);
      mc_t199 = 1;
      [mc_t184] = plus(j, mc_t199);
      mc_t200 = 1;
      [mc_t172] = rdivide(mc_t200, mc_t184);
      mc_t201 = 2;
      [mc_t183] = times(mc_t201, j);
      mc_t202 = 1;
      [mc_t181] = plus(mc_t183, mc_t202);
      [mc_t182] = transpose(x);
      [mc_t178] = times(mc_t181, mc_t182);
      mc_t203 = 1;
      [mc_t180] = plus(j, mc_t203);
      [mc_t179] = PNa(:, mc_t180);
      [mc_t174] = times(mc_t178, mc_t179);
      mc_t176 = j;
      [mc_t177] = PNa(:, j);
      [mc_t175] = times(mc_t176, mc_t177);
      [mc_t173] = minus(mc_t174, mc_t175);
      [mc_t167] = times(mc_t172, mc_t173);
      mc_t204 = 2;
      [mc_t169] = plus(j, mc_t204);
      PNa(:, mc_t169) = mc_t167;
    end
% j
  else 
  end
% if
  mc_t208 = 1;
  [mc_t191] = plus(n, mc_t208);
  mc_t211 = 1;
  for j = (mc_t211 : mc_t191);
    [mc_t186] = PNa(:, j);
    mc_t189 = j;
    mc_t209 = 1;
    mc_t210 = 2;
    [mc_t190] = rdivide(mc_t209, mc_t210);
    [mc_t188] = minus(mc_t189, mc_t190);
    [mc_t187] = sqrt(mc_t188);
    [mc_t168] = times(mc_t186, mc_t187);
    PNa(:, j) = mc_t168;
  end
% j
end

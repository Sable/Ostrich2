function [pageRanks, t, maxDiff] = pagerank(iter, thresh, pages, noutlinks, pageRanks, n)
  maxDiff = 99;
  dFactor = 0.85;
  mc_t35 = 1;
  for t = (mc_t35 : iter);
    [mc_t29] = lt(maxDiff, thresh);
    if mc_t29
      break;
    else 
    end
% map_page_rank
    mc_t31 = 1;
    for i = (mc_t31 : n);
      [mc_t19] = pageRanks(i);
      [mc_t20] = noutlinks(i);
      [outbounRank] = rdivide(mc_t19, mc_t20);
      mc_t30 = 1;
      [k] = colon(mc_t30, n);
      mc_t22 = outbounRank;
      [mc_t21] = pages(i, k);
      [mc_t18] = times(mc_t21, mc_t22);
      maps(i, k) = mc_t18;
    end
% reduce_page_rank
    dif = 0;
    mc_t34 = 1;
    for j = (mc_t34 : n);
      [oldRank] = pageRanks(j);
      [mc_t23] = maps(:, j);
      [newRank] = sum(mc_t23);
      mc_t32 = 1;
      [mc_t26] = minus(mc_t32, dFactor);
      mc_t27 = n;
      [mc_t24] = rdivide(mc_t26, mc_t27);
      [mc_t25] = times(dFactor, newRank);
      [newRank] = plus(mc_t24, mc_t25);
      [mc_t28] = minus(newRank, oldRank);
      [newDif] = abs(mc_t28);
      [mc_t33] = gt(newDif, dif);
      if mc_t33
        dif = newDif;
      else 
      end
      pageRanks(j) = newRank;
    end
    maxDiff = dif;
  end
end

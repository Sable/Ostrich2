function [res] = spmv_core_loop(dim, csr_num_rows, csr_Ap, csr_Ax, csr_Aj, vec)
  mc_t16 = 1;
  [tot] = zeros(mc_t16, dim);
  mc_t17 = 1;
  [res] = zeros(mc_t17, dim);
  mc_t19 = 1;
  for row = (mc_t19 : csr_num_rows);
    [row_start] = csr_Ap(row);
    mc_t18 = 1;
    [mc_t10] = plus(row, mc_t18);
    [row_end] = csr_Ap(mc_t10);
    temp = 0;
    [jj] = colon(row_start, row_end);
    [mc_t15] = csr_Aj(jj);
    [mc_t13] = csr_Ax(jj);
    [mc_t14] = vec(mc_t15);
    [mc_t12] = times(mc_t13, mc_t14);
    [mc_sum0] = sum(mc_t12);
    [temp] = plus(temp, mc_sum0);
    res(row) = temp;
  end
end

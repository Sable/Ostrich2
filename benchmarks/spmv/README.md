SPMV (Sparse Matrix-Vector Multiplication)
===========================================

Compressed Sparse Row, or CSR, is a format for storing sparse matrices by storing only non-zero values and their positions. CSR uses three different
arrays to accomplish this. The first stores only the non-zero values from the matrix, from left to right then top to bottom.  The second array hold holds the column position for each value in the first array. The third array holds the locations within the first array that correspond to the start of a new row. CSR allows for a large amount of space saving, but using one in an algorithm requires a step to process the data.

function arrayTests
	assertEqual([1 2], [1 2])
	assertEqual(size([]), [0,0])
	assertEqual(size([1 2 3]), [1 3])
	assertEqual(size([1 2; 3 4]), [2, 2])
	assertEqual(size([1; 2; 3]), [3,1])

	a = [1 2 3; 4 5 6];
	assertEqual(a(1), 1)
	assertEqual(a(2), 4)
	assertEqual(a(4), 5)
	assertEqual(a(6), 6)
	assertEqual(a(1,1), 1)
	assertEqual(a(1,3), 3)
	assertEqual(a(2,1), 4)
	assertEqual(a(2,3), 6)


	% TODO: Add matrix literals with inconsistent dimensions

end
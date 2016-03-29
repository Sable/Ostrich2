function arrayTests
	assertEqual([1 2], [1 2])
	assertEqual(size([]), [0,0])
	assertEqual(size([1 2 3]), [1 3])

	% TODO: Add matrix literals with inconsistent dimensions

end
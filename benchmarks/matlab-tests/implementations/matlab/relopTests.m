function relopTests
% relational operator tests
    assertEqual(0<1, 1);
    assertEqual(1<0, 0);
    assertEqual(0>1, 0);
    assertEqual(1>0, 1);
    assertEqual(1>=0, 1);
    assertEqual(0>=1, 0);
    assertEqual(0>=0, 1);
    assertEqual(1<=0, 0);
    assertEqual(0<=1, 1);
    assertEqual(0<=0, 1);
    assertEqual(0==0, 1);
    assertEqual(0==1, 0);
    assertEqual(0~=1, 1);
    assertEqual(0~=0, 0);
end

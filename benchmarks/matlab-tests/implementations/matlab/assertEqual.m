function assertEqual(x,y)
    if (x ~= y) 
        disp('assertEqual failed');
        disp('argument 1:');
        disp(x);
        disp('is not equal to argument 2:');
        disp(y);
        error('failed');
    end
end

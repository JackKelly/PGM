function pass = CompareVectors(test, target)

    if (min(size(test) == size(target)) == 0)
        disp('**********FAIL*******');
        disp('Test vector is not the same size as the target vector.');
        fprintf('    test vector size = %d*%d \n', size(test,1),   size(test,2)   );
        fprintf('  target vector size = %d*%d \n', size(target,1), size(target,2) );
        pass = 0;
        return;
    end

    tolerance  = 0.0001;
    comparison = abs( test - target ) < tolerance;
    pass = 1;
    if (min(comparison)==0)
        disp('******FAIL:************');

        fprintf('\nindex     =');
        fprintf('%3d,', [1:length(target)]);
        
        fprintf('\ncomparison=');
        fprintf('%3d,', comparison);
        
        fprintf('\ntest      =');
        fprintf('%1.1f,', test);
        
        fprintf('\ntarget    =');
        fprintf('%1.1f,', target);
        
        fprintf('\n');
        
        pass = 0;
    end
    
end
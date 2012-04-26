function success = CompareFactors(test, target, verbose)
% CompareFactors( test, target, verbose )

    if(~exist('verbose','var'))
        verbose = 0;
    end

    passed = zeros(1,3);
    
    if verbose
        fprintf('Comparing factors.  Target factor is for vars ');
        fprintf('%2d,', target.var);
        fprintf('\n\n');

        fprintf('  Comparing var... ');
    end
    passed(1) = CompareVectors(test.var, target.var);
    printResult( passed(1), verbose );
    
    if verbose, fprintf('  Comparing card...'); end;
    passed(2) = CompareVectors(test.card, target.card);
    printResult( passed(2), verbose );
    
    if verbose, fprintf('  Comparing val... '); end;
    passed(3) = CompareVectors(test.val, target.val);
    printResult( passed(3), verbose );
    
    if (min(passed) == 1)
        success = 1;
        if verbose
            fprintf('\nThis factor has passed all tests! \n');
        end
    else
        success = 0;
        fprintf('\n*******This factor has FAILED*****\n');
        fprintf('Target factor is for vars ');
        fprintf('%2d,', target.var);
        fprintf('\n');        
        fprintf('\nIndividual tests (1 is pass, 0 is fail): \n');
        fprintf('  var : %d \n  card: %d \n  val : %d \n\n', passed);
    end
    
end

function printResult( result, verbose )
    if verbose == 0
        return
    end
    
    if (result)
        fprintf(' passed \n');
    end
end
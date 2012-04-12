function success = CompareFactors(test, target)
% CompareFactors( test, target )

    passed = zeros(1,3);
    
    fprintf('Comparing factors.  Target factor is for vars ');
    fprintf('%2d,', target.var);
    fprintf('\n\n');

    fprintf('  Comparing var... ');
    passed(1) = CompareVectors(test.var, target.var);
    printResult( passed(1) );
    
    fprintf('  Comparing card...');
    passed(2) = CompareVectors(test.card, target.card);
    printResult( passed(2) );
    
    fprintf('  Comparing val... ');
    passed(3) = CompareVectors(test.val, target.val);
    printResult( passed(3) );
    
    if (min(passed) == 1)
        success = 1;
        fprintf('\nThis factor has passed all tests! \n');
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

function printResult( result )
    if (result)
        fprintf(' passed \n');
    end
end
function success = CompareFactorArrays( test, target, verbose )
% success = CompareFactorArray( test, target, verbose )

if(~exist('verbose','var'))
    verbose = 0;
end

[M N] = size(test);

if (min(size(test) == size(target)) == 0)
    disp('Test and Target arrays are of different sizes.');
    fprintf('Test size: %d*%d \nTarget size: %d*%d \n\n', size(test), size(target));
    success = 0;
    return;
end

results = zeros(M,N);

for i = 1:M
    for j = 1:N
        if verbose
            fprintf('----------------------------\n');
            fprintf('TESTING FACTOR %d,%d... \n', i,j);
        end
        results(i,j) = CompareFactors(test(i,j), target(i,j), verbose);
    end
end

fprintf('===============================\n');

if (min(results)==0)
    fprintf('%d factors failed, specifically factor(s): ', sum(sum(results==0)));
    fprintf('%2d,', find(results == 0));
    fprintf('\n\n');
    success = 0;
else
    fprintf('All %d factors passed! \n\n', N);
    success = 1;
end
    

end


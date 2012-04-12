function CompareFactorArrays( test, target )
% CompareFactorArray( test, target )

n = length(test);

if (min(size(test) == size(target)) == 0)
    disp('Test and Target arrays are of different sizes.');
    fprintf('Test size: %d*%d \nTarget size: %d*%d \n\n', size(test), size(target));
    return;
end

results = zeros(1,n);

for i = 1:n
    fprintf('----------------------------\n');
    fprintf('TESTING FACTOR NUMBER %d... \n', i);
    results(i) = CompareFactors(test(i), target(i));
end

fprintf('===============================\n');

if (min(results)==0)
    fprintf('%d factors failed, specifically factor(s): ', sum(results==0));
    fprintf('%2d,', find(results == 0));
    fprintf('\n\n');
else
    fprintf('All %d factors passed! \n\n', n);
end
    

end


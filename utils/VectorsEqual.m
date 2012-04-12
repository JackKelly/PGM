function equal = VectorsEqual(A, B)
% equal = VectorsEqual(A, B)
% Returns true if vectors A and B are exactly

if ~vectorsEqualNoSizeCheck( size(A), size(B) )
    equal = 0;
else
    equal = vectorsEqualNoSizeCheck(A, B);
end
end

function equal = vectorsEqualNoSizeCheck(A, B)

% Are both vectors empty?
if (isempty(A) && isempty(B))
    equal = 1;
    return;
end

equal = min( A == B )==1;
end
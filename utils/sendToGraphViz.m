function sendToGraphViz(name, G, F)
% sendToGraphViz(name, G, F)
%
% Inputs:
%
% name - First part of output file name. Do not append a suffix. 
%        sendToGraphViz will append '.gv'
%
% G    - a graph data structure.  Must contain at least a .edges matrix.
%        Can optionally contain a var2factors cell array.
%
% F    - a struct array of factors (optional)
%
% Writes a name.gv dot file and processes it with graphviz to produce
% a name.png image file.

outputFileName = strcat(name, '.gv');
fid = fopen(outputFileName, 'w+');

fprintf(fid, 'graph %s { \n', name);
fprintf(fid, '    rankdir=LR; \n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output node names (if they exist)
if isfield(G, 'names') % Does G have a 'names' field?
    fprintf(fid, '    node [shape = circle]; \n');
    for i=1:length(G.names)
        fprintf(fid, '%d [label="%s \\n%s"]; \n ', i, G.names{i}, nodeLabel(i)); 
    end
    % fprintf(fid, ';\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output undirected edges
pairs = [];
for i=1:size(G.edges, 1)
    neighbours = find(G.edges(i,:));
    for neighbour = neighbours
        if isempty(pairs) || ...
           max(ismember(pairs, [neighbour i], 'rows'))==0  % check we haven't done this edge already
           
            fprintf(fid, '    %d -- %d [label="%s"]; \n', i, neighbour, edgeLabel(i, neighbour));
        end
        pairs = [pairs; i neighbour];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(fid, '}\n');
fclose(fid);

imageFileName = strcat(name, '.png');
[status, result] = system(['dot -Tpng ' outputFileName ' > ' imageFileName]);

if status == 0
    fprintf('dot ran successfully!\n')
    fprintf('There should now be a %s graphviz file\n and a %s image file in the current directory.\n\n'...
        , outputFileName,  imageFileName);
else
    fprintf('ERROR: GraphViz failed.  Result: \n');
    disp(result);
end

function label = edgeLabel(sourceIndex, destIndex)
    if ~isfield(G,'var2factors') || ~exist('F','var'), label=''; return; end;
        
    factors = G.var2factors{sourceIndex};
    for factor = factors
        if isequal(F(factor).var, [sourceIndex destIndex])
            label = sprintf('%1.1f\\n', F(factor).val);
        end
    end
end

function label = nodeLabel(node)
    if ~isfield(G,'var2factors') || ~exist('F', 'var'), label=''; return; end;
    
    factors = G.var2factors{node};
    label = '';
    for factor = factors
        if isequal(F(factor).var, node)
            for a = 1:F(factor).card
                label = [label sprintf('%d %1.1f\\n', a, F(factor).val(a))];
            end
        end
    end    
end

end
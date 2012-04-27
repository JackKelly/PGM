function sendToGraphViz(name, G, F, size)
% sendToGraphViz(name, G, F, size)
%
% INPUTS:
%
% name - (required) First part of output file name. Do not append a suffix. 
%        sendToGraphViz will append '.gv'
%
% G    - a graph data structure with the following fields:
%        .edges matrix (required)
%        .var2factors cell array (optional)
%
% F    - (optional) a struct array of factors.
%        If G includes a .var2factors cell array then F must by supplied
%        and visa-versa.
%
% size - (optional) a string of the form "8,5" describing the max size of
%        the generated image file.  Defaults to "8,5"
%
% Writes a name.gv dot file and processes it with graphviz to produce
% a name.png image file.
%
% THIS SCRIPT REQUIRES GRAPHVIZ!
% http://www.graphviz.org/
% To install on Ubuntu, type: sudo apt-get install graphviz
%
% ------------------------
%
% VERY SIMPLE EXAMPLE:
%    T.edges = [1 0; 0 1];  % create a simple edges matrix
%    sentToGraphViz('simple', T);
%
% This will produce a 'simple.gv' do file and a 'simple.png' image file.
%
% ------------------------
%
% MORE INTERESTING EXAMPLE:
%    [G, F] = ConstructToyNetwork( 1.0, 0.1 ); % from PA5
%    sendToGraphViz('toyImageNet', G, F)


gvFileName = strcat(name, '.gv');
fid = fopen(gvFileName, 'w+');

fprintf(fid, 'graph %s { \n', name);
fprintf(fid, '    rankdir=LR; \n');

if ~exist('size', 'var')
    size = '8,5';
end
fprintf(fid, '    size="%s"; \n', size); % modify size if required

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output node names (if they exist)
if isfield(G, 'names') % Does G have a 'names' field?
    fprintf(fid, '    node [shape = circle]; \n');
    for i=1:length(G.names)
        fprintf(fid, '%d [label="%s \\n%s"]; \n ', i, G.names{i}, nodeLabel(i)); 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output undirected edges
pairs = [];
numNodes = length(G.edges);
for i=1:numNodes
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
[status, result] = system(['dot -Tpng ' gvFileName ' > ' imageFileName]);

if status == 0
    fprintf('dot ran successfully!\n')
    fprintf('There should now be a %s graphviz file\n and a %s image file in the current directory.\n\n'...
        , gvFileName,  imageFileName);
    fprintf('Try copying-and-pasting the following URI into\n a web browser (might not work on Windows):\n');
    fprintf('file://%s/%s\n', pwd, imageFileName);
else
    fprintf('ERROR: GraphViz failed.  GraphViz complained that: \n');
    disp(result);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helper functions:
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
function displayWord(wordIndex)
% Displays the bitmaps 

load('PA3Data.mat');
numChars = length( allWords{wordIndex} );

figure;
colormap([1 1 1; 0 0 0]); % define a monochrome colour map

% Loop through each character in the word
for charIndex = 1:numChars
    subplot(1, numChars, charIndex);
    
    image( allWords{wordIndex}(charIndex).img + 1); % we need the +1
    % because the .img matrix contains values which are 0 or 1;
    % but colour maps are indexed starting at 1.
    
    axis equal;
    set(gca, 'XLim', [0.5 8.5], 'YLim', [0.5 16.5], 'XTick', [], 'YTick', []);
    title( char( allWords{wordIndex}(charIndex).groundTruth + 'a' - 1 ) );
end

end
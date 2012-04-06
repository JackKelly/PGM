function displayWord(wordIndex)
% displayWord( wordIndex )
% 
% Displays the bitmaps from the PA3Data.mat file, along with the
% groundTruth character as a title.  Displays the word for the 
% corresponding wordIndex.
%
% This script must be run in the directory containing PA3Data.mat
%
% Based on code from Timothy Vaughan and Mihaly Barasz:
% https://class.coursera.org/pgm/forum/thread?thread_id=967

load('PA3Data.mat');
numChars = length( allWords{wordIndex} );

figure;
colormap([1 1 1; 0 0 0]); % define a monochrome colour map

% Loop through each character in the word
for charIndex = 1:numChars

    % Create enough subplots for each character and select
    % the required subplot for the current character.
    subplot(1, numChars, charIndex);

    % Display the character bitmap as an image
    % using the colormap defined above.
    image( allWords{wordIndex}(charIndex).img + 1); % we need the +1
    % because the .img matrix contains values which are 0 or 1;
    % but colour maps are indexed starting at 1.

    % Format the image
    axis equal;
    set(gca, 'XLim', [0.5 8.5], 'YLim', [0.5 16.5], 'XTick', [], 'YTick', []);
    title( char( allWords{wordIndex}(charIndex).groundTruth + 'a' - 1 ) );
end

end
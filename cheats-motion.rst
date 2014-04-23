http://jmcpherson.org/editing.html

]p      paste and adjust indent to match context
%       match brace, bracket, parenthesis
gd      got definition or declaration

<C-F>  	Move the cursor forward by a screenful of text
<C-B> 	Move the cursor backward by a screenful of text
G 	Move the cursor to the end of the file
numG 	Move the cursor line num. (For instance, 10G moves to line 10.)
gg 	Move the cursor to the beginning of the file
H 	Move the cursor to the top of the screen.
M 	Move the cursor to the middle of the screen.
L 	Move the cursor to the bottom of the screen.
* 	Read the string under the cursor and go to the next place it appears.
# 	Same as above, except it moves the cursor to the previous occurance.
/text 	search for 'text', starting at cursor, n re-executes last search.
?text 	Same as /, but searches in the opposite direction.
ma 	make a bookmark 'a' at the cursor. any lowercase letter.
`a      Go to bookmark a. Important: that's a backtick, not a single quote.
`. 	Go to the line that you last edited. 

commands that enter insert mode from command mode

i  	Insert text to the left of the current character.
I 	Insert text at the beginning of the current line.
a 	Insert text to the right of the current character.
A 	Insert text at the end of the current line.
o 	Create a new line under the current one and insert text there.
O 	Create a new line above the current one and insert text there.

c{motion} 	Delete (change) the text moved over by {motion} and insert text to replace it. For instance, c$ would delete the text from the cursor to the end of the line and enter insert mode. ct! would delete the text from the cursor up to (but not including) the next exclamation mark and enter insert mode. The deleted text is copied to the clipboard and can be pasted.

d{motion} 	Delete the text moved over by {motion} -- same as c{motion}, but doesn't enter insert mode.

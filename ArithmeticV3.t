%Javin liu
%Arithmetic V2
%20/10/20

%Play background music
%Music.PlayFileLoop ("musicTuring.mp3")

%vars
var mousex, mousey, mouseDown : int
var number1, number2, answer : real
var concatenate : string
var count : int := 0
var numberOfQuestions : int
var difficultyLevel : int := 0
var devAnswer : int
var operator : string

%Fonts
var font1, font2, font3 : int
font1 := Font.New ("times new roman:25")
font2 := Font.New ("serif:12")
font3 := Font.New ("times new roman:8")

%io stream
var stream : int
var answerPosition : int
var answerString : string
var answerPrevious : real 
var answerPath : string := "Answers.txt"
open : stream, answerPath, put, get, seek, mod




%Screen size
View.Set ("graphics:520;220; nobuttonbar;position:middle;middle")

%Correct sound function
procedure playCorrect
    play (">g g g g g")
end playCorrect

%Incorrect sound function
procedure playIncorrect
    play ("<g f e d c ")
end playIncorrect

%Happy face function
procedure happyFace
    drawfilloval (67, 150, 20, 20, yellow)
    drawoval (67, 150, 21, 21, black)
    drawarc (67, 150, 15, 15, 230, 330, black)
    drawfilloval (74, 155, 3, 3, black)
    drawfilloval (60, 155, 3, 3, black)
end happyFace

%Sad face fucntion
procedure sadFace
    drawfilloval (67, 150, 20, 20, 11)
    drawoval (67, 150, 21, 21, black)
    drawarc (67, 135, 10, 10, 50, 150, black)
    drawfilloval (74, 155, 3, 3, black)
    drawfilloval (60, 155, 3, 3, black)
end sadFace

%Next question function
procedure nextQuestion
    loop
	Mouse.Where (mousex, mousey, mouseDown)
	drawbox (410, 183, 507, 109, black)
	Font.Draw ("Next question", 426, 146, font3, white)
	delay (50)
	if mousex > 410 and mousex < 507 and mousey > 109 and mousey < 183 then
	    drawfillbox (410, 183, 507, 109, red)
	else
	    drawfillbox (410, 183, 507, 109, 39)
	end if
	exit when mousex > 410 and mousex < 507 and mousey > 109 and mousey < 183 and mouseDown = 1
    end loop
end nextQuestion

procedure finalQuestion
    loop
	Mouse.Where (mousex, mousey, mouseDown)
	drawbox (410, 183, 507, 109, black)
	Font.Draw ("Final answer", 430, 146, font3, white)
	delay (50)
	if mousex > 410 and mousex < 507 and mousey > 109 and mousey < 183 then
	    drawfillbox (410, 183, 507, 109, red)
	else
	    drawfillbox (410, 183, 507, 109, 39)
	end if
	exit when mousex > 410 and mousex < 507 and mousey > 109 and mousey < 183 and mouseDown = 1
    end loop
end finalQuestion


%Drawborder function
procedure colorBorder (bottomx : int)
    drawfillbox (1, 215, 520, 205, green)
    drawfillbox (1, bottomx, 520, bottomx - 10, green)
end colorBorder

%===================================================================%
%==============================Start================================%
%===================================================================%

%Start GUI
loop
    Mouse.Where (mousex, mousey, mouseDown)
    drawbox (129, 54, 391, 166, black)
    locate (6, 32)
    Font.Draw ("Start", 227, 120, font1, white)
    Font.Draw ("Arithmetic 3.0", 170, 80, font1, white)
    delay (50)
    exit when mousex > 130 and mousex < 390 and mousey > 55 and mousey < 165 and mouseDown = 1
    %Draw snow
    var flakex : array 1 .. 60 of int
    var flakey : array 1 .. 60 of int

    for flake : 1 .. 60
	flakex (flake) := Rand.Int (0, 520)
	flakey (flake) := Rand.Int (0, 220)
    end for
    Draw.FillBox (0, 0, 520, 220, green)

    for flake : 1 .. 60
	flakey (flake) := -Rand.Int (1, 5)
	if flakey (flake) < 0 then
	    flakey (flake) := 220
	    flakey (flake) := Rand.Int (0, 520)
	end if
	drawfilloval (flakex (flake), flakey (flake), 1, 1, white)
    end for
    %Draw red box
    if mousex > 130 and mousex < 390 and mousey > 55 and mousey < 165 then
	drawfillbox (130, 55, 390, 165, red)
    else
	drawfillbox (130, 55, 390, 165, 39)
    end if
end loop
for n : 1 .. 360
    drawfilloval (260, 110, n, n, white)
    drawoval (260, 110, n + 1, n + 1, black)
    delay (3)
end for
cls

colorBorder (35)
color (purple)
%Get input
Font.Draw ("What type of question would you like to use?", 110, 190, font2, purple)
Font.Draw ("Addition / Subtraction / Multiplication / Devision", 110, 160, font2, purple)
locate (5, 28)
color (black)
get operator
%Make lowercase
operator := Str.Lower (operator)
color (purple)
Font.Draw ("How many questions would you like?", 135, 110, font2, purple)
locate (8, 32)
color (black)
%Get number of questions
get numberOfQuestions
color (purple)
Font.Draw ("What is the difficulty level questions? 1 to 3", 125, 65, font2, purple)
locate (11, 32)
color (black)
%Get difficulty
get difficultyLevel
color (12)
if difficultyLevel > 3 or difficultyLevel < 1 then
    cls
    Font.Draw ("Enter a proper difficulty level!", 135, 110, font2, black)
    colorBorder (55)
    return
end if
cls

%Addition
if operator = "addition" then
    for i : 1 .. numberOfQuestions
	cls
	colorBorder (90)
	%Difficulty level
	if difficultyLevel = 1 then
	    number1 := Rand.Int (1, 10)
	    number2 := Rand.Int (1, 10)
	elsif difficultyLevel = 2 then
	    number1 := Rand.Int (1, 100)
	    number2 := Rand.Int (1, 100)
	else
	    number1 := Rand.Int (1, 1000)
	    number2 := Rand.Int (1, 1000)
	end if
	%Get answer
	concatenate := "What is " + realstr (number1, 1) + " + " + realstr (number2, 1) + "?"
	Font.Draw (concatenate, 200, 190, font2, purple)
	locate (3, 32)
	color (black)
	get answer
	%Answer check
	if answer = number1 + number2 then
	    %   put : stream, number1, " + ", number2, " = ", answer, "             ", " Correct"
	    Font.Draw ("You are correct! Good job!", 175, 160, font2, green)
	    happyFace
	    playCorrect
	    count := count + 1
	else
	    concatenate := ("Your answer was " + realstr (sqrt ((number1 + number2 - answer) ** 2), 1) + " away from the actual answer!")
	    %  put : stream, number1, " + ", number2, " = ", answer, "            ", " Incorrect"
	    Font.Draw ("Your answer was Incorrect.", 170, 160, font2, 12)
	    Font.Draw (concatenate, 100, 130, font2, 12)
	    sadFace
	    playIncorrect
	end if
	if i < numberOfQuestions then
	    nextQuestion
	else
	    finalQuestion
	end if
    end for
    %Subtraction
elsif operator = "subtraction" then
    for i : 1 .. numberOfQuestions
	cls
	colorBorder (90)
	%Difficulty level
	if difficultyLevel = 1 then
	    number1 := Rand.Int (10, 20)
	    number2 := Rand.Int (1, 10)
	elsif difficultyLevel = 2 then
	    number1 := Rand.Int (100, 200)
	    number2 := Rand.Int (1, 100)
	else
	    number1 := Rand.Int (500, 1000)
	    number2 := Rand.Int (1, 500)
	end if
	%Get answer
	concatenate := "What is " + realstr (number1, 1) + " - " + realstr (number2, 1) + "?"
	Font.Draw (concatenate, 200, 190, font2, purple)
	locate (3, 29)
	color (black)
	get answer
	%Answer check
	if answer = number1 - number2 then
	    %  put : stream, number1, " - ", number2, " = ", answer, "             ", " Correct"
	    Font.Draw ("You are correct! Good job!", 175, 160, font2, green)
	    happyFace
	    playCorrect
	    count := count + 1
	else
	    concatenate := ("Your answer was " + realstr (sqrt ((number1 - number2 - answer) ** 2), 1) + " away from the actual answer!")
	    %  put : stream, number1, " - ", number2, " = ", answer, "            ", " Incorrect"
	    Font.Draw ("Your answer was Incorrect.", 200, 160, font2, 12)
	    Font.Draw (concatenate, 100, 130, font2, 12)
	    sadFace
	    playIncorrect
	end if
	if i < numberOfQuestions then
	    nextQuestion
	else
	    finalQuestion
	end if
	cls
    end for
    %Multiplication
elsif operator = "multiplication" then
    for i : 1 .. numberOfQuestions
	cls
	colorBorder (90)
	%Difficulty level
	if difficultyLevel = 1 then
	    number1 := Rand.Int (1, 10)
	    number2 := Rand.Int (1, 10)
	elsif difficultyLevel = 2 then
	    number1 := Rand.Int (1, 50)
	    number2 := Rand.Int (1, 50)
	else
	    number1 := Rand.Int (1, 100)
	    number2 := Rand.Int (1, 100)
	end if
	%Get answer
	concatenate := "What is " + realstr (number1, 1) + " x " + realstr (number2, 1) + "?"
	Font.Draw (concatenate, 200, 190, font2, purple)
	locate (3, 32)
	color (black)
	get answer
	%Answer check
	if answer = number1 * number2 then
	    %   put : stream, number1, " x ", number2, " = ", answer, "             ", " Correct"
	    Font.Draw ("You are correct! Good job!", 175, 160, font2, green)
	    happyFace
	    playCorrect
	    count := count + 1
	else
	    concatenate := ("Your answer was " + realstr (sqrt ((number1 * number2 - answer) ** 2), 1) + " away from the actual answer!")
	    %   put : stream, number1, " x ", number2, " = ", answer, "            ", " Incorrect"
	    Font.Draw ("Your answer was Incorrect.", 200, 160, font2, 12)
	    Font.Draw (concatenate, 100, 130, font2, 12)
	    sadFace
	    playIncorrect
	end if
	if i < numberOfQuestions then
	    nextQuestion
	else
	    finalQuestion
	end if
	cls
    end for
    %Devision
elsif operator = "devision" then
    for i : 1 .. numberOfQuestions
	cls
	colorBorder (90)
	%Difficulty level
	if difficultyLevel = 1 then
	    devAnswer := Rand.Int (1, 10)
	    number2 := Rand.Int (1, 10)
	    number1 := devAnswer * number2
	elsif difficultyLevel = 2 then
	    devAnswer := Rand.Int (1, 100)
	    number2 := Rand.Int (1, 100)
	    number1 := devAnswer * number2
	else
	    devAnswer := Rand.Int (1, 200)
	    number2 := Rand.Int (1, 200)
	    number1 := devAnswer * number2
	end if
	%Get answer
	concatenate := "What is " + realstr (number1, 1) + " / " + realstr (number2, 1) + "?"
	Font.Draw (concatenate, 200, 190, font2, purple)
	locate (3, 32)
	color (black)
	get answer
	%Answer check
	if answer = number1 / number2 then
	    % put : stream, number1, " / ", number2, " = ", answer, "             ", " Correct"
	    Font.Draw ("You are correct! Good job!", 175, 160, font2, green)
	    happyFace
	    playCorrect
	    count := count + 1
	else
	    concatenate := ("Your answer was " + realstr (sqrt ((number1 / number2 - answer) ** 2), 1) + " away from the actual answer!")
	    % put : stream, number1, " / ", number2, " = ", answer, "            ", " Incorrect"
	    Font.Draw ("Your answer was Incorrect.", 200, 160, font2, 12)
	    Font.Draw (concatenate, 100, 130, font2, 12)
	    sadFace
	    playIncorrect
	end if
	if i < numberOfQuestions then
	    nextQuestion
	else
	    finalQuestion
	end if
	cls
    end for
else
    %Improper operator entered
    cls
    color (12)
    colorBorder (3)
    locate (2, 19)
    Font.Draw ("Please enter a operator!", 200, 160, font2, 12)
    playIncorrect
    return
end if

%Output score
cls
colorBorder (7)
concatenate := ("Your score is " + intstr (count) + " out of " + intstr (numberOfQuestions) + "!")
Font.Draw (concatenate, 100, 160, font1, 12)
%Output previous answer
concatenate := "Which is " + realstr ((count / numberOfQuestions * 100), 2) + "%"
Font.Draw (concatenate, 115, 110, font1, 12)
get : stream, answerPrevious
tell : stream, answerPosition
put : stream, ((count / numberOfQuestions) * 100) : 0 : 2
seek : stream, answerPosition
concatenate := "Your previous score was " + realstr(answerPrevious, 2) + "%!"
Font.Draw (concatenate, 85, 80,font1,12)


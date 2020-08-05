~blueDark = Color.fromHexString("#2D5670");
~blueMid = Color.fromHexString("#106AA3");
~blueLight = Color.fromHexString("#00D6B6");
~redDark = Color.fromHexString("#A31010");
~redLight = Color.fromHexString("#D84F37");

Window.closeAll;
w = Window("Boomtown", Rect(
	left: Window.screenBounds.width/2-(640/2),
	top: Window.screenBounds.height/2-(400/2),
	width: 640,
	height: 500))
.front
.alwaysOnTop_(true)
.background_(~blueDark)
.onClose_({
	s.freeAll

});

///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS
///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS
///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS///START BUTTONS

~startButtonA = Button(w, Rect(10, 310, 80, 80))//Letter A
.action_({
	~outSynthSetup.value;
	~letterAFunc.value;
	~aToBListener.value;
	~startButtonGuiFunc.value
});

~startButtonB = Button(w, Rect(100, 310, 80, 80))//Letter B
.action_({
	~outSynthSetup.value;
	~letterBFunc.value;
	~bToCListener.value;
	~startButtonGuiFunc.value
});

~startButtonC = Button(w, Rect(190, 310, 80, 80))//Letter C
.action_({
	~outSynthSetup.value;
	~letterCFunc.value;
	~cToDListener.value;
	~startButtonGuiFunc.value

});

~startButtonD = Button(w, Rect(280, 310, 80, 80))//Letter D
.action_({
	~outSynthSetup.value;
	~letterDFunc.value;
	~dToEListener.value;
	~startButtonGuiFunc.value
});

~startButtonE = Button(w, Rect(370, 310, 80, 80))//Letter E
.action_({
	~outSynthSetup.value;
	~letterEFunc.value;
	~eToFListener.value;
	~startButtonGuiFunc.value
});

~startButtonF = Button(w, Rect(460, 310, 80, 80))//Letter A
.action_({
	~outSynthSetup.value;
	~letterFFunc.value;
	~fToGListener.value;
	~startButtonGuiFunc.value
});

~startButtonG = Button(w, Rect(550, 310, 80, 80))//Letter G
.action_({
	~outSynthSetup.value;
	~letterGFunc.value;
	~startButtonGuiFunc.value;
});

///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS
///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS
///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS///STATIC START BUTTONS

~startButtonAstatic = Button(w, Rect(10, 410, 80, 80))//Letter A
.action_({
	~outSynthSetup.value;
	~letterAFunc.value;
	~startButtonGuiFunc.value
});

~startButtonBstatic = Button(w, Rect(100, 410, 80, 80))//Letter B
.action_({
	~outSynthSetup.value;
	~letterBFunc.value;
	~startButtonGuiFunc.value
});

~startButtonCstatic = Button(w, Rect(190, 410, 80, 80))//Letter C
.action_({
	~outSynthSetup.value;
	~letterCFunc.value;
	~startButtonGuiFunc.value
});

~startButtonDstatic = Button(w, Rect(280, 410, 80, 80))//Letter D
.action_({
	~outSynthSetup.value;
	~letterDFunc.value;
	~startButtonGuiFunc.value
});

~startButtonEstatic = Button(w, Rect(370, 410, 80, 80))//Letter E
.action_({
	~outSynthSetup.value;
	~letterEFunc.value;
	~startButtonGuiFunc.value
});

~startButtonFstatic = Button(w, Rect(460, 410, 80, 80))//Letter A
.action_({
	~outSynthSetup.value;
	~letterFFunc.value;
	~startButtonGuiFunc.value
});

~startButtonGstatic = Button(w, Rect(550, 410, 80, 80))//Letter G
.action_({
	~outSynthSetup.value;
	~letterGFunc.value;
	~startButtonGuiFunc.value;
});

///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///
///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///
///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///OTHER BUTTONS///

~stopButton = Button(w, Rect(210,110,100,100))//Stop Button
.visible_("false")
.action_({
	s.freeAll;
	if(~patternPlayer.isPlaying, {~patternPlayer.stop});
	if(t.isPlaying, {t.stop});

	~currentLetter.string_("");

	OSCdef(\aToB).disable;
	OSCdef(\bToC).disable;
	OSCdef(\cToD).disable;
	OSCdef(\dToE).disable;
	OSCdef(\eToF).disable;
	OSCdef(\fToG).disable;

	~stopButtonGuiFunc.value;
	~recordButton.value = 0;

});

~path = thisProcess.nowExecutingPath.dirname.dirname;

~recordButton = Button(w, Rect(180, 240, 160, 40))
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			s.record(~path +/+ "/Recordings/Boomtown_" ++ Date.localtime.stamp ++ ".wav");
		}, {
			s.stopRecording;
		}
)});

~testButton = Button(w, Rect(10, 240, 160, 40))
.action_({|view|
	if(view.value == 1,
		{
			"output Synths are on".postln;
			~outSynthSetup.value;
			~startButtons.do({|button|
				button.visible_("false")
			});
			~staticStartButtons.do({|button|
				button.visible_("false")
			});
			~practiceText.visible_("false")
		}, {
			"output Synths are off".postln;
			~outSynthSetup.value;
			~startButtons.do({|button|
				button.visible_("true")
			});
			~staticStartButtons.do({|button|
				button.visible_("true")
			});
			~practiceText.visible_("true")
		}
)});

///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT
///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT
///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT///TEXT

10.do({ |index|
	var colors = [0.5, 0.4, 0.3, 0.2, 0.1, 0];
	StaticText(w, Rect(2 + (index), 2 + (index), 400, 40))
	.string_("B O O M T O W N")
	.stringColor_(Color.gray(0.7 - (index / 13)))
	.font_(Font("Avant Garde", 40, "true"));
});

~practiceText = StaticText(w, Rect(10, 390, 620, 15))
.string_("Buttons in the bottom row are practice buttons, you won't be able to move between the sections");

~currentLetterText = StaticText(w, Rect(10, 60, 150, 20))
.string_("Current Letter:")
.stringColor_(Color.black)
.font_(Font("Avant Garde", 20, true));

~currentLetter = StaticText(w, Rect(40, 80, 150, 150))
.string_("")
.stringColor_(Color.black)
.font_(Font("default", 150, true));

~dryText = StaticText(w, Rect(350, 30, 40, 20))
.string_("Dry")
.stringColor_(Color.black);

~dryOutSlider = Slider(w, Rect(350, 50, 40, 230))
.value_(0.5)
.action_({
	arg obj;
	if(~dryOut.isRunning, {~dryOut.set(\amp, obj.value * 2)});
});

~wetText = StaticText(w, Rect(410, 30, 40, 20))
.string_("Wet")
.stringColor_(Color.black);

~wetOutSlider = Slider(w, Rect(410, 50, 40, 230))
.value_(0.5)
.action_({
	arg obj;
	if(~wetOut.isRunning, {~wetOut.set(\amp, obj.value * 2)});
});

~droneText = StaticText(w, Rect(460, 30, 60, 20))
.string_("Drone")
.stringColor_(Color.black);

~droneOutSlider = Slider(w, Rect(470, 50, 40, 230))
.value_(0.5)
.action_({
	arg obj;
	if(~droneOut.isRunning, {~droneOut.set(\amp, obj.value * 2)});
});

~meters = ServerMeterView(s, w, 520@50, 1, 2);

///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS
///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS
///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS///DESIGN ELEMENTS

~sliderLabels = [~wetText, ~dryText, ~droneText];

~sliderLabels.do({|button, index|
	button.font_(Font("Avant Garde", size:20));
});

~testButton.states_([["Test Levels", ~redDark, Color.black],["End Test", ~redLight, Color.black]])
.font_(Font("Avant Garde", size:20));

~recordButton.states_([["RECORD", ~redDark, Color.black],["Stop Recording", ~redLight, Color.black]])
.font_(Font("Avant Garde", size:20));


~startButtons = [
	~startButtonA,
	~startButtonB,
	~startButtonC,
	~startButtonD,
	~startButtonE,
	~startButtonF,
	~startButtonG,
];

~staticStartButtons = [
	~startButtonAstatic,
	~startButtonBstatic,
	~startButtonCstatic,
	~startButtonDstatic,
	~startButtonEstatic,
	~startButtonFstatic,
	~startButtonGstatic,
];

~strings = ["A", "B", "C", "D", "E", "F", "G"];

~startButtons.do({|button, index|
	button.font_(Font("Avant Garde", size:20));
	button.states_([[~strings[index], ~blueLight, Color.black]])

});

~staticStartButtons.do({|button, index|
	button.font_(Font("Avant Garde", size:20));
	button.states_([[~strings[index], ~blueMid, Color.black]])

});

~stopButton.states_([["STOP", ~redDark, Color.black]])
.font_(Font("Avant Garde", size:20));

~notStopButtons = ~startButtons ++ ~staticStartButtons ++ [~testButton, ~recordButton, ~practiceText];

~startButtonGuiFunc = {
	~notStopButtons.do({|button|
		button.visible_("false")
	});
	~stopButton.visible_("true");
};

~stopButtonGuiFunc = {
	~notStopButtons.do({|button|
		button.visible_("true")
	});
	~stopButton.visible_("false");
};
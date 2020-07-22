~blueDark = Color.fromHexString("#2D5670");
~blueMid = Color.fromHexString("#106AA3");
~blueLight = Color.fromHexString("#00D6B6");
~redDark = Color.fromHexString("#A31010");
~redLight = Color.fromHexString("#D84F37");

Window.closeAll;
w = Window("121 Sketch", Rect(
	left: Window.screenBounds.width/2-(640/2),
	top: Window.screenBounds.height/2-(400/2),
	width: 640,
	height: 400))
.front
.alwaysOnTop_(true)
.background_(~blueDark)
.onClose_({
	s.freeAll

});
// make an array of all start buttons
//~notStopButtons = [~startButtonA, ~startButtonB, ~startButtonC, ~startButtonD, ~startButtonE, ~startButtonF, ~startButtonG, ~testButton, ~recordButton];
// make an array of all test buttons
////test dry, test wet, test drones
/* control visibility of buttons using this function:
[~buttonArray].do({|button|
button.visible_("false")
});

*/

~startButtonA = Button(w, Rect(10, 310, 80, 80))//Letter A
.action_({
	"Letter A".postln;
	~currentLetter.string_("A");

	~outSynthSetup.value;
	//start G+D Pattern
	~patternPlayer = ~joePatternA.play;

	//start Listener
	~pitchDetAtoB = Synth(\pitchDetective, [
		\tarFreq: 220, //A3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\aToB).enable;

	~startButtonGuiFunc.value

});

~startButtonB = Button(w, Rect(100, 310, 80, 80))//Letter B
.action_({
	"Letter B".postln;
	~currentLetter.string_("B");

	~outSynthSetup.value;

	//start Letter B Pattern
	~patternPlayer = ~joePatternB.play;

	//start Delay
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: 0,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	//start Listener
	~pitchDetBtoC = Synth(\pitchDetective, [
		\tarFreq: 233, //B-flat 3
		\id, 0
	]);
	//enable Listener OSC func
	OSCdef(\bToC).enable;

	~startButtonGuiFunc.value

});

~startButtonC = Button(w, Rect(190, 310, 80, 80))//Letter C
.action_({
	"Letter C".postln;
	~currentLetter.string_("C");

	~outSynthSetup.value;

	//Start Letter C Pattern
	~patternPlayer = ~joePattern3.play;

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		1.wait;
		~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.9, \mix: 0.6, \room: 0.75]);
		0.3.wait;
		~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.925, \mix: 0.45, \room: 0.6]);
		0.3.wait;
		~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95]);
	}).play;

	//Start C to D Listener
	~pitchDetCtoD = Synth(\pitchDetective, [
		\tarFreq: 196, //G 3
		\id, 0
	]);

	//Start C to D OSC def
	OSCdef(\cToD).enable;

	~startButtonGuiFunc.value

});

~startButtonD = Button(w, Rect(280, 310, 80, 80))//Letter D
.action_({
	"Letter D".postln;
	~currentLetter.string_("D");

	~outSynthSetup.value;

	//Start Slow Chorus
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		1.wait;
		~pbSynth1 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.9, \mix: 0.6, \room: 0.75]);
		0.3.wait;
		~pbSynth2 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.925, \mix: 0.45, \room: 0.6]);
		0.3.wait;
		~pbSynth3 = Synth(\playbackBuf, [\bufnum: ~bufArrayBig[0], \rate: 0.95]);
	}).play;

	//Start D to E Listener
	~pitchDetDtoE = Synth(\pitchDetective, [
		\tarFreq: 233, //Bb
		\id, 0
	]);

	//Start D to E OSC def
	OSCdef(\dToE).enable;

	~startButtonGuiFunc.value

});

~startButtonE = Button(w, Rect(370, 310, 80, 80))//Letter E
.action_({
	"Letter E".postln;
	~currentLetter.string_("E");

	~outSynthSetup.value;

	//Start Letter E Pattern
	~patternPlayer = ~joePatternE.play;

	//Start Delay
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	//Start E to F Listener
	~pitchDetEtoF = Synth(\pitchDetective, [
		\tarFreq: 196, //Bb 3
		\id, 0
	]);

	//Start E to F OSC def
	OSCdef(\eToF).enable;

	~startButtonGuiFunc.value

});

~startButtonF = Button(w, Rect(460, 310, 80, 80))//Letter A
.action_({
	"Letter F".postln;
	~currentLetter.string_("F");

	~outSynthSetup.value;

	//Start Delay
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	//Start Slow Chorus w/ Skip
	t = Task({
		~recSynth = Synth(\recordBuf, [\bufnum: ~bufArrayBig[0]]);
		0.1.wait;
		~pbSynth1 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \outbus: ~wetBus, \skipDens: 1, \skipDur: -0.5]);
		0.3.wait;
		~pbSynth2 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \outbus: ~wetBus, \skipDens: 1.5, \skipDur: -0.3]);
		0.3.wait;
		~pbSynth3 = Synth(\skipBuf, [\bufnum: ~bufArrayBig[0], \outbus: ~wetBus, \skipDens: 2, \skipDur: -0.2]);
	}).play;

	//Start F to G Listener
	~pitchDetEtoF = Synth(\pitchDetective, [
		\tarFreq: 196, //Bb 3
		\id, 0
	]);

	//Start F to G OSC def
	OSCdef(\fToG).enable;

	~startButtonGuiFunc.value

});

~startButtonG = Button(w, Rect(550, 310, 80, 80))//Letter G
.action_({
	"Letter G".postln;
	~currentLetter.string_("G");

	~outSynthSetup.value;

	//Start Delays
	~delay = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	~delay1 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 0.5,
		\rel: 10,
		\atk: 10,
		\mix: 0.5,
		\room: 0.9,
	]);

	~delay2 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 1,
		\rel: 10,
		\atk: 10,
		\mix: 0.6,
		\room: 0.9,
	]);

	~delay3 = Synth(\delay, [
		\inbus: 0,
		\outbus: ~wetBus,
		\del: 2,
		\rel: 10,
		\atk: 10,
		\mix: 0.7,
		\room: 0.9,
	]);

	~startButtonGuiFunc.value

});

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

});

~recordButton = Button(w, Rect(180, 240, 160, 40))
.action_({|view|
	if(view.value == 1,
		{"It's on!".postln;
			s.record;
		}, {
			s.stopRecording
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
		}, {
			"output Synths are off".postln;
			~outSynthSetup.value;
			~startButtons.do({|button|
				button.visible_("true")
			});
		}
)});

10.do({ |index|
	var colors = [0.5, 0.4, 0.3, 0.2, 0.1, 0];
	StaticText(w, Rect(2 + (index), 2 + (index), 3200, 40))
	.string_("B O O M T O W N")
	//.stringColor_(Color.gray(colors[index]))
	.stringColor_(Color.gray(0.7 - (index / 13)))
	.font_(Font("Avant Garde", 40, "true"));
});

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

//DESIGN ELEMENTS


~sliderLabels = [~wetText, ~dryText, ~droneText];

~sliderLabels.do({|button, index|
	button.font_(Font("Avant Garde", size:20));
});

~testButton.states_([["Test Levels", ~redDark, Color.black],["End Test", ~redLight, Color.black]])
.font_(Font("Avant Garde", size:20));

~recordButton.states_([["RECORD", ~redDark, Color.black],["Stop Recording", ~redLight, Color.black]])
.font_(Font("Avant Garde", size:20));


~startButtons = [~startButtonA, ~startButtonB, ~startButtonC, ~startButtonD, ~startButtonE, ~startButtonF, ~startButtonG];
~strings = ["A", "B", "C", "D", "E", "F", "G"];

~startButtons.do({|button, index|
	button.font_(Font("Avant Garde", size:20));
	button.states_([[~strings[index], ~blueLight, Color.black]])

});

~stopButton.states_([["STOP", ~redDark, Color.black]])
.font_(Font("Avant Garde", size:20));

~notStopButtons = ~startButtons ++ [~testButton, ~recordButton];

~startButtonGuiFunc = {
	~notStopButtons.do({|button|
		button.visible_("false")
	});
	~stopButton.visible_("true");
};

~stopButtonGuiFunc = {
	~notStopButtons.do({|button|
		button.visible_("tru")
	});
	~stopButton.visible_("false");
};
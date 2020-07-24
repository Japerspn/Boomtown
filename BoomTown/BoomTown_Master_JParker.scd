(
s.waitForBoot({

	~bufArrayBig = Array.fill(10, {Buffer.alloc(s, s.sampleRate * 10, 1)});// Array of 10 10 second buffers
	~busArray1ch = Array.fill(10, {Bus.audio(s, 1)});// Array of ten one channel audio buses
	~busArray2ch = Array.fill(10, {Bus.audio(s, 2)});// Array of ten two channel audio buses
	~droneBus = Bus.audio(s, 2);
	~dryBus = Bus.audio(s, 2);
	~wetBus = Bus.audio(s, 2);

	~g3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone12 (G3)_JParker_V2.wav");
	~beef3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone07 (Bb3)_JParker_V2.wav");
	~c4 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone04 (C4)_JParker_V2.wav");
	~g4 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone03 (G4)_JParker_V2.wav");
	~a4one = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone02 (A4)_JParker_V2.wav");
	~a4two = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone17 (A4)_JParker_V2.wav");
	~c5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone09 (C5)_JParker_V2.wav");
	~d5one = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone01 (D5)_JParker_V2.wav");
	~d5two = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone16 (D5)_JParker_V2.wav");
	~f5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone15 (F5)_JParker_V2.wav");
	~fis5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone05 (F#5)_JParker_V2.wav");
	~g5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone13 (G5)_JParker_V2.wav");
	~a5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone06 (A5)_JParker_V2.wav");
	~beef5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone10 (Bb5)_JParker_V2.wav");
	~b5 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone11 (B5)_JParker_V2.wav");
	~d6 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone08 (D6)_JParker_V2.wav");
	~e6 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Resources/Samples/JDAM_Drone14 (E6)_JParker_V2.wav");

	~all = [~g3, ~beef3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~fis5, ~g5, ~a5, ~beef5, ~b5, ~d6, ~e6];
	~gPent = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~g5, ~a5, ~d6];
	~justG = [~g3, ~g4, ~g5];
	~gAndD = [~g3, ~g4, ~d5one, ~d5two, ~g5, ~d6];
	~gMaj = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~fis5, ~g5, ~a5, ~b5, ~d6, ~e6];
	~gDom = [~g3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~g5, ~a5, ~b5, ~d6, ~e6];
	~gMin = [~g3, ~beef3, ~c4, ~g4, ~a4one, ~a4two, ~c5, ~d5one, ~d5two, ~f5, ~g5, ~a5, ~beef5, ~d6];

	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_Gui_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_Synths_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterA_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterB_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterC_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterD_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterE_JParker.scd", "r").readAllString.interpret;
	File(thisProcess.nowExecutingPath.dirname +/+ "Resources/BoomTown_LetterF_JParker.scd", "r").readAllString.interpret;

});

if(s.serverRunning, {
	s.options.memSize_(2.pow(20));
	s.options.numOutputBusChannels_(4);
	s.reboot;
}, {s.options.memSize_(2.pow(20));
	s.options.numOutputBusChannels_(4);
	s.boot;
})

);
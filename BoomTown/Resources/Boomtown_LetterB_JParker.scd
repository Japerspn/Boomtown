
//listener for ID 0
~bFunc = OSCdef(\aToB, { arg msg, time, addr, recvPort;
	if( msg[2] == 0, {// ID 0
		"Letter B".postln;
		~pitchDetAtoB.free; //free pitch detector synth

		~joePattern1 = Pbind(//adjust pattern slightly
			\instrument, \joeSynth,
			\bufnum, Pxrand(~gPent, inf),
			\atk, 5,
			\sus, 5,
			\rel, 5,
			\dur, 3,
			\mix, 0.8,
			\room, 0.86
		);
	});

}, \tr)

~bFunc.disable



n = NetAddr("127.0.0.1", NetAddr.langPort); // local machine

OSCFunc.newMatching({|msg, time, addr, recvPort| \matching.postln}, '/chat', n); // path matching
OSCFunc({|msg, time, addr, recvPort| \oneShot.postln}, '/chat', n).oneShot; // once only
OSCdef(\test, {|msg, time, addr, recvPort| \unmatching.postln}, '/chat', n); // def style

m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

m.sendMsg("/chat", "Hello App 1");
m.sendMsg("/chat", "Hello App 1"); // oneshot gone
m.sendMsg("/ch?t", "Hello App 1");
m.sendMsg("/*", "Hello App 1");
m.sendMsg("/chit", "Hello App 1"); // nothing

OSCdef(\test).enable
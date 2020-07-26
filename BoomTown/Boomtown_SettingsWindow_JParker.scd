~settingsPath = thisProcess.nowExecutingPath.dirname;
~settingsWindow = {
	//Window.closeAll; //TAKE THIS LINE OUT IN THE FINAL VERSION!!!
	~settings = Window("Settings", Rect(
		left: Window.screenBounds.width/2-(340/2),
		top: Window.screenBounds.height/2-(300/2),
		width: 320,
		height: 300))
	.front
	.alwaysOnTop_(true);

	///// Sample Rate Menu
	//Title
	StaticText(~settings, Rect(10, 10, 100, 20))
	.string_("Sample Rate")
	.font_(Font("default", 16, true ));
	//Menu
	PopUpMenu(~settings, Rect(10, 40, 100, 20))
	.items_(["44.1 khz", "48 khz", "88.2 khz", "96 khz"])
	.allowsReselection_(true)
	.action_({|menu|
		if(menu.value == 0, {s.options.sampleRate_(44100)});
		if(menu.value == 1, {s.options.sampleRate_(48000)});
		if(menu.value == 2, {s.options.sampleRate_(88200)});
		if(menu.value == 3, {s.options.sampleRate_(96000)});
	});
	//Current text
	StaticText(~settings, Rect(120, 40, 220, 20))
	.string_("Current Sample Rate: " ++ (s.sampleRate / 1000).asString ++ " khz");


	//// input device menu
	//Title
	StaticText(~settings, Rect(10, 70, 100, 20))
	.string_("Input Device")
	.font_(Font("default", 16, true ));
	//Menu
	PopUpMenu(~settings, Rect(10, 100, 200, 20))
	.items_(ServerOptions.inDevices)
	.allowsReselection_(true)
	.action_({|menu|
		s.options.inDevice_(ServerOptions.inDevices[menu.value])
	});

	//// output device menu
	//Title
	StaticText(~settings, Rect(10, 130, 120, 20))
	.string_("Output Device")
	.font_(Font("default", 16, true ));
	//Menu
	PopUpMenu(~settings, Rect(10, 160, 200, 20))
	.items_(ServerOptions.outDevices)
	.allowsReselection_(true)
	.action_({|menu|
		s.options.outDevice_(ServerOptions.outDevices[menu.value])
	});

	//// Apply button
	Button(~settings, Rect(80, 200, 160, 50))
	.string_("Apply")
	.font_(Font("default", 18, true))
	.action_({
		Window.closeAll;
		//File(~settingsPath +/+ "BoomTown_Master_JParker.scd", "r").readAllString.interpret;
	});
	/// Apply Text
	StaticText(~settings, Rect(20, 250, 280, 50))
	.string_("After hitting apply, go back to the master file and reevaluate the code")
	.align_(\center)

}

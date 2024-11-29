s.boot;
// Define a SynthDef for the sine wave
(
SynthDef(\sine_wave, {
    arg freq, amp;
    var sig;

    sig = SinOsc.ar(freq, 0, amp);  // Sine wave oscillator
    sig = sig * EnvGen.kr(Env.perc(0.01, 0.1), doneAction: 2);  // Apply envelope

    Out.ar(0, sig.dup);  // Output to stereo
}).add;
);
// Iterate over MIDI notes from 0 to 127
var midiRange = (0..127);  // Full MIDI range (0-127)


(
fork {
    midiRange.do { |note|
        "started a synth".postln;
		note.postln;
		Synth(\sine_wave, [\freq, note.midicps, \amp, 0.2]).waitForFree;
		// Synth(\help).waitForFree;
        "This one ended. Wait a second,  I will start the next one.".postln;
        0.3.wait;
    };
    "This is it.".postln;
}
);
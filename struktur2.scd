// Struktur 2
s.freqscope


// Track 1

// a
(
{
    var amp = 1/10;
    var env1 = Env(
        [1, 1, 0.8, 0.8, 0.2, 0.5, 0],
        [5, 3, 2, 0.5, 1, 1.5],
        [\lin, \lin, \lin, \sin, \sin, \sin]
    );
    var env2 = Env(
        [1, 1, 1, 0.6, 0.75, 0.3, 0.4, 0, 0.5],
        [5, 3, 0.4, 0.4, 0.4, 0.4, 0.4, 3],
        [\lin, \lin, \sin, \sin, \sin, \sin, \sin, \lin]
    );
    var env3 = Env(
        [0.7, 0.7, 0.8, 0.7, 0.9, 0.8, 1, 0.45, 0.45],
        [5, 0.6, 0.6, 0.6, 0.6, 0.6, 2, 3],
        [\lin, \sin, \sin, \sin, \sin, \sin,\sin, \lin]
    );
    var env4 = Env(
        [0.1, 0.1, 0.6, 0.45, 0.7, 0.75, 0.85, 0.6, 0.9, 0.4, 1, 0.2],
        [8, 1, 0.5, 0.4, 0.1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
        [\lin, \sin, \sin, \sin, \sin, \sin,\sin, \sin, \sin, \sin, \sin]
    );
    var env5 = Env(
        [0.2, 0.9, 0.9, 0.5, 0.6, 0.45, 0.6, 0.4],
        [5, 5, 0.6, 0.6, 0.4, 0.7, 0.7],
        [\lin, \lin, \sin, \sin, \sin, \sin,\sin]
    );
    var envgen1 = EnvGen.ar(env1, doneAction: 2);
    var envgen2 = EnvGen.ar(env2, doneAction: 2);
    var envgen3 = EnvGen.ar(env3, doneAction: 2);
    var envgen4 = EnvGen.ar(env4, doneAction: 2);
    var envgen5 = EnvGen.ar(env5, doneAction: 2);
    Mix.new([
        SinOsc.ar(envgen1 * 5500  + 6000, 0, amp),
        SinOsc.ar(envgen1 * 5500  + 5950, 0 ,amp),
        SinOsc.ar(envgen2 * 5200  + 6000, 0, amp),
        SinOsc.ar(envgen2 * 5200  + 5950, 0 ,amp),
        SinOsc.ar(envgen3 * 6000  + 6000, 0, amp),
        SinOsc.ar(envgen3 * 6000  + 5950, 0 ,amp),
        SinOsc.ar(envgen4 * 6000  + 6000, 0, amp),
        SinOsc.ar(envgen4 * 6000  + 5950, 0 ,amp),
        SinOsc.ar(envgen5 * 6000  + 6000, 0, amp),
        SinOsc.ar(envgen5 * 6000  + 5950, 0 ,amp)
    ]);
}.play
);


(
SynthDef(\ringmod_s2_1, { |out=0, freq=12000, amp=1.0|
    var in = SoundIn.ar(0);
    var snd = in * SinOsc.ar(freq);
    var env = Env(
        [16, 16,14, 25, 20, 30, 8, 15, 13, 25, 20, 35, 15, 25],
        [2, 0.1, 0.4, 0.3, 0.4, 1.1, 0.7, 0.4, 0.6, 0.5, 0.5, 0.3, 0.7 ],
        \sin
    );
    var envgen = EnvGen.ar(env, doneAction: 2);
    snd = snd * SinOsc.ar(envgen);
    Out.ar(out, snd * amp);
}).send(s);

)

// play this at 00:00:26.000
a = Synth(\ringmod_s2_1, [\freq, 12000  ]);
a.set(\freq, 12000)

(
SynthDef(\ringmod_s2_2, { |out=0, freq=12000|
    var in = SoundIn.ar(0);
    var snd = in * SinOsc.ar(freq);
    Out.ar(out, snd);
}).send(s);
)

b = Synth(\ringmod_s2_2, [\freq, 12110])
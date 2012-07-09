// Circuit Struktur 5

(
SynthDef(\struktur5, { |out=0, lvl=1.0, buf=0|
    var snd;
    var sig;
    var osc1, osc2, osc3;
    var ringIn1, ringIn2;
    osc1 = SinOsc.ar(12000);
    osc2 = SinOsc.ar(11900);
    osc3 = SinOsc.ar(11800);

    ringIn1 = (osc1 + osc2 + osc3) / 3;
    // TODO change ringIn2 to real source
    // ringIn2 = PlayBuf.ar(2, buf, loop:1);
    ringIn2 = SoundIn.ar(0);

    sig = ringIn1 * ringIn2;

    sig = sig * LFTri.ar(70);
    sig = sig * lvl;

    snd = LPF.ar(sig, 6000);
    Out.ar(out, snd);
}).send(s);
)

a = Synth(\struktur5);


(
SynthDef(\struktur52, { |out=0, freq=200, amp=0.5|
    var snd;
    var length = Rand(0.1, 1.0);
    var env = EnvGen.ar(Env([0, 1, 0.8, 0.8, 0],[0.01, 0.1, length, 0.01]), doneAction: 2);
    snd = SinOsc.ar(freq,0, amp) * env;
    Out.ar(out, snd);
}).send(s);
)

(
SynthDef(\struktur53, { |out=0, freq=200, amp=0.5|
    var snd;
    var length = Rand(0.1, 0.5);
    var env = EnvGen.ar(Env([0, 1, 0.8, 0.8, 0],[0.01, 0.1, length, 0.01]), doneAction: 2);
    snd = SinOsc.ar(freq,0, amp) * env;
    Out.ar(out, snd);
}).send(s);

)


// Track 1
(
var mLength = 1.0;
Ppar([
    Pfindur(22,
        Pbind(
            \instrument, \struktur52,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur52,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur52,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur52,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur52,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1, mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        ))
]).play;
)

// Track 2

(
var mLength = 1.0;
Ppar([
    Pfindur(22,
        Pbind(
            \instrument, \struktur53,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur53,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur53,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        )),
    Pfindur(22,
        Pbind(
            \instrument, \struktur53,
            \freq, Pbrown(0.0, 1.0, 0.1, inf) * 3970 + 8000,
            \dur, Pwhite(0.1,mLength, inf),
            \stretch, Pwhite(1.0,3.0)
        ))
]).play;
)


(
SynthDef(\gagakuschaltungstruktur5, { arg out=0, buf=0, m1=12000, m2=12000,
    gain1=1.0, gain2=1.0, gain3=1.0, startpos=0, ampa=(-8);

    var gagaku, snd;
    var mod1, mod2;
    var filter1, filter2, filter3;
    var sigA, sigB, sigC, sigD;

    // Track 4
    var ringbamplvl = Control.names(\ringbamplvl).kr([0.0, 0.0, 1, 0.56, 0.56, 0.178, 0.447, 0.312, 0.71, 0, 0, 0.312, 0, 0, 1, 0 ]);
    var ringbampdur = Control.names(\ringbampdur).kr([2, 0.01, 0.5, 1.5, 2, 4, 1, 2, 2, 2.5, 0.5, 2, 1.5, 0.5 ]);


    var ringbampenv = Env(ringbamplvl, ringbampdur, \sin);
    var ringbampenvgen = EnvGen.ar(ringbampenv, doneAction: 2);
    var ringblvl = ringbampenvgen;

    gagaku = PlayBuf.ar(2, buf, loop:1, startPos: startpos);
    mod1 = SinOsc.ar(m1);
    mod2 = SinOsc.ar(m2);
    filter1 = LPF.ar(gagaku, 6000);
    sigA = filter1 * mod1;
    filter2 = HPF.ar(sigA, 6000);
    sigB = filter2 * mod2;
    sigB = sigB * gain2;
    filter3 = LPF.ar(sigB, 5500);
    sigD = filter3 * ringblvl;
    sigC = sigA * (ampa.dbamp);
    snd = sigC + sigD;
    Out.ar(out, snd*0.5);
}).send(s);
)

// Track 4
b = Buffer.read(s, "~/scwork/sub_repos/telemusik/snd/04_Genderan_Gamelan_Gong.wav".standardizePath);

(
Synth(\gagakuschaltungstruktur5,
    [
        \ampa, -8,
        \buf, b,
        \startpos, 1764000,
        \ringbamplvls, [0.0, 0.0, 1, 0.56, 0.56, 0.178, 0.447, 0.312, 0.71, 0, 0, 0.312, 0, 0, 1, 0 ],
        \ringbampdurs, [2, 0.01, 0.5, 1.5, 2, 4, 1, 2, 2, 2.5, 0.5, 2, 1.5, 0.5 ],
    ]
);
)

// Track 5
b = Buffer.read(s, "~/scwork/sub_repos/telemusik/snd/B5_Two_Manyanga_Drum_Rhythms_Nyamwezi.wav".standardizePath);

(
Synth(\gagakuschaltungstruktur5,
    [
        \ampa, -7,
        \buf, b,
        \startpos, 1764000,
        \ringbamplvl, [0, 0, 1, 0.56, 0.56, 0.47, 0.56, 0.47, 0.56, 0.47, 0.56, 0.47, 0.56, 0.47, 0.56, 0],
        \ringbampdur, [8, 0.01, 0.49, 0.5, 1.2, 1.4, 1.4, 1.4, 1.4, 1.4, 1.4, 1.4, 1.4, 0.59, 0.01]
    ]
);
)
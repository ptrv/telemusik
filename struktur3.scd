// Circuit Struktur 3

(
SynthDef(\struktur3, { arg out=0, ampindb=0, freq2=11350, freq3=12000,
    lvl1=1.0,lvl2=0.5,lvl3=1.0,lvl4=1.0,lvl5=0;
    var snd;
    var osc1, osc2, osc3;
    var sigA, sigB;
    var ringIn1, ringIn2, ringOut;
    // var env = Env([9500, 9500, 8500, 8500], [2, 3, 10], \lin);
    var envlvl = Control.names(\envlvl).kr([9500, 9500, 8500, 8500]);
    var envdur = Control.names(\envdur).kr([21, 3, 10]);
    var env = Env(envlvl, envdur, \lin);
    var freqenv = EnvGen.ar(env, doneAction: 2);

    var ringenvlvl = Control.names(\ringenvlvl).kr([0,0,1,0,0,1,1,0, 1, 0]);
    var ringenvdur = Control.names(\ringenvdur).kr(
        [8, 0.1,0.5, 10.4, 0.1,1.4, 0.5, 0.1,12.9 ]
    );
    var ringenv = Env(ringenvlvl, ringenvdur);
    var ringamp = EnvGen.ar(ringenv, doneAction: 0);
    osc1 = SinOsc.ar(freqenv);
    osc2 = SinOsc.ar(freq2);
    osc3 = SinOsc.ar(freq3);

    sigA = (osc1 + osc2 + osc3) / 3;

    lvl4 = ampindb.dbamp;
    sigA = sigA * lvl4;

    ringIn1 = (osc1 * lvl1) + (osc2 * lvl2);
    ringIn1 = ringIn1 / 2;
    ringIn2 = osc3 * lvl3;

    ringOut = ringIn1 * ringIn2;

    lvl5 = ringamp;
    sigB = ringOut * lvl5;
    snd = sigA + sigB;

    Out.ar(out, (snd * 0.5));
}).send(s);
)


// Track 1
(
a = Synth(\struktur3,
    [
        \ampindb, -7,
        \freq2, 11350,
        \freq3, 12000,
        \envlvl, [9500, 9500, 8900, 8900],
        \envdur, [21, 3, 10],
        \ringenvlvl, [0,0,1,0,0,1,1,0, 1, 0],
        \ringenvdur, [8, 0.1,0.5, 10.4, 0.1,1.4, 0.5, 0.1,12.9]
    ]
);
)

// Track 2
(
a = Synth(\struktur3,
    [
        \ampindb, -5,
        \freq2, 11688,
        \freq3, 12000,
        \envlvl, [10800, 10800, 10400, 10400],
        \envdur, [21, 3, 10],
        \ringenvlvl, [0,0,1,0,0,1,1,0, 1, 0, 0],
        \ringenvdur, [8, 0.1,0.4, 6.5, 0.1,5.4, 0.5, 0.1,2.1, 10.8]
    ]
);
)

// Track 3
(
a = Synth(\struktur3,
    [
        \ampindb, -3,
        \freq2, 11890,
        \freq3, 12000,
        \envlvl, [11380, 11380, 11180, 11180],
        \envdur, [21, 3, 10],
        \ringenvlvl, [0,0,1,0,0,1,1,0, 1, 0, 0],
        \ringenvdur, [8, 0.1,0.9, 9.0, 0.1,2.4, 0.5, 0.1,3.1, 9.8]
    ]
);
)

// Track 4
(
a = Synth(\struktur3,
    [
        \ampindb, 0,
        \freq2, 11950,
        \freq3, 12000,
        \envlvl, [11670, 11670, 11560, 11560],
        \envdur, [21, 3, 10],
        \ringenvlvl, [0,0,1,0,0,1,1,0, 1, 0, 0],
        \ringenvdur, [8, 0.1,1.9, 3.0, 0.1,7.4, 0.5, 0.1,4.1, 8.8]
    ]
);
)

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/mokugyo.wav");

(
SynthDef(\play_mokugyo, {| out = 0, bufnum = 0 |
    var trig;
    trig = Impulse.kr(XLine.kr(1, 5.25 , 20, doneAction: 2));
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, 0, 0)
    )
}).play(s, [\out, 0, \bufnum, b]);
)

// (
// a = Synth(\struktur3);

// w = Window.new;
// c = Slider(w, Rect(20, 60, 20, 150))
// .action_({
//     a.set(\lvl1, c.value)
// });
// c.value = 1.0;
// d = Slider(w, Rect(50, 60, 20, 150))
// .action_({
//     a.set(\lvl2, d.value)
// });
// d.value = 1.0;
// e = Slider(w, Rect(80, 60, 20, 150))
// .action_({
//     a.set(\lvl3, e.value)
// });
// e.value = 1.0;
// f = Slider(w, Rect(120, 60, 20, 150))
// .action_({
//     a.set(\lvl4, f.value)
// });
// f.value = 1.0;
// g = Slider(w, Rect(150, 60, 20, 150))
// .action_({
//     a.set(\lvl5, g.value)
// });
// g.value = 1.0;

// w.onClose = { a.free;};
// w.front;
// )

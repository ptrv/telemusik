// Circuit Struktur 3

(
SynthDef(\struktur3, { arg out=0, ampindb=0, freq2=11350, freq3=12000,
    lvl1=1.0,lvl2=0.5,lvl3=1.0,lvl4=1.0,lvl5=0;
    var snd;
    var osc1, osc2, osc3;
    var sigA, sigB;
    var ringIn1, ringIn2, ringOut;

    // Envelope for oscilator frequency
    var envlvl = Control.names(\envlvl).kr([9500, 9500, 8500, 8500]);
    var envdur = Control.names(\envdur).kr([21, 3, 10]);
    var env = Env(envlvl, envdur, \lin);
    var freqenv = EnvGen.ar(env, doneAction: 2);

    // Envelope for ringmodulator level
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


// Mokugyo

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/mokugyo.wav");

(
SynthDef(\playmokugyo, {| out = 0, bufnum = 0 |
    var trig;
    trig = Impulse.kr(XLine.kr(1, 5.25 , 20, doneAction: 2));
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, 0, 0)
    )
}).play(s, [\out, 0, \bufnum, b]);
)


// Gagaku Schaltung

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/07_-_Seigaiha.wav");
b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/12_-_Motomeko_No_Uta.wav");
b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/06_-_Banshikicho_Netori.wav");
b.query
(
SynthDef(\gagakuschaltungstruktur3, { arg out=0, buf=0, m1=12000, m2=12000,
    gain1=1.0, gain2=1.0, gain3=1.0, startpos=0;

    var gagaku, snd;
    var mod1, mod2;
    var filter1, filter2, filter3;
    var sigA, sigB, sigC, sigD;

    var ringenvlvl = Control.names(\rmenvlvl).kr([12000, 12000, 11950, 12000, 12000]);
    var ringenvdur = Control.names(\rmenvdur).kr([22.6, 4.4, 4.4, 2.6]);

    var ringenv = Env(ringenvlvl, ringenvdur);
    var ringenvgen = EnvGen.ar(ringenv, doneAction: 2);

    var ringbamplvl = Control.names(\ringbamplvl).kr([0, 0, 0.5, 0.5,0,0,0.5,0.5,0]);
    var ringbampdur = Control.names(\ringbampdur).kr([8,0.1,2.8,0.1,10, 0.1,10.3,2.6]);

    var ringbampenv = Env(ringbamplvl, ringbampdur);
    var ringbampenvgen = EnvGen.ar(ringbampenv, doneAction: 0);
    var ringblvl = ringbampenvgen;

    gagaku = PlayBuf.ar(2, buf, loop:1, startPos: startpos);
    mod1 = SinOsc.ar(m1);
    mod2 = SinOsc.ar(ringenvgen);
    filter1 = LPF.ar(gagaku, 6000);
    sigA = filter1 * mod1;
    filter2 = HPF.ar(sigA, 6000);
    sigB = filter2 * mod2;
    sigB = sigB * gain2;
    filter3 = LPF.ar(sigB, 5500);
    sigD = filter3 * ringblvl;
    sigC = sigA * (-10.dbamp);
    snd = sigC + sigD;
    Out.ar(out, snd*0.5);
}).send(s);
)

a = Synth(\gagaku_schaltungstruktur3, [\buf, b, \startpos, 1102500]);

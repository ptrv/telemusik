// Struktur 6, 7

(
var tableValueCount = [1, 3, 5, 2, 5, 4, 5, 3, 4] * 16;
var tableValuePeaks1 = [-1, 1, -1, 1, -1, 1, -1, 1, -1];
var tableValuePeaks2 = [0, 1, 0, 1, 0, 1, 0, 1, 0];
var tableArray = FloatArray.new(512);

// fill tableArray
tableValueCount.do({ arg item, i;
    item.do { |num|
        tableArray = tableArray.add(tableValuePeaks1[i]);
        // tableArray = tableArray.add(tableValuePeaks2[i]);
    };
});

tableArray.plot;

~tableBuffer = Buffer.loadCollection(s, tableArray);
)

// { Osc.ar(~tableBuffer, EnvGen.ar(Env([300, 300], [5]), doneAction: 2)) * 0.3 }.play;

(
SynthDef(\struktur67, { arg out=0, buf=0, eqfreq1=5000, eqfreq2=8000,
    eqfreq3=11000, eqdb=(-50), amp1=1, amp2=0.2, amp3=0.2, amp=1;
    //var snd;
    var rq = 0.47369913372658;
    // var rq = 1;
    // var snd = Osc.ar(buf, XLine.ar(300, 0.1, 20, doneAction: 2)) * 0.3;
    var freqenvlvl = NamedControl.kr(\freqenvlvl, [300, 300,(1/4.5)]);
    var freqenvdur = NamedControl.kr(\freqenvdur, [0, 27]);
    var freqenv = Env(freqenvlvl, freqenvdur, [\exp]);
    var freqenvgen = EnvGen.ar(freqenv, doneAction: 2);
    var snd = Osc.ar(buf, freqenvgen);
    // var sndeq1 = MidEQ.ar(snd, eqfreq1, rq, eqdb) * amp1;
    // var sndeq2 = MidEQ.ar(snd, eqfreq2, rq, eqdb) * amp2;
    // var sndeq3 = MidEQ.ar(snd, eqfreq3, rq, eqdb) * amp3;
    var sndeq1 = BPF.ar(snd, eqfreq1, rq) * amp1;
    var sndeq2 = BPF.ar(snd, eqfreq2, rq) * amp2;
    var sndeq3 = BPF.ar(snd, eqfreq3, rq) * amp3;
    snd = (sndeq1 + sndeq2 + sndeq3) / 3;
    snd = snd * amp;
    Out.ar(out, snd);
}).send(s);
)

// Track 1
(
var synth1, synth2;
synth1 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 16000,
        \eqfreq2, 2500,
        \eqfreq3, 80,
        \freqenvlvl, [300, 300, (1/4.5)],
        \freqenvdur, [0, 27]
    ]
);
synth2 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 12500,
        \eqfreq2, 2000,
        \eqfreq3, 100,
        \freqenvlvl, [270, 270, (1/4.5)],
        \freqenvdur, [1, 26]
    ]
);
)

// Track 2
(
var synth1, synth2;
synth1 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 1000,
        \eqfreq2, 1600,
        \eqfreq3, 125,
        \freqenvlvl, [225, 225, (1/4.5)],
        \freqenvdur, [3, 24]
    ]
);
synth2 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 8000,
        \eqfreq2, 1250,
        \eqfreq3, 160,
        \freqenvlvl, [192, 192, 0.2222],
        \freqenvdur, [4, 23]
    ]
);
)

// Track 3
(
var synth1, synth2;
synth1 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 6300,
        \eqfreq2, 1000,
        \eqfreq3, 200,
        \freqenvlvl, [160, 160, (1/4.5)],
        \freqenvdur, [5, 22]
    ]
);
synth2 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 5000,
        \eqfreq2, 800,
        \eqfreq3, 250,
        \freqenvlvl, [130, 130, 0.2222],
        \freqenvdur, [7, 20]
    ]
);
)

// Track 4
(
var synth1, synth2;
synth1 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 4000,
        \eqfreq2, 630,
        \eqfreq3, 315,
        \freqenvlvl, [100, 100, (1/4.5)],
        \freqenvdur, [10, 17]
    ]
);
synth2 = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \amp, 0.2,
        \eqfreq1, 3155,
        \eqfreq2, 500,
        \eqfreq3, 400,
        \freqenvlvl, [70, 70, 0.2222],
        \freqenvdur, [12, 15]
    ]
);
)

// Track 5

b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/s67_1_2_3_4.wav");
b.play
(
SynthDef(\ringmods67, { |out=0, buf=0, amp=1|
    var snd;
    var in = PlayBuf.ar(1, buf);
    var rmodlvls = Control.names(\rmodlvls).kr([2400, 2400, 2200, 2900, 2700, 2100, 2500, 3000]);
    var rmoddurs = Control.names(\rmoddurs).kr([3, 1, 1,2, 3, 2, 1]);
    var rmodenv = Env(rmodlvls, rmoddurs);
    var rmodenvgen = EnvGen.ar(rmodenv, doneAction: 2);
    // var snd = in * SinOsc.kr(rmodenvgen);
    snd = in * SinOsc.ar(rmodenvgen);

    Out.ar(out, snd * amp)
}).send(s);
)

Synth(\ringmods67, [\buf, b, \amp, 3])

(
SynthDef(\ringmods67ampenv, { |out=0, buf=0, amp=1|
    var snd;
    var in = PlayBuf.ar(1, buf);
    var rmodlvls = Control.names(\rmodlvls).kr([2400, 2400, 2200, 2900, 2700, 2100, 2500, 3000]);
    var rmoddurs = Control.names(\rmoddurs).kr([3, 1, 1,2, 3, 2, 1]);
    var rmodenv = Env(rmodlvls, rmoddurs);
    var rmodenvgen = EnvGen.ar(rmodenv, doneAction: 2);
    // var snd = in * SinOsc.kr(rmodenvgen);
    var ampenv = Env([0, 0, -5.dbamp, -5.dbamp, 0, 0, -10.dbamp, -10.dbamp, 0, 0, -7.dbamp, -7.dbamp, 0, 0, -7.dbamp, -7.dbamp, 0, 0, -5.dbamp, 0, 0, -5.dbamp, -5.dbamp, 0, 0, -5.dbamp, -5.dbamp, 0, 0], [1, 0.01, 0.38, 0.01, 1.6, 0.01, 0.38, 0.01, 0.6, 0.01, 0.38, 0.01, 0.6, 0.01, 0.38, 0.01, 1.6, 0.01, 1.49, 1.5, 0.01, 0.38, 0.01, 1.6, 0.01, 0.38, 0.01, 0.6]);
    var ampenvgen = EnvGen.ar(ampenv, doneAction: 0);

    snd = in * SinOsc.ar(rmodenvgen);

    Out.ar(out, snd * ampenvgen * amp)
}).send(s);
)

Synth(\ringmods67ampenv, [\buf, b, \amp, 3])

// samples

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
        // tableArray = tableArray.add(tableValuePeaks1[i]);
    };
});

tableArray.plot;

~tableBuffer = Buffer.loadCollection(s, tableArray);
)

// { Osc.ar(~tableBuffer, EnvGen.ar(Env([300, 300], [5]), doneAction: 2)) * 0.3 }.play;

(
SynthDef(\struktur67, { arg out=0, buf=0, eqfreq1=5000, eqfreq2=8000,
    eqfreq3=11000, eqdb=(-10), amp1=1, amp2=0.2, amp3=0.2, amp=1;
    //var snd;
    // var rq = 0.47369913372658;
    var rq = 1;
    // var snd = Osc.ar(buf, XLine.ar(300, 0.1, 20, doneAction: 2)) * 0.3;
    var snd = Osc.ar(buf, 300) * 0.3;
    var sndeq1 = MidEQ.ar(snd, eqfreq1, rq, eqdb) * amp1;
    var sndeq2 = MidEQ.ar(snd, eqfreq2, rq, eqdb) * amp2;
    var sndeq3 = MidEQ.ar(snd, eqfreq3, rq, eqdb) * amp3;
    snd = (sndeq1 + sndeq2 + sndeq3) / 3;
    snd = snd * amp;
    Out.ar(out, snd);
}).send(s);
)

(
a = Synth(\struktur67,
    [
        \buf, ~tableArray,
        \eqdb, -10,
        \amp, 0.2
    ]
);
)

a.set(\eqdb, -40)
a.set(\amp2, 1)
a.set(\amp3, 1)
a.set(\eqfreq1, 100)

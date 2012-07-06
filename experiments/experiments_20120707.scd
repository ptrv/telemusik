// =====================================================================
// SuperCollider Workspace
// =====================================================================

// experiments struktur 6 and 7.

s.boot
s.scope
{SoundIn.ar([0,1])}.scope
s.freqscope

b = Buffer.alloc(s, 1024, 1, completionMessage: { |buf|
        buf.sine1Msg((1..10).reciprocal, asWavetable: false);
});

// this should replicate the extra-harmonics problem
a = { Osc.ar(b, 36.midicps) * 0.3 }.play;
a.free;

b.write("/tmp/saw10.wav".standardizePath, "WAV");

b.free;


// convert to wavetable in the language
(
var f, data;

f = SoundFile.openRead("/tmp/saw10.wav".standardizePath);
if(f.isOpen) {
        data = Signal.newClear(f.numFrames);  // assuming 1 channel
        f.readData(data);
        f.close;

        data = data.asWavetable;
        b = Buffer.sendCollection(s, data);
} {
        "Couldn't open file.".warn;
};
)
b.plot
// sounds good
a = { Osc.ar(b, Line.ar(100, 0.5, 10, doneAction: 2)) * 0.3 }.play;
a.free;

b.free


// -----------

512/30

512/32

1+3+5+2+5+4+5+3+4 * 16

a = [1, 3, 5, 2, 5, 4, 5, 3, 4] * 16
d = [-1, 1, -1, 1, -1, 1, -1, 1, -1]
d = [0, 1, 0, 1, 0, 1, 0, 1, 0]

c = FloatArray.new(512);

(
a.do({ arg item, i;
    item.do { |num|
        c = c.add(d[i]);
    };
})
)
c.size
c.plot
b = Buffer.loadCollection(s, c);
{ Osc.ar(b, Line.ar(0.5, 0.5, 10, doneAction: 2)) * 0.3 }.play;

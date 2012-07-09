// Helper GUIs for synthdefs.


// Struktur 3
(
a = Synth(\struktur3);

w = Window.new;
c = Slider(w, Rect(20, 60, 20, 150))
.action_({
    a.set(\lvl1, c.value)
});
c.value = 1.0;
d = Slider(w, Rect(50, 60, 20, 150))
.action_({
    a.set(\lvl2, d.value)
});
d.value = 1.0;
e = Slider(w, Rect(80, 60, 20, 150))
.action_({
    a.set(\lvl3, e.value)
});
e.value = 1.0;
f = Slider(w, Rect(120, 60, 20, 150))
.action_({
    a.set(\lvl4, f.value)
});
f.value = 1.0;
g = Slider(w, Rect(150, 60, 20, 150))
.action_({
    a.set(\lvl5, g.value)
});
g.value = 1.0;

w.onClose = { a.free;};
w.front;
)


// Gagaku-Schaltung
b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/07_-_Seigaiha.wav");
b = Buffer.read(s, "/home/peter/scwork/sub_repos/telemusik/snd/12_-_Motomeko_No_Uta.wav");
b.query


(
a = Synth(\gagaku_schaltung, [\buf, b, \startpos, 1000000]);

w = Window.new("GAGAKU-SCHALTUNG", Rect(20, 20, 300, 330));
w.view.decorator = FlowLayout( w.view.bounds, 5@5, 10@5 );

StaticText(w, Rect(0, 0, 20, 20)).string = "a1";
c = Slider(w, Rect(20, 60, 20, 150))
.action_({
    a.set(\gain1, c.value)
});
c.value = 1.0;
StaticText(w, Rect(0, 0, 30, 20)).string = "a2";
d = Slider(w, Rect(50, 60, 20, 150))
.action_({
    a.set(\gain2, d.value)
});
d.value = 1.0;
StaticText(w, Rect(0, 0, 30, 20)).string = "a3";
e = Slider(w, Rect(80, 60, 20, 150))
.action_({
    a.set(\gain3, e.value)
});
e.value = 1.0;
w.view.decorator.nextLine;
StaticText(w, Rect(0, 0, 50, 20)).string = "freq A";
f = Slider(w, Rect(120, 60, 20, 150))
.action_({
    a.set(\m1, f.value*12000)
});
f.value = 12000.0;
StaticText(w, Rect(0, 0, 50, 20)).string = "freq B";
g = Slider(w, Rect(150, 60, 20, 150))
.action_({
    a.set(\m2, g.value*100 + 11900)
});
g.value = 12000.0;

w.onClose = { a.free;};
w.front;
)

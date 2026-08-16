MIDI.R4D
========

Erster MIDI-SynthEngine-/Router-Platzhalter fuer R4OS.

Ziel:
- gueltige MIDI.R4D-Datei erzeugen
- Treibertyp synth verwenden
- aus Zig ueber das gepinnte R4OS-SDK bauen
- seit 0.45.20 DriverApi-v12 `register_synth_engine_v2` ueber den
  SDK-Wrapper `registerSynthEngineEx` aufrufen
- R4Synth einen sichtbaren MIDI-Zielpfad geben; MIDIPLAY bleibt nur noch als
  Diagnosewerkzeug erhalten

Noch nicht enthalten:
- MIDI-Datei-Parsing im Treiber
- Event-Scheduling
- Routing an OPL3
- PCM-Erzeugung

Eigenstaendiges Repository
--------------------------

Dieses Verzeichnis ist ein eigenstaendiges R4OS-SDK-Projekt fuer MIDI.R4D.

Build:

    Build.bat

Artefakt:

    D:\R4OS\Artifacts\Modules\MIDI\MIDI.R4D

`Settings.R4S` mappt SDK, Contract, DevKit, Zig und die Artefaktausgabe. Alle
Werte beginnen am Repository-Root und duerfen relativ oder absolut sein.

Manifest:

    module.R4MF

Image-Zielpfad: C:\R4OS\DRIVERS\MIDI.R4D

Herkunft und Transfergrenzen stehen in `PROVENANCE.txt`.

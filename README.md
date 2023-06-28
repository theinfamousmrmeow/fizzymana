# fizzymana
Open-Source Particle Generator Tool for GameMaker

Problem Statement:
We're making a game about casting spells which relies heavily on Particles inherently
GMS2 has a Particle System editor now, but there's actually no way to spawn the particles you design in those
You have to spawn the whole system, which we can't do, because we can't change the depth correctly then (or change position correctly actually)
We looked at just using https://gamemakercasts.itch.io/particle-editor, the main problem here is that it can only show one emitter and one particle at a time, which makes it hard to do anything rich.
With any current editor, managing the number of particles you'd need to ship a game becomes a chore.
We want a system to save/load a number of definitions in a Folder, then select the particle to edit from a dropdown.

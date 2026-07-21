# Fakeformers

Fakeformers creates concept images for early-1980s-style transforming robot toys. Each image shows the same toy in two modes:

1. Robot mode above
2. Alternate mode below

The core goal is physical transformation consistency. The robot must be visibly built from the alternate form's real parts rather than designed as a generic humanoid with themed decorations.

## Quick start

Start a task in this folder and enter a one-line request:

```text
Blue-ringed octopus, vintage
```

Other examples:

```text
Caterpillar D10 bulldozer, photoreal
Grandfather clock, schematic
Plymouth Superbird, sketch
Great horned owl, G1
```

That is enough. The agent selects the correct subject rules, assembles the source documents, and generates one image. If no finish is supplied, it defaults to `sketch`.

Optional details can be added naturally on the same line:

```text
Blue-ringed octopus, vintage, cobalt and cream, cautious scout, no weapon
```

## Finishes

- `sketch`: colored-pencil and ink concept art on graph paper
- `photoreal`: realistic studio product photography of a manufactured toy
- `vintage`: softly photographed 1984–1986 toy-catalog appearance
- `schematic`: precise monochrome technical line art
- `G1`: a simplified, chunky 1984–1986 Generation 1-style transforming toy catalog photograph

## How the project is organized

- `AGENTS.md` routes one-line requests and defines workflow and precedence.
- `01 Shared Design Rules.md` contains universal transformation architecture.
- `02` through `05`, plus `13 G1 Finish.md`, define the visual finishes.
- `06 Subject Specification.md` is an optional request-writing guide.
- `07 Prompt Assembly.md` defines the selected-source order.
- `08 Style Guide.md` defines the common toy-design era.
- `09 Negative Prompt.md` lists cross-cutting failures.
- `10` through `12` define animal, vehicle, and object mapping.
- `scripts/assemble_prompt.sh` produces the exact combined prompt when inspection or debugging is useful.
- `TESTING.md` provides repeatable test subjects and a scoring checklist.
- `original prompt.md` is retained only as a historical reference.

## Prompt inspection

Normal image requests do not need a script. To inspect the exact assembled text while debugging, use:

```text
bash scripts/assemble_prompt.sh vintage animal "Blue-ringed octopus"
```

The generated prompt is printed for inspection; no files are changed.

## Public gallery

The repository contains a lightweight GitHub Pages gallery. It discovers all committed concept-sheet images automatically, and the deployment workflow publishes the gallery every time `main` receives a push.

The deployment workflow enables GitHub Pages on its first successful run. The gallery will be available at `https://jonesco.github.io/fakeformers/`.

# Fakeformers Image Project

This project creates one-image concept sheets for transforming robot toys.

## One-line image requests

A user may request a design with only an alternate form and a finish.

Examples:

- `Japanese spider crab, vintage`
- `1970 Plymouth Superbird — photoreal`
- `Grandfather clock; schematic`
- `Squid, sketch`

Treat any similarly clear line as a complete image request. Do not ask the user to fill in a template, confirm the subject, approve a prompt, or supply optional details.

If the finish is omitted, use `sketch`.

Recognized finishes:

- `sketch`
- `photoreal`
- `vintage`
- `schematic`
- `G1`

Natural aliases are acceptable when unambiguous, such as `realistic` for photoreal, `1980s catalog` for vintage, `technical drawing` for schematic, or `Generation One` for G1.

For a clear image request, assemble the selected sources, use the available `imagegen` skill, and generate exactly one image immediately. Keep any introduction to one short sentence at most. Do not display the assembled prompt unless the user asks for it.

## Source selection

Use these sources in this order:

1. `01 Shared Design Rules.md`
2. Exactly one selected Finish document
3. Exactly one selected subject-type document
4. The user's entire request as the completed Subject Specification
5. `08 Style Guide.md`
6. `09 Negative Prompt.md`

Finish documents:

- `02 Sketch Finish.md`
- `03 Photoreal Finish.md`
- `04 Vintage Finish.md`
- `05 Schematic Finish.md`
- `13 G1 Finish.md`

Subject-type documents:

- `10 Animal Rules.md` for living creatures and biological organisms
- `11 Vehicle Rules.md` for vehicles and mobile machines
- `12 Object Rules.md` for stationary manufactured objects, tools, devices, appliances, instruments, and structures

Construction vehicles use Vehicle Rules even when they contain blades, buckets, booms, cranes, drills, or forks.

For an ambiguous subject, choose the category that defines the alternate form's primary identity:

- Anatomy or biology: Animal Rules
- Transportation or mobility: Vehicle Rules
- Stationary manufactured form or function: Object Rules

Use exactly one finish and one subject type unless the user explicitly requests a hybrid.

`original prompt.md` is a legacy reference. Do not load or assemble it for image requests.

`06 Subject Specification.md` is an optional user-facing request guide. Do not append its blank template to an image prompt.

After choosing the finish and subject type, use `scripts/assemble_prompt.sh` to compile the exact selected source text and the full user request. Supply that assembled text to image generation. Do not replace the source documents with a loose summary.

## Instruction precedence

Resolve overlap by scope, not merely by file order:

1. The user's explicit current request always wins.
2. The selected Finish controls medium, materials, background, lighting, presentation, page layout, camera/viewpoint, pose overrides, and accessory presentation.
3. The selected subject-type document controls alternate-form identity and how its anatomy, structure, or function maps into robot mode.
4. Shared Design Rules control universal transformation architecture, robot anatomy, part accounting, and cross-mode consistency.
5. Style Guide supplies the overall era and design language.
6. Negative Prompt prevents recurring failures but never cancels a requirement of the selected Finish or subject type.

An explicit rule in a more specific scope overrides a general rule only within that scope. For example, Schematic Finish may override the default robot pose without weakening transformation consistency.

## Image requirements

Generate exactly one image file on one portrait canvas.

It must contain exactly two primary depictions:

1. Upper: full humanoid robot mode
2. Lower: complete alternate mode

Only Schematic Finish may add one small separate accessory depiction when the established design includes a removable weapon.

Do not generate variations, extra concepts, extra angles, transformation steps, or multiple image files unless explicitly requested.

Before calling image generation, silently complete the transformation architecture and hard-gate checklist in Shared Design Rules. Do not show that internal work unless asked.

## Revisions

When the user critiques an image, edit the existing image when it is available. Preserve everything the user did not ask to change. Make only the requested correction plus any directly necessary adjustment for transformation consistency.

## Publishing generated images

When this project has a configured `origin` remote, every completed user-requested image saved under `images/` must be staged by its exact path, committed, and pushed to `origin/main` after generation. This triggers the public gallery deployment.

Stage only the newly generated image and any directly required gallery or workflow files. Never include unrelated user changes in an automatic image-publishing commit.

The public gallery discovers committed `.png`, `.jpg`, `.jpeg`, and `.webp` concept sheets automatically. Do not maintain a manual image manifest.

## Task titles

When the current Codex or chat surface permits task-title changes, use the concise alternate-form subject, such as `Squid`, `Blue-Ringed Octopus`, `Caterpillar Bulldozer`, or `Grandfather Clock`.

Do not include the finish, personality, colors, or the phrase “robot that transforms into” unless needed to distinguish the subject.

## Non-image requests

When the user asks about the rules, project structure, or source documents, answer or edit the files instead of generating an image.

When changing source documents:

- Put universal transformation requirements in Shared Design Rules.
- Put rendering and presentation requirements in the relevant Finish file.
- Put subject anatomy, structure, or function requirements in its subject-type file.
- Keep Negative Prompt limited to cross-cutting recurring failures.
- Avoid contradictory duplicate rules.
- Preserve useful existing content.

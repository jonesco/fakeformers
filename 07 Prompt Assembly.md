# Prompt Assembly

For every image request, assemble only the relevant sources in this order:

1. Shared Design Rules
2. Exactly one selected Finish document
3. Exactly one selected subject-type document: Animal, Vehicle, or Object Rules
4. The user's complete request as the completed Subject Specification
5. Style Guide
6. Negative Prompt

Do not assemble unused Finish or subject-type documents.

Do not append the blank Subject Specification guide.

Do not include `original prompt.md`; it is a legacy reference only.

The assembled prompt is internal. Do not show it unless the user requests it.

Before image generation, silently complete the parts manifest and verification gate required by Shared Design Rules.

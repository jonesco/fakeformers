const repository = "jonesco/fakeformers";
const branch = "main";
const gallery = document.querySelector("#gallery");
const status = document.querySelector("#gallery-status");
const siteBase = new URL(".", window.location.href);

function titleFromPath(path) {
  return path
    .split("/")
    .pop()
    .replace(/\.[^.]+$/, "")
    .replace(/[-_]+/g, " ")
    .replace(/\b\w/g, (letter) => letter.toUpperCase());
}

function revisionFor(path) {
  const name = path.split("/").pop().replace(/\.[^.]+$/, "");
  const match = name.match(/-v(\d+)$/i);
  return Number(match?.[1] ?? 1);
}

function baseNameFor(path) {
  return path
    .split("/")
    .pop()
    .replace(/\.[^.]+$/, "")
    .replace(/-v\d+$/i, "");
}

function latestRevisions(paths) {
  const latest = new Map();

  for (const path of paths) {
    const baseName = baseNameFor(path);
    const existing = latest.get(baseName);
    if (!existing || revisionFor(path) > revisionFor(existing)) {
      latest.set(baseName, path);
    }
  }

  return [...latest.values()].sort((a, b) => titleFromPath(a).localeCompare(titleFromPath(b)));
}

function renderConcept(path) {
  const title = titleFromPath(path);
  const card = document.createElement("article");
  card.className = "concept-card";

  const link = document.createElement("a");
  link.href = new URL(path.split("/").map(encodeURIComponent).join("/"), siteBase).href;
  link.target = "_blank";
  link.rel = "noreferrer";
  link.setAttribute("aria-label", `Open ${title}`);

  const image = document.createElement("img");
  image.src = link.href;
  image.alt = `${title} transforming robot concept sheet`;
  image.loading = "lazy";
  image.decoding = "async";

  const heading = document.createElement("h3");
  heading.textContent = title;

  link.append(image);
  card.append(link, heading);
  return card;
}

async function loadConcepts() {
  try {
    const response = await fetch(
      `https://api.github.com/repos/${repository}/git/trees/${branch}?recursive=1`,
      { cache: "no-store" },
    );

    if (!response.ok) throw new Error("The repository image list is unavailable.");

    const data = await response.json();
    const imagePaths = data.tree
      .filter((entry) => entry.type === "blob" && /\.(?:png|jpe?g|webp)$/i.test(entry.path))
      .map((entry) => entry.path);
    const concepts = latestRevisions(imagePaths);

    if (!concepts.length) {
      status.textContent = "The first concept sheet will appear here soon.";
      return;
    }

    gallery.replaceChildren(...concepts.map(renderConcept));
    status.textContent = `${concepts.length} concept ${concepts.length === 1 ? "sheet" : "sheets"} in the collection`;
  } catch (error) {
    status.textContent = "The collection is temporarily unavailable. Please try again shortly.";
  }
}

loadConcepts();
